#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "VoskFlutterPlugin.h"
#import "vosk_api.h"

FOUNDATION_EXPORT double vosk_flutter_pluginVersionNumber;
FOUNDATION_EXPORT const unsigned char vosk_flutter_pluginVersionString[];

