#import "WhatsappStickersExporterPlugin.h"
#if __has_include(<whatsapp_stickers_exporter/whatsapp_stickers_exporter-Swift.h>)
#import <whatsapp_stickers_exporter/whatsapp_stickers_exporter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "whatsapp_stickers_exporter-Swift.h"
#endif

@implementation WhatsappStickersExporterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftWhatsappStickersExporterPlugin registerWithRegistrar:registrar];
}
@end
