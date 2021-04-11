# Opencv Awesome


## Overview

A Flutter plugin providing the ability to use opencv native c++ implementation for image stitching in flutter projects.

The plugin is supported for android only and will be extended for ios in future.

**Features:**
  1. Stitch images using high level stitching APIs of opencv.
  2. Create full panorama image taking care of overlap region.

![alt preview](https://i.ibb.co/dp1ft8P/Screenshot-1618131260.png)

 ## Image format:

- PNG
- JPEG
- JPG

 ## prerequisite:
1. Ndk configuration
2. add ndk support to your project
3. opencv sdk
  - Download the opencv sdk from https://opencv.org/releases/

  - add opencv sdk to the location "C:/opencv/OpenCV-android-sdk/" or you can edit the cmakefile of plugin "CMakeLists.txt" 
4. Add read and write storage permission to your project  


## Example

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:opencv_awesome/opencv_awesome.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isWorking = false;
  String path1;
  String path2;
  String output_path;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('opencv_awesome example'),
            ),
            body: _isWorking
                ? Center(child: CircularProgressIndicator())
                : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    path1!=null
                        ? Center(
                      child: Container(
                        width:  140,
                        height: 200,
                        child: Image.file(File(path1)),
                      ),
                    )
                        : Container(),
                    path2!=null
                        ? Center(
                      child: Container(
                        width: 140,
                        height: 200,
                        child: Image.file(File(path2)),
                      ),
                    )
                        : Container(),


                  ],),
                  SizedBox(height: 10,),
                  output_path!=null
                      ? Center(
                    child: Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(image: FileImage(File(output_path),),fit: BoxFit.fill)
                      ),
                    ),
                  )
                      : Container(),

                  SizedBox(
                    height: 10,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: MaterialButton(
                          color: Colors.green,
                          onPressed: () async {
                            var path = await take_image();
                            setState(() {
                              path1 = path;
                            });
                          },
                          child: Text("Add Image 1",style: TextStyle(color: Colors.white)),
                        )),
                    //
                    SizedBox(
                      width: 30,
                    ),
                    // This trailing comma makes auto-formatting nicer for build methods.
                    Center(
                        child: MaterialButton(
                          color: Colors.green,
                          onPressed: () async {
                            var path = await take_image();
                            setState(() {
                              path2 = path;
                            });
                          },
                          child: Text("Add Image 2",style: TextStyle(color: Colors.white)),
                        )),

                  ],
                ) , // T
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: MaterialButton(
                        color: Colors.green,
                        disabledColor: Colors.black38,
                        onPressed: path1 != null && path2 != null
                            ? () async{
                          setState(() {
                            _isWorking=true;
                          });
                          String dirpath= (await getApplicationDocumentsDirectory()).path+"/"+DateTime.now().toString()+"_.jpg";
                          List<String> img_paths = [path1, path2];
                           await  OpencvAwesome.stich_horizontal(img_paths, dirpath,oncompleted);
                        }
                            : null,
                        child: Text("Process",style: TextStyle(color: Colors.white),),
                      )),
                ])));
  }
  void oncompleted(dirpath){
    setState(() {
      output_path=dirpath;
      _isWorking=false;
    });
  }

  Future<String> take_image() async {
    File imagefile = await ImagePicker.pickImage(source: ImageSource.camera);
    return imagefile.path;
  }
}

```
