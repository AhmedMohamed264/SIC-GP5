import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class VideoStreamPage extends StatefulWidget {
  @override
  _VideoStreamPageState createState() => _VideoStreamPageState();
}

class _VideoStreamPageState extends State<VideoStreamPage> {
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://ahmedafifi-lt:5283/LiveFeed'),
  );
  Uint8List? _lastFrame; // Cache the last frame

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Video Stream'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: _channel.stream,
          builder: (context, snapshot) {
            log('snapshot: $snapshot');
            if (snapshot.hasData) {
              // Cache the new frame
              _lastFrame = snapshot.data as Uint8List;

              // Smooth transition between frames using FadeInImage
              return FadeInImage(
                placeholder: MemoryImage(_lastFrame!),
                image: MemoryImage(_lastFrame!),
                fadeInDuration: Duration(milliseconds: 50), // Fast fade-in
                fit: BoxFit.cover,
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // Display the last cached frame, or a loader if no frames yet
            return _lastFrame != null
                ? Image.memory(_lastFrame!, fit: BoxFit.cover)
                : CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
