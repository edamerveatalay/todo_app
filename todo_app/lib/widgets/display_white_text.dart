import 'package:flutter/material.dart';
import 'package:todo_app/utils/extensions.dart';

/*Bu sınıf “beyaz yazılarım hep aynı görünümde olsun” mantığını sağlıyor.
Sonra uygulamanın farklı yerlerinde sadece DisplayWhiteText(text: "Merhaba") diyorsun, stil otomatik geliyor.*/
class DisplayWhiteText extends StatelessWidget {
  const DisplayWhiteText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight}); //beyaz renkli yazıları buraya yazıp buradan çağıracağız

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: context.textTheme.headlineSmall?.copyWith(
          /*context.textTheme → Theme’de tanımlı tüm yazı stillerini alır.
headlineSmall → ThemeData içinde küçük başlık stili olarak tanımlı bir TextStyle.
Yani burada yazının temel stili temadan geliyor (fontFamily, fontWeight, fontSize vb.).*/
          color: context.colorScheme.surface,
          fontWeight: fontWeight ?? FontWeight.bold,
          fontSize: fontSize,
        ));
  }
}
