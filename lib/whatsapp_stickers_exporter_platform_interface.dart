import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'whatsapp_stickers_exporter_method_channel.dart';

abstract class WhatsappStickersExporterPlatform extends PlatformInterface {
  /// Constructs a WhatsappStickersExporterPlatform.
  WhatsappStickersExporterPlatform() : super(token: _token);

  static final Object _token = Object();

  static WhatsappStickersExporterPlatform _instance = MethodChannelWhatsappStickersExporter();

  /// The default instance of [WhatsappStickersExporterPlatform] to use.
  ///
  /// Defaults to [MethodChannelWhatsappStickersExporter].
  static WhatsappStickersExporterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WhatsappStickersExporterPlatform] when
  /// they register themselves.
  static set instance(WhatsappStickersExporterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
