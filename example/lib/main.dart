import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:opencv_awesome/opencv_awesome.dart';
import 'dart:async';
import 'dart:io';
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
  List<String> horizontal_path_list=[];
  List<String> vertical_path_list=[];
  String horizontal_output_path;
  String vertical_output_path;
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
                : SingleChildScrollView(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(height: 20,),
                     Text("horizontal panorama",style: TextStyle(fontSize: 20),),
                     SizedBox(height: 20,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(horizontal_path_list.length, (index) => Container(
                          width: 180,
                          child: Image.file(File(horizontal_path_list[index])),
                        ),),),
                    ),
                    SizedBox(height: 20,),
                    horizontal_output_path!=null
                        ? Center(
                      child: Container(
                        height: 180,
                          child: Image.file(File(horizontal_output_path),fit: BoxFit.fill,),
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
                                horizontal_path_list.add(path);
                              });
                            },
                            child: Text("Add Image LTR ",style: TextStyle(color: Colors.white)),
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
                               setState(() {
                                horizontal_path_list=[];
                                horizontal_output_path=null;
                              });
                            },
                            child: Text("Reset",style: TextStyle(color: Colors.white)),
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
                          onPressed: horizontal_path_list.length>1
                              ? () async{
                            setState(() {
                              _isWorking=true;
                            });
                            String dirpath= (await getApplicationDocumentsDirectory()).path+"/"+DateTime.now().toString()+"_.jpg";
                             await  OpencvAwesome.stitch_horizontally(horizontal_path_list, dirpath,oncompletedHorizontal);
                          }
                              : null,
                          child: Text("Process",style: TextStyle(color: Colors.white),),
                        )),

                     SizedBox(height: 50,),
                     SizedBox(height: 20,),
                     Text("Vertical panorama",style: TextStyle(fontSize: 20),),
                     SizedBox(height: 20,),
                     vertical_output_path!=null
                         ? Center(
                       child: Container(
                         width: 180,
                         child: Image.file(File(vertical_output_path),fit: BoxFit.fill,),
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
                                   vertical_path_list.add(path);
                                 });
                               },
                               child: Text("Add Image TTB",style: TextStyle(color: Colors.white)),
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
                                 setState(() {
                                   vertical_path_list=[];
                                   vertical_output_path=null;
                                 });
                               },
                               child: Text("Reset",style: TextStyle(color: Colors.white)),
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
                           onPressed: vertical_path_list.length>1
                               ? () async{
                             setState(() {
                               _isWorking=true;
                             });
                             String dirpath= (await getApplicationDocumentsDirectory()).path+"/"+DateTime.now().toString()+"_.jpg";
                             await  OpencvAwesome.stitch_vertically(vertical_path_list, dirpath,oncompletedVertical);
                           }
                               : null,
                           child: Text("Process",style: TextStyle(color: Colors.white),),
                         )),
                     SizedBox(height: 20,),
                     SingleChildScrollView(
                       scrollDirection: Axis.horizontal,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: List.generate(vertical_path_list.length, (index) => Container(
                           width: 180,
                           child: Image.file(File(vertical_path_list[index])),
                         ),),),
                     ),



                   ]),
                )));
  }
  void oncompletedHorizontal(dirpath){
    setState(() {
      horizontal_output_path=dirpath;
      _isWorking=false;
    });
  }
  void oncompletedVertical(dirpath){
    setState(() {
      vertical_output_path=dirpath;
      _isWorking=false;
    });
  }
  Future<String> take_image() async {
    File imagefile = await ImagePicker.pickImage(source: ImageSource.camera);
    return imagefile.path;
  }
}
