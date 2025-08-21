import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/widgets.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    return Padding(
      padding: const EdgeInsets.all(
          30), //padding içindeki her şeye 30 piksel boşluk bırakacak
      child: Column(
        children: [
          CircleContainer(
            color: task.category.color.withValues(
                alpha:
                    0.3), //task sınıfındaki kategori nesnesinin rengini şeffaf yapıyor
            child: Icon(
              task.category
                  .icon, //task sınıfındaki kategorinin ikonu buraya konuyor
              color: task.category.color, //ikonun rengi belirleniyor
            ),
          ),
          const Gap(
              16), //column içinde kullanıldığı için dikeyde 16 piksel boşluk
          Text(
            task.title, //task sınıfındaki title'ı çağırıyor neyse onu gösterecek
            style: style.titleMedium?.copyWith(
              //uygulamanın temasında tanımlanmış orta boy başlık stili çağrılıyor
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            task.time, //task sınıfının time nesnesi çağrılıyor
            style: style.titleMedium, //bu yazının stili seçiliyor
          ),

          const Gap(16),
          Visibility(
            //içindeki widgetları görünür ya da gizli yapmayı sağlar
            visible: !task.isCompleted,
            /*Eğer görev tamamlanmamışsa (isCompleted = false) → !false = true → görünsün.
Eğer görev tamamlanmışsa (isCompleted = true) → !true = false → gizlensin.
*/
            child: Row(
              //içindekileri yatayda yan yana yazar
              mainAxisAlignment:
                  MainAxisAlignment.center, //row içindekileri ortalamayı sağlar
              children: [
                Text('task to be cpmpleted on ${task.date}'),
                Icon(
                  Icons.check_box,
                  color: task.category.color,
                )
              ],
            ),
          ),
          const Gap(16),
          Divider(
            //yatayda çizgi ekler
            thickness: 1.5, //çizginin kalınlığını ayarlar
            color: task.category.color, //çizginin rengini belirler
          ),
          const Gap(16),
          Text(
            task.note
                    .isEmpty //task içindeki note nesnesine gidiyor boşsa true oluyor ve 1. seçenek yazdırılıyor
                //eğer doluysa orada yazan yani task'teki note içnde yazan yazı çıkıyor
                ? 'There is no additional note for this task'
                : task.note,
          ),
          const Gap(16),
          Visibility(
            //içindeki widgetları görünür ya da gizli yapmayı sağlar
            visible: !task
                .isCompleted, //her şey home_screen sayfasındaki completed'a bağlı ki tamamlanmışların üstü çiziliyor
            /*Eğer görev tamamlanmamışsa (isCompleted = false) → !false = true → görünsün.
Eğer görev tamamlanmışsa (isCompleted = true) → !true = false → gizlensin.
*/
            child: Row(
              //içindekileri yatayda yan yana yazar
              mainAxisAlignment:
                  MainAxisAlignment.center, //row içindekileri ortalamayı sağlar
              children: [
                Text('task to be completed on ${task.date}'),
                Icon(
                  Icons.check_box,
                  color: Colors.green, //tamamlanan görevlere yeşil tik atıldı
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
/*home_screen dosyasındaki isCompleted true ise üstü çiziliyor note içinde yazan yazılıyor ama
Ama 'task to be completed on' vs yazılmıyor çünkü ilk önce o kontrol ediliyor false ise bu yazı görünüyor*/
/*Her kategorinin rengi, ikonu ve etiketi tek bir yerde tanımlı (TaskCategories enum + extension).
Bu da uygulamada bütümlük sağlıyor*/
