import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widget_to_image_and_save/icon_widget.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyScreenShotApp(),
    );
  }
}

class MyScreenShotApp extends StatefulWidget {
  const MyScreenShotApp({super.key});

  @override
  State<MyScreenShotApp> createState() => _MyScreenShotAppState();
}

class _MyScreenShotAppState extends State<MyScreenShotApp> {
  final screenShotController = ScreenshotController();
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => captureAndSave(),
              child: const Text('Click to take screenshot'),
            ),
            Screenshot(
              controller: screenShotController,
              child: IconWidget(
                changeColor: changeColor,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> captureAndSave() async {
    Uint8List? imageBytes = await screenShotController.capture();
    dev.log(imageBytes.toString());
    if (imageBytes != null) {
      saveImage(
        '${color.value}.png',
        imageBytes,
      );
    }
  }

  Future<void> saveImage(
    String fileName,
    Uint8List imageData,
  ) async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      Directory directory;
      directory = Directory('/storage/emulated/0/Visiting Card Maker');
      if (!await directory.exists()) {
        directory.create();
      }
      dev.log(directory.path);
      File file = File('${directory.path}/$fileName');
      await file.writeAsBytes(imageData);
      final result = GallerySaver.saveImage('${directory.path}/$fileName',
          albumName: 'Visiting Card Maker');
      dev.log(result.toString());
    }
  }

  void changeColor() {
    setState(() {
      final random = Random();
      final r = random.nextInt(256);
      final g = random.nextInt(256);
      final b = random.nextInt(256);

      color = Color.fromRGBO(r, g, b, 1.0);
    });
  }
}
