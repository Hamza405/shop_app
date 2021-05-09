import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) imagePickFn;
  final String imageUrl;
  bool isEdit;
  UserImagePicker(this.imagePickFn,this.imageUrl,this.isEdit);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  final picker = ImagePicker();
  File _image;
  _pickImage() async {
    final image = await picker.getImage(
        source: ImageSource.gallery, imageQuality: 75, maxWidth: 150);
    setState(() {
      _image = File(image.path);
    });
    widget.imagePickFn(File(image.path));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(top: 8, right: 10),
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child:widget.isEdit? Image.network(widget.imageUrl):_image == null
                ? Center(
                    child: Text('Pleae enter your image',
                        textAlign: TextAlign.center),
                  )
                : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  )),
        TextButton(
          onPressed: _pickImage,
          child: Text('Add Image'),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.green,
            onSurface: Colors.grey,
            shadowColor: Colors.grey,
            elevation: 5,
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
      ],
    );
  }
}
