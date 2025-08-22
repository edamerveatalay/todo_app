import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:todo_app/config/routes/routes.dart'; //route isimlerini ve konumlarını tutuyor
import 'package:todo_app/screens/screens.dart'; // tüm ekran widgetlarına kolay ulaşmak için. create_task_screen'de vs de kullanılacağı için

final navigationKey = GlobalKey<
    NavigatorState>(); //Sayfalar arası geçişi herhangi bir yerden (context’e bağlı kalmadan) yapabilmek.
//Context → widget’ın “nerede olduğunu bilen bilgi paketi”dir. Sayfaların birbiriyle iletişimini sağlar.

final appRoutes = [
  GoRoute(
    //Her bir GoRoute → bir sayfayı ve onun yolunu (path) temsil eder.

    //sayfalar arası geçişi sağlar
    path: RouteLocation.home, //Sayfanın URL yolu veya rout adı.
    parentNavigatorKey:
        navigationKey, //Eğer uygulamada nested (iç içe) navigator varsa hangi navigator üzerinden sayfa açılacağını belirler.

    builder: HomeScreen //widget oluşturan fonksiyon builder
        .builder, //Bu sayfa açıldığında hangi widget render edilecek → HomeScreen.
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: CreateTaskScreen.builder,
  ),
];
