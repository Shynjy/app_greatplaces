import 'dart:io';
import 'package:flutter/material.dart';

// Dependência
import 'package:image_picker/image_picker.dart';

//Providers path
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

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

    // Cria e pega o caminho no dispositivo
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // Nome da imagem
    String fileName = path.basename(_storedImage.path);

    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
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
