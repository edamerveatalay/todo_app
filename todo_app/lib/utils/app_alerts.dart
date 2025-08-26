import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/utils/utils.dart';

class AppAlerts {
  AppAlerts._(); //sadece statik fonksiyonları çağırmak
  static displaySnackBar(BuildContext context, String message) {
    //static → fonksiyonu sınıf üzerinden direkt çağırabilirsin, nesne oluşturmana gerek yok.
    ScaffoldMessenger.of(context).showSnackBar(
      //ekrana kısa süreli mesaj (Snackbar) gösterir.
      SnackBar(
        content: Text(message,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.surface,
            )),
        backgroundColor: context.colorScheme.primary,
      ),

////surface: Material Design’da widget yüzeylerinin arka plan rengi olarak kullanılır.
    );
  }
}
//Bu sınıf, uygulamada her yerde Snackbar göstermek için tekrar tekrar ScaffoldMessenger yazmak yerine kolay bir yöntem sunuyor.
