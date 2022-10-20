import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  String result = '';
  late ImagePicker imagePicker;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();

    //TODO initialize detector

  }

  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    File image = File(pickedFile!.path);
    setState(() {
      _image = image;
      if (_image != null) {
        doTextRecognition();
      }
    });
  }

  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    File image = File(pickedFile!.path);
    setState(() {
      _image = image;
      if (_image != null) {
        doTextRecognition();
      }
    });
  }

  //TODO perform text recognition
  doTextRecognition() async {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg2.jpg'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const SizedBox(
                width: 100,
              ),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/notebook.png'),
                      fit: BoxFit.cover),
                ),
                height: 280,
                width: 250,
                margin: const EdgeInsets.only(top: 70),
                padding: const EdgeInsets.only(left: 28, bottom: 5, right: 18),
                child: SingleChildScrollView(
                    child: Text(
                  result,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 10),
                )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, right: 140),
                child: Stack(children: <Widget>[
                  Center(
                    child: Image.asset(
                      'images/clipboard.png',
                      height: 240,
                      width: 240,
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: _imgFromGallery,
                      onLongPress: _imgFromCamera,
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: _image != null
                            ? Image.file(
                                _image!,
                                width: 140,
                                height: 192,
                                fit: BoxFit.fill,
                              )
                            : Container(
                                width: 140,
                                height: 150,
                                child: Icon(
                                  Icons.find_in_page,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
