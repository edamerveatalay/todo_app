import 'package:flutter/material.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/common_container.dart';
import 'package:todo_app/widgets/task_tile.dart';

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
        isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
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
          : ListView.separated(
              //separated: Her iki liste elemanının arasına bir “ayırıcı (separator)” ekleyebilmeni sağlar.
              //builder: ekranda ne kadar veri varsa sadece onların yüklenmesini sağlar
              //listeyi kaydırılabilir şekilde göstermeye yarar
              shrinkWrap: true,
              itemCount: tasks.length,
              padding: EdgeInsets.zero, //boşluğu sıfırlamak demek
              itemBuilder: (ctx, index) {
                final task = tasks[index];
                return InkWell(
                  onLongPress: () {
                    //uzun süre basılı tutunca çalışır,silme, düzenleme, detay açma gibi ek işlemler için kullanılır.
                    //taski silme
                  },
                  onTap: () {
                    //taskin detaylarını gösterecek
                  },
                  child: TaskTile(task: task),
                ); //tıklanabilirlik özelliği verdik
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 1.5,
                );
              },
            ),
    );
  }
}
