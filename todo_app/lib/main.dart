import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/app/todo_app.dart';

void main() {
  //çalıştırmak için fonksiyonumu oluşturduk
  runApp(const ProviderScope(
    child: TodoApp(),
  ));
}
/*ProviderScope(...)
Riverpod kütüphanesinin bir parçası.
Görevi: uygulamanın en tepesinde bir container oluşturmak.
Bu container içinde senin tanımladığın bütün provider’lar (routesProvider, themeProvider vs.) saklanır.
Böylece uygulamanın her yerinde ref.watch(...) ile bu provider’lara erişebilirsin.*/
