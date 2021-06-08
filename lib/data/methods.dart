import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:opencv_awesome/modal/ProcessImage.dart';

typedef _version_func = Pointer<Utf8> Function();
 typedef _stitch_image_func = Void Function(Pointer<Utf8>, Pointer<Utf8>,Pointer<Utf8>);

 // Dart function signatures
 typedef _VersionFunc = Pointer<Utf8> Function();
 typedef _StitchImageFunc = void Function(Pointer<Utf8>, Pointer<Utf8>,Pointer<Utf8>);


 // Getting a library that holds needed symbols
 DynamicLibrary _lib = Platform.isAndroid
     ? DynamicLibrary.open('libnative_opencv.so')
     : DynamicLibrary.process();

 // Looking for the functions
 final _VersionFunc _version = _lib
     .lookup<NativeFunction<_version_func>>('version')
     .asFunction();
 final _StitchImageFunc _stitchImage = _lib
     .lookup<NativeFunction<_stitch_image_func>>('stitch_image')
     .asFunction();

class Methods{
  static stitchImageHorizontal(ProcessImageArguments args)async {

   _stitchImage(args.inputPath.toNativeUtf8(), args.outputPath.toNativeUtf8(),("horizontal").toNativeUtf8());
  }
  static stitchImageVertical(ProcessImageArguments args) {
    _stitchImage(args.inputPath.toNativeUtf8(), args.outputPath.toNativeUtf8(),("vertical").toNativeUtf8());
  }

}

