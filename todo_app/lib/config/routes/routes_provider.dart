import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/routes.dart';

final routesProvider = Provider<GoRouter>(
  //Provider, bir değeri veya nesneyi (ör. bir sınıf, router, liste, boolean) tüm uygulama boyunca erişilebilir hale getirir.
  (ref) {
    return GoRouter(
      //Yani, uygulama boyunca bu GoRouter’ı kullanabileceğiz.
      initialLocation: RouteLocation
          .home, //Uygulama açıldığında hangi route’un (sayfanın) başlangıçta açılacağını belirler.

      navigatorKey:
          navigationKey, //Böylece context’e bağımlı kalmadan sayfa geçişi yapabiliriz.

      routes: appRoutes, //Uygulamadaki tüm route’lar burada tanımlanır.
    );
  },
);
