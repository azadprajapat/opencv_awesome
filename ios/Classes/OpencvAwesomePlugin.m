#import "OpencvAwesomePlugin.h"
#if __has_include(<opencv_awesome/opencv_awesome-Swift.h>)
#import <opencv_awesome/opencv_awesome-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "opencv_awesome-Swift.h"
#endif

@implementation OpencvAwesomePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOpencvAwesomePlugin registerWithRegistrar:registrar];
}
@end
