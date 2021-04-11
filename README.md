# Opencv Awesome


## Overview

A Flutter plugin providing the ability to use opencv native c++ implementation for image stitching
in flutter projects. it support stitching multi images in both and horizontal direction to create panoramic view. easy to use and customize for creating panorama.

The plugin is supported for android only and will be extended for ios in future.

**Features:**
  1. Stitch images using high level stitching APIs of opencv.
  2. Create full panorama by automatically removing overlap region.
  3. Stitch images both in horizontal and vertical direction.
  4. Easily customize to create full panoramic view.
## Preview
![alt preview](https://i.ibb.co/dp1ft8P/Screenshot-1618131260.png)
![alt preview](https://i.ibb.co/D5yP3Pm/Screenshot-1618145974.png)

 ## prerequisite:
1. NDK configuration
  - Add ndk path to your project
2. Require Opencv SDK
  - Download the opencv sdk from https://opencv.org/releases/
  - add opencv sdk to the location "C:/opencv/OpenCV-android-sdk/"
3. Add media read and write storage permission to your project

## installation
```
opencv_awesome: ^0.0.2
```

## Usage

```flutter

    import 'package:opencv_awesome/opencv_awesome.dart';
  //for horizontal stitching
    await  OpencvAwesome.stitch_horizontally(<List of images paths in left to right direction >, <output image path>,oncompleted);
 void oncompletedHorizontal(dirpath){
    setState(() {
      horizontal_output_path=dirpath;
      _isWorking=false;
    });
  }
  //for vertical stitching
     await  OpencvAwesome.stitch_vertically(<List of images paths in top to bottom direction >, <output image path>,oncompleted);




```
