import 'package:flutter/material.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/common_container.dart';

class DisplayListOfTasks extends StatelessWidget {
  //görev listesi görüntüleme
  const DisplayListOfTasks({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
  });

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final height =
        isCompletedTasks ? deviceSize.height * 0.4 : deviceSize.height * 0.5;
    final emptyTaskMessage =
        isCompletedTasks //if else bloğu gibi doğru işaretlenmiş olan there is no task todo çıkacak
            ? 'There is no complted task yet'
            : 'There is no task todo!';
    return CommonContainer(
      height: height,
      child: tasks.isEmpty
          ? Center(
              child: Text(
                emptyTaskMessage,
                style: context.textTheme.headlineSmall,
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //containerin arka planını ve kenarlarını düzenlemek için
                        shape: BoxShape //shape boxdecoration içinde kullanılır sadece
                            .circle, //containerin kenarlarını yuvarlak yapar daire
                        color: Colors.red,
                      ),
                      child: Center(
                        child:
                            Icon(task.category.icon), //kullanıcı profil simgesi
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }
}
