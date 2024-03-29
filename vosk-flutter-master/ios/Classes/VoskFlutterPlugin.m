#import "VoskFlutterPlugin.h"
#if __has_include(<vosk_flutter_plugin/vosk_flutter_plugin-Swift.h>)
#import <vosk_flutter_plugin/vosk_flutter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vosk_flutter_plugin-Swift.h"
#endif

@implementation VoskFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVoskFlutterPlugin registerWithRegistrar:registrar];
}
@end
