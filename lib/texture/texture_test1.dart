import 'package:flutter/material.dart';

import 'texture_plugin.dart';

void main() {
  runApp(MaterialApp(
    home: TextureApp(),
  ));
}

class TextureApp extends StatefulWidget {
  const TextureApp({super.key});

  @override
  State<TextureApp> createState() => _TextureAppState();
}

class _TextureAppState extends State<TextureApp> {
  int? textureId;

  final TexturePlugin plugin = TexturePlugin();

  @override
  void initState() {
    () async {
      textureId = await plugin.init(100, 100);
      setState(() {});
    }();
    super.initState();
  }

  @override
  void dispose() {
    plugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Texture 示例'),
      ),
      body: Center(
        child: textureId != null
            ? SizedBox(width: 100, height: 100, child: Texture(textureId: textureId!))
            : CircularProgressIndicator(),
      ),
    );
  }
}
