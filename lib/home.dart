// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_profile/image_helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.initials});

  final String title;
  final String initials;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final heler =
    ImageHelper(imagePicker: ImagePicker(), imageCropper: ImageCropper());

class _MyHomePageState extends State<MyHomePage> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 64,
                foregroundImage: image != null ? FileImage(image!) : null,
                child: Text(widget.initials),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final images = await heler.pickImage();
          if (images.isNotEmpty) {
            final crope = await heler.cropeImage(
              file: images.first!,
              cropStyle: CropStyle.circle,
            );
            if (crope != null) {
              setState(() {
                image = File(crope.path);
              });
            }
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
