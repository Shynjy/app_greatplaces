import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future _takePicture() async {
    // Atribuindo a dependência a essa variável
    final ImagePicker _picker = ImagePicker();

    // Pega da foto uma imagem
    PickedFile imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 800,
    );

    if (imageFile == null) return;

    setState(() {
      // atribua o path da imagem
      _storedImage = File(imageFile.path);
    });

    // widget.onSelectImage(...);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Text('Nenhuma imagem!'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            label: Text('Tirar Foto'),
            icon: Icon(Icons.camera),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
