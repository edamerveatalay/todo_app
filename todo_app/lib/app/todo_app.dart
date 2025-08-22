import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/routes/routes_provider.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/screens/screens.dart';

class TodoApp extends ConsumerWidget {
  //StatelessWidget gibidir ama Riverpod provider’larını kullanabilmen için WidgetRef nesnesini build fonksiyonunda sana verir.
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //build metodu hangi widget’ın ekranda nasıl görüneceğini döndürür.
/*Flutter: “TodoApp ekrana çizilecek” dediğinde → build çağrılır.
build → bize bir MaterialApp.router döndürür.
Yani uygulama ekranında görünen ilk widget bu olur.*/
    final routeConfig = ref
        .watch(routesProvider); //Artık navigation config burada kullanılabilir.
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig:
          routeConfig, //routerConfig: routeConfig → uygulamanın navigasyonunu bu router yönetir.
    );
  }
}
/*Bu GoRouter içinde:
hangi sayfaların (route) var olduğu,
hangi path’e gidilince hangi ekran açılacağı,
uygulamanın başlangıç ekranı (initialLocation)
gibi bilgiler var.*/
//Flutter widget’larının birbirinden bağımsız şekilde aynı veriyi kullanabilmesini sağlar.
//Provider’ı bir kez tanımlarsın, sonra uygulamanın her yerinden erişebilirsin.
