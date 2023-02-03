# whatsapp_stickers_exporter

A flutter plugin that exports stickers to WhatsApp.

Supports iOS and Android.

Supports both static and animated stickers.

Tested on iOS and Android.

## Example

See an Android/iOS app utilizing this package here: https://github.com/star-39/msb_app,

which, including this package, is part of the [moe-sticker-bot](https://github.com/star-39/moe-sticker-bot) project.

### Install From Asset
Add your image to flutter assets.
```yaml
flutter:
   assets:
     - images/01_Cuppy_smile.webp
     - images/02_Cuppy_lol.webp
     - images/03_Cuppy_rofl.webp
     - images/tray_Cuppy.png
```

```dart
//This somehow confusing list of list data type is to make sure stickers exported to 
//platform will preserve their order.
//['sticker path', 'emoji', 'emoji(optional)', 'emoji(optional)', 'emoji(optional)']
const stickerAssets = [
    ['images/01_Cuppy_smile.webp', '☕', '🙂'],
    ['images/02_Cuppy_lol.webp', '😄', '😀'],
    ['images/03_Cuppy_rofl.webp', '😄', '😀'],
];

List<List<String>> stickerSet = [];

for (var s in stickerAssets) {
    var stickerObject = <String>[];
    stickerObject.add(WhatsappStickerImage.fromAsset(s[0]).path);
    stickerObject.addAll(s.sublist(1, s.length));
    stickerSet.add(stickerObject);
}

var trayImage =
    WhatsappStickerImage.fromAsset("images/tray_Cuppy.png").path;

var exporter = WhatsappStickersExporter();
try {
    await exporter.addStickerPack(
        "my_identifier", //identifier
        "my_name", //name
        "my_author", //publisher
        trayImage, //trayImage
        "", //publisherWebsite
        "", //privacyPolicyWebsite
        "", //licenseAgreementWebsite
        false, //animatedStickerPack
        stickerSet);
} catch (e) {
    log(e.toString());
}
```

### Install From Remote File

```dart
const animatedAssets = [
    ['01_SendingLove.webp', "💕", "😘", "❤️"],
    ["02_WellDoThisTogether.webp", "✊", "💪", "🙏"],
    ["03_Heart.webp", "❤️", "😘", "💕"]
];

var appDir = await getApplicationDocumentsDirectory();
var ssDir = Directory('${appDir.path}/stickers');
await ssDir.create(recursive: true);

final dio = Dio();
final downloads = <Future>[];

for (var a in animatedAssets) {
    downloads.add(
    dio.download(
        'https://github.com/WhatsApp/stickers/raw/main/iOS/WAStickersThirdParty/${a[0]}',
        '${ssDir.path}/${a[0]}',
    ),
    );
}
downloads.add(dio.download("https://github.com/WhatsApp/stickers/raw/main/iOS/WAStickersThirdParty/tray_TogetherAtHome.png",
    '${ssDir.path}/tray.png'));

await Future.wait(downloads);

List<List<String>> stickerSet = [];

for (var s in animatedAssets) {
    var stickerObject = <String>[];
    stickerObject
        .add(WhatsappStickerImage.fromFile('${ssDir.path}/${s[0]}').path);
    stickerObject.addAll(s.sublist(1, s.length));
    stickerSet.add(stickerObject);
}

var trayImage =
    WhatsappStickerImage.fromFile('${ssDir.path}/tray.png').path;

var exporter = WhatsappStickersExporter();
try {
    await exporter.addStickerPack(
        "my_identifier", //identifier
        "My Title", //name
        "my publisher", //publisher
        trayImage, //trayImage
        "", //publisherWebsite
        "", //privacyPolicyWebsite
        "", //licenseAgreementWebsite
        true, //animatedStickerPack
        stickerSet);
} catch (e) {
    log(e.toString());
}
```

## Notes

* Please refer to https://github.com/WhatsApp/stickers/tree/main/Android#sticker-art-and-app-requirements for sticker restrictions, such as image size and amount limits.

* Please note that this plugin does not do any image format conversion or validation, image you feed must complies with WhatsApp's restrictions.

* If you are building for iOS, make sure `whatsapp://` scheme is being added to your `Info.plist`:

```xml
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>whatsapp</string>
</array>
```


## License
BSD License

See also: https://github.com/WhatsApp/stickers/blob/main/LICENSE

### Credits
https://github.com/applicazza/whatsapp_stickers for some code base.
