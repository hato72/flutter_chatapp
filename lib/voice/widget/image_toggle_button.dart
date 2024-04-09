import 'package:flutter/material.dart';
//import 'package:flutter_chatapp/voice/widget/TextAndVoiceField.dart';

class ImageToggleButton extends StatefulWidget{
  final VoidCallback _selectImage;
  final VoidCallback _readImage;
  final bool _isSelecting;
  final bool _isReading;

  const ImageToggleButton({
    super.key, 
    required bool isSelecting,
    required bool isReading,
    required VoidCallback selectImage,
    required VoidCallback readImage
  }) : 
      _selectImage = selectImage,
      _readImage = readImage,
      _isSelecting = isSelecting,
      _isReading = isReading;

  @override
  State<ImageToggleButton> createState() => _ImageToggleButtonState();
}

class _ImageToggleButtonState extends State<ImageToggleButton>{
  @override
  Widget build(BuildContext context){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
      ),
      //onPressed: () {},
      onPressed: widget._isReading? null : widget._isSelecting  
        ? widget._readImage
        : widget._selectImage,
      child: Icon(
        widget._isReading? Icons.add_photo_alternate : widget._isSelecting? Icons.insert_photo : Icons.add_photo_alternate,
      ),
    );
  }
}