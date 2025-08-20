import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  //Extension = mevcut sınıfa ekstra fonksiyon veya özellik ekleme yöntemi

  ThemeData get _theme => Theme.of(
      this); //her yerde bunların kullanılabilmesi için BuildContext sınıfına extensions ekliyoruz
  //Theme.of(context)’u kısaca _theme olarak çağırmamı sağlar.
  TextTheme get textTheme => _theme
      .textTheme; //_theme.textTheme değerini context.textTheme olarak kullanabilmeyi sağlar.
//Örneğin: Text('Merhaba', style: context.textTheme.headlineMedium)
  ColorScheme get colorScheme => _theme.colorScheme;
  Size get deviceSize => MediaQuery.sizeOf(this);
}
