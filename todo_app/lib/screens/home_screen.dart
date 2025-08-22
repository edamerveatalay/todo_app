import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/utils/task_categories.dart';
import 'package:todo_app/widgets/display_white_text.dart';
import 'package:todo_app/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static HomeScreen builder(
          BuildContext context,
          GoRouterState //Bu parametre aslında builder fonksiyonuna route ile ilgili bilgi taşıyor.
              state) => //builder adında fonksiyon, HomeScreen döndürüyor
//build con vs Fonksiyonun aldığı parametreler //
      const HomeScreen(); //Fonksiyon tek satırda HomeScreen widget’ını return ediyor
  /*Yani GoRouterState state → route ile ilgili durum bilgisini tutar:
path parametreleri: /user/:id → id değeri
query parametreleri: /home?tab=1
route’un adı ve konumu*/
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context
        .colorScheme; //context ile extensions sayfasındaki color'a ulaşıp burada çağırıyoruz
    final deviceSize = context.deviceSize;
    return Scaffold(
      body: Stack(
        //widgetların dikeyde sıralanmasını ama üst üste binebilmesini sağlar
        children: [
          Column(
            children: [
              Container(
                //kutudur
                height: deviceSize.height * 0.3,
                width: deviceSize.width,
                color: colors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DisplayWhiteText(
                      text: 'Aug 18, 2025',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                    DisplayWhiteText(
                      text: 'My Todo List',
                      fontSize: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: 130,
              left: 0, //bunları kullandık bunlar ortalamayı sağladı
              right: 0,
              child: SafeArea(
                //sardığı widgetların ekrana sığdırılmasını sağlayıp taşmayı engeller
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .stretch, //sardığı widgetların ekranı sarmasını sağlar yani ekran bpyunca uzanacak
                    children: [
                      DisplayListOfTasks(
                        tasks: [
                          Task(
                            title: 'title 1',
                            note: '',
                            time: '10.12',
                            date: 'Aug, 17 ',
                            isCompleted: false,
                            category: TaskCategories
                                .shopping, //kategoriye göre ikon değişiyor
                          ),
                          Task(
                            title: 'title 2 title 2 title 2 ',
                            note: 'note',
                            time: '13.12',
                            date: 'Aug, 17 ',
                            isCompleted: false,
                            category: TaskCategories.work,
                          )
                        ],
                      ),
                      Gap(16),
                      Text(
                        'Completed',
                        style: context.textTheme.headlineMedium,
                      ),
                      const Gap(20),
                      DisplayListOfTasks(
                        //display sınıfını burada çağırıyoruz yazılacak şeyi orada yazdık
                        tasks: [
                          Task(
                            title: 'title 1',
                            note: 'note',
                            time: '10.12',
                            date: 'Aug, 17 ',
                            isCompleted:
                                true, //tamamlanmış olanlara true atanmış bu da task_details sınıfından çağrılacak
                            //çağrıldıktan sonra bu true ise oradaki kontrol yapılacak ve üstü çizilecek
                            category: TaskCategories.personal,
                          ),
                          Task(
                            title: 'title 2 title 2 title 2 ',
                            note: 'note',
                            time: '13.12',
                            date: 'Aug, 17 ',
                            isCompleted:
                                false, //tik atma işlemi burayı true yapınca oluyor
                            category: TaskCategories.education,
                          )
                        ],
                        isCompletedTasks: true,
                      ),
                      const Gap(20),
                      ElevatedButton(
                        onPressed: () => context.push(RouteLocation.createTask),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DisplayWhiteText(text: 'Add new task'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary, // Temadaki mor
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
