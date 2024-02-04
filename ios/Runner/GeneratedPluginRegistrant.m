//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_phone_direct_caller/FlutterPhoneDirectCallerPlugin.h>)
#import <flutter_phone_direct_caller/FlutterPhoneDirectCallerPlugin.h>
#else
@import flutter_phone_direct_caller;
#endif

#if __has_include(<flutter_sms/FlutterSmsPlugin.h>)
#import <flutter_sms/FlutterSmsPlugin.h>
#else
@import flutter_sms;
#endif

#if __has_include(<speech_to_text/SpeechToTextPlugin.h>)
#import <speech_to_text/SpeechToTextPlugin.h>
#else
@import speech_to_text;
#endif

#if __has_include(<url_launcher_ios/URLLauncherPlugin.h>)
#import <url_launcher_ios/URLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterPhoneDirectCallerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterPhoneDirectCallerPlugin"]];
  [FlutterSmsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterSmsPlugin"]];
  [SpeechToTextPlugin registerWithRegistrar:[registry registrarForPlugin:@"SpeechToTextPlugin"]];
  [URLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"URLLauncherPlugin"]];
}

@end
