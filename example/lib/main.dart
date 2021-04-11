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
