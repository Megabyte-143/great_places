import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_pro;

class ImageInput extends StatefulWidget {
  //const ImageInput({Key? key}) : super(key: key);

  Function onselectImage;

  ImageInput(this.onselectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage = File('');

  Future<void> _takeimage() async {
    final imagePicker = ImagePicker();
    final imageFile =
        await imagePicker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await path_pro.getApplicationDocumentsDirectory();
    final imageFileName = path.basename(imageFile.path);
    final savedImagePath =
        await File(imageFile.path).copy('${appDir.path}/$imageFileName');

    widget.onselectImage(savedImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: _storedImage != File('')
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "Enter Image",
                  textAlign: TextAlign.center,
                ),
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takeimage,
            icon: Icon(Icons.camera),
            label: Text("Take Picture"),
          ),
        ),
      ],
    );
  }
}
