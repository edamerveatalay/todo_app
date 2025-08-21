import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:path/path.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/circle_container.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.onCompleted});
  final Task task;
  final Function(bool?)? onCompleted;

  @override
  Widget build(BuildContext context) {
    final style = context.textTheme;
    final double iconValues =
        task.isCompleted ? 0.3 : 0.5; //görev tamamlandıysa ikon daha şeffaf
    final backgroundOpacity = task.isCompleted
        ? 0.1
        : 0.3; //görev tamamlandıysa ikon dairesi şeffaflaştırılıyor. if else yapısı gibi
    final textDecoration = task.isCompleted
        ? TextDecoration.lineThrough
        : TextDecoration
            .none; // Eğer görev tamamlandıysa yazının üstünü çiz, tamamlanmadıysa çizgi olmasın
    final fontWeight = task.isCompleted
        ? FontWeight.normal
        : FontWeight.bold; //tamamlanmamış görevler daha belirgin gözükecek
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          CircleContainer(
            color: task.category.color
                .withValues(alpha: backgroundOpacity), //saydam yaptık ikonu
            child: Center(
              child: Icon(
                task.category.icon, //kullanıcı profil simgesi
                //task objesinin kategorisine ait ikonu verir
                color: task.category.color.withValues(alpha: iconValues),
              ), //kategoriye ait rengi verir
            ),
          ),
          const Gap(16), //iki widget arasına boşluk koyar
          Expanded(
            //widgetın kalan boşlukları doldurmasını sağlar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title, // Görevin başlığını ekrana yazdırır
                  style: style.titleMedium?.copyWith(
                      // Yazının üstü çizilsin mi çizilmesin mi karar verir
                      decoration: textDecoration,
                      fontSize: 20,
                      fontWeight: fontWeight),
                ),
                Text(
                  task.time,
                  style: style.titleMedium?.copyWith(
                      // tamamlanmış görevin zamanının üstünü de çiziyoruz
                      // Yazının üstü çizilsin mi çizilmesin mi karar verir
                      decoration: textDecoration,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) {},
          )
        ],
      ),
    );
  }
}
