import 'dart:ffi' as ffi;
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:opencv_awesome/modal/ProcessImage.dart';

typedef _version_func = ffi.Pointer<Utf8> Function();
 typedef _stitch_image_func = ffi.Void Function(ffi.Pointer<Utf8>, ffi.Pointer<Utf8>,ffi.Pointer<Utf8>);

 // Dart function signatures
 typedef _VersionFunc = ffi.Pointer<Utf8> Function();
 typedef _StitchImageFunc = void Function(ffi.Pointer<Utf8>, ffi.Pointer<Utf8>,ffi.Pointer<Utf8>);

 // Getting a library that holds needed symbols
 ffi.DynamicLibrary _lib = Platform.isAndroid
     ? ffi.DynamicLibrary.open('libnative_opencv.so')
     : ffi.DynamicLibrary.process();

 // Looking for the functions
 final _VersionFunc _version = _lib
     .lookup<ffi.NativeFunction<_version_func>>('version')
     .asFunction();
 final _StitchImageFunc _stitchImage = _lib
     .lookup<ffi.NativeFunction<_stitch_image_func>>('stitch_image')
     .asFunction();


class Methods{
  static stitchImageHorizontal(ProcessImageArguments args) {
     _stitchImage(Utf8.toUtf8(args.inputPath), Utf8.toUtf8(args.outputPath),Utf8.toUtf8("horizontal"));
  }
  static stitchImageVertical(ProcessImageArguments args) {
    _stitchImage(Utf8.toUtf8(args.inputPath), Utf8.toUtf8(args.outputPath),Utf8.toUtf8("vertical"));
  }
}

