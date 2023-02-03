import 'package:flutter/services.dart';

import 'exceptions.dart';
import 'whatsapp_stickers_exporter_platform_interface.dart';

class WhatsappStickersExporter {
  static const consumerWhatsAppPackageName = 'com.whatsapp';
  static const businessWhatsAppPackageName = 'com.whatsapp.w4b';
  static const MethodChannel _channel =
      MethodChannel('whatsapp_stickers_exporter');

  /// Launch WhatsApp(Android only)
  static void launchWhatsApp() {
    _channel.invokeMethod("launchWhatsApp");
  }

  /// Add a sticker pack to whatsapp.
  Future<dynamic> addStickerPack(
    identifier,
    String name,
    String publisher,
    String trayImageFileName,
    String? publisherWebsite,
    String? privacyPolicyWebsite,
    String? licenseAgreementWebsite,
    bool? animatedStickerPack,
    List<List<String>> stickers,
  ) async {
    try {
      final payload = <String, dynamic>{};
      payload['identifier'] = identifier;
      payload['name'] = name;
      payload['publisher'] = publisher;
      payload['trayImageFileName'] = trayImageFileName;
      payload['publisherWebsite'] = publisherWebsite;
      payload['privacyPolicyWebsite'] = privacyPolicyWebsite;
      payload['licenseAgreementWebsite'] = licenseAgreementWebsite;
      payload['animatedStickerPack'] = animatedStickerPack;
      payload['stickers'] = stickers;
      return await _channel.invokeMethod('addStickerPack', payload);
    } on PlatformException catch (e) {
      switch (e.code) {
        case WhatsappStickersFileNotFoundException.CODE:
          throw WhatsappStickersFileNotFoundException(e.message);
        case WhatsappStickersNumOutsideAllowableRangeException.CODE:
          throw WhatsappStickersNumOutsideAllowableRangeException(e.message);
        case WhatsappStickersUnsupportedImageFormatException.CODE:
          throw WhatsappStickersUnsupportedImageFormatException(e.message);
        case WhatsappStickersImageTooBigException.CODE:
          throw WhatsappStickersImageTooBigException(e.message);
        case WhatsappStickersIncorrectImageSizeException.CODE:
          throw WhatsappStickersIncorrectImageSizeException(e.message);
        case WhatsappStickersTooManyEmojisException.CODE:
          throw WhatsappStickersTooManyEmojisException(e.message);
        case WhatsappStickersEmptyStringException.CODE:
          throw WhatsappStickersEmptyStringException(e.message);
        case WhatsappStickersStringTooLongException.CODE:
          throw WhatsappStickersStringTooLongException(e.message);
        default:
          throw WhatsappStickersException(e.message);
      }
    }
  }
}

class WhatsappStickerImage {
  final String path;

  WhatsappStickerImage._internal(this.path);

  factory WhatsappStickerImage.fromAsset(String asset) {
    return WhatsappStickerImage._internal('assets://$asset');
  }

  factory WhatsappStickerImage.fromFile(String file) {
    return WhatsappStickerImage._internal('file://$file');
  }
}
