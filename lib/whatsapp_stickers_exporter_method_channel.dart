import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'whatsapp_stickers_exporter_platform_interface.dart';

/// An implementation of [WhatsappStickersExporterPlatform] that uses method channels.
class MethodChannelWhatsappStickersExporter extends WhatsappStickersExporterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('whatsapp_stickers_exporter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
