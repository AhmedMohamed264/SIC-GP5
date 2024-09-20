import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoStreamPage extends StatefulWidget {
  @override
  _VideoStreamPageState createState() => _VideoStreamPageState();
}

class _VideoStreamPageState extends State<VideoStreamPage> {
  final _channel =
      WebSocketChannel.connect(Uri.parse('ws://ahmedafifi-lt:5283/LiveFeed'));
  List<int> _imageBuffer = [];
  int _expectedSize = 0;
  int _receivedBytes = 0;
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _channel.stream.listen((data) {
      _handleWebSocketData(data);
    });
  }

  void _handleWebSocketData(dynamic data) {
    if (data is Uint8List) {
      // If we are expecting a new image size, process the first 4 bytes as the image size
      if (_expectedSize == 0 && data.length >= 4) {
        _expectedSize = _extractImageSize(data);
        _imageBuffer.clear();
        _receivedBytes = 0;

        // Remove the 4-byte size prefix and process the rest of the data
        _handleImageData(data.sublist(4));
      } else if (_expectedSize > 0) {
        // Add the incoming data to the buffer and track the number of received bytes
        _handleImageData(data);
      }
    }
  }

  void _handleImageData(Uint8List data) {
    _imageBuffer.addAll(data);
    _receivedBytes += data.length;

    // If we've received the complete image, render it
    if (_receivedBytes >= _expectedSize) {
      setState(() {
        _imageData = Uint8List.fromList(_imageBuffer);
      });

      // Reset for the next image
      _expectedSize = 0;
      _receivedBytes = 0;
    }
  }

  // Extract the first 4 bytes as the image size (assumes the server sends it first)
  int _extractImageSize(Uint8List data) {
    return ByteData.sublistView(data, 0, 4).getUint32(0, Endian.little);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Video Stream')),
      body: Center(
        child: _imageData != null
            ? Image.memory(_imageData!)
            : Text('Waiting for stream...'),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
