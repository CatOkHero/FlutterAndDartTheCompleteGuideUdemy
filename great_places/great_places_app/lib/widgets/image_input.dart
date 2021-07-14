import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  late File _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = new ImagePicker();
    final imageFile = await imagePicker.getImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.green),
          ),
          child: _storedImage == null
              ? Text(
                  'No image taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: () => _takePicture(),
            icon: Icon(Icons.camera),
            label: Text('Take picture'),
          ),
        )
      ],
    );
  }
}
