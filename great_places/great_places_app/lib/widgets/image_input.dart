import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

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
    if (imageFile == null || imageFile.path.isEmpty) {
      return;
    }

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final storedFile = await _storedImage.copy(appDir.path);
    widget.onSelectImage(storedFile);
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
