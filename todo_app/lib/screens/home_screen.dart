import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/routes.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/utils/task_categories.dart';
import 'package:todo_app/widgets/display_white_text.dart';
import 'package:todo_app/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  //consumerWidget: Riverpod’daki Provider’ları dinlemek için WidgetRef kullanmamızı sağlıyor.

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
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context
        .colorScheme; //context ile extensions sayfasındaki color'a ulaşıp burada çağırıyoruz
    final deviceSize = context.deviceSize;
    final taskState = ref.watch(
        taskProvider); //ref: Riverpod Provider’larını okumak ve dinlemek için kullanıyoruz.
    final completedTasks = _completedTasks(taskState.tasks);
    final incompletedTasks = _incompletedTasks(taskState.tasks);
    final selectedDate = ref.watch(dateProvider);

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
                    InkWell(
                      onTap: () => Helpers.selectDate(context, ref),
                      child: DisplayWhiteText(
                        text: DateFormat.yMMMd().format(selectedDate),
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
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
                        tasks:
                            incompletedTasks, //Widget’a güncel görev listesini gönderiyoruz.
                      ),
                      Gap(16),
                      Text(
                        'Completed',
                        style: context.textTheme.headlineMedium,
                      ),
                      const Gap(20),
                      DisplayListOfTasks(
                        //display sınıfını burada çağırıyoruz yazılacak şeyi orada yazdık
                        tasks: completedTasks,
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

  List<Task> _completedTasks(List<Task> tasks) {
    final List<Task> filteredTasks =
        []; //Yeni bir boş liste oluşturuyor.Bu listeye sadece tamamlanmış görevler eklenecek.
    for (var task in tasks) {
      //tasks listesindeki her Task nesnesini tek tek dolaşır.
      if (task.isCompleted) {
        //sadece isCompleted özelliği true olan görevleri seçer.
        filteredTasks
            .add(task); //seçilen görevleri filteredTasks listesine ekler.
      }
    }

    return filteredTasks;
  }

  List<Task> _incompletedTasks(List<Task> tasks) {
    final List<Task> filteredTasks = [];
    for (var task in tasks) {
      if (!task.isCompleted) {
        filteredTasks.add(task);
      }
    }

    return filteredTasks;
  }
}
//riverpıod: UI ile verinin arasında köprü görevi görür.
//ref.watch(...) sayesinde Riverpod diyor ki:
//“UI, bu Provider’ı dinliyor. Eğer state değişirse, bu widget’ı yeniden çiz.”
