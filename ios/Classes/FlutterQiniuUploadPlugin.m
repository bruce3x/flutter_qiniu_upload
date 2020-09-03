#import "FlutterQiniuUploadPlugin.h"
#if __has_include(<flutter_qiniu_upload/flutter_qiniu_upload-Swift.h>)
#import <flutter_qiniu_upload/flutter_qiniu_upload-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_qiniu_upload-Swift.h"
#endif

@implementation FlutterQiniuUploadPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterQiniuUploadPlugin registerWithRegistrar:registrar];
}
@end
