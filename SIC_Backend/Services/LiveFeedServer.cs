using System.Net.WebSockets;

public class WebSocketHandler
{
    private static List<WebSocket> _sockets = new List<WebSocket>();

    public async Task HandleWebSocketAsync(HttpContext context)
    {
        if (context.WebSockets.IsWebSocketRequest)
        {
            WebSocket webSocket = await context.WebSockets.AcceptWebSocketAsync();
            _sockets.Add(webSocket); // Add new client to the list

            await ReceiveAndBroadcast(webSocket);

            // Once done, remove the client
            _sockets.Remove(webSocket);
            await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closing", CancellationToken.None);
        }
        else
        {
            context.Response.StatusCode = 400;
        }
    }

    private async Task ReceiveAndBroadcast(WebSocket webSocket)
    {
        var buffer = new byte[1024 * 4];

        while (webSocket.State == WebSocketState.Open)
        {
            var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);

            if (result.MessageType == WebSocketMessageType.Close)
            {
                await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closed by client", CancellationToken.None);
            }
            else
            {
                // Broadcast the message to all connected clients
                await BroadcastMessageAsync(buffer, result.Count);
            }
        }
    }

    private async Task BroadcastMessageAsync(byte[] message, int count)
    {
        var tasks = new List<Task>();

        foreach (var socket in _sockets.ToList()) // Use ToList to avoid collection modification issues
        {
            if (socket.State == WebSocketState.Open)
            {
                // Send the message to each connected client
                var task = socket.SendAsync(new ArraySegment<byte>(message, 0, count), WebSocketMessageType.Binary, true, CancellationToken.None);
                tasks.Add(task);
            }
        }

        // Await the completion of all sends
        await Task.WhenAll(tasks);
    }
}