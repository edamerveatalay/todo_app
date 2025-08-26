import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/utils.dart';

class AppAlerts {
  AppAlerts._(); //sadece statik fonksiyonları çağırmak
  static displaySnackBar(BuildContext context, String message) {
    //static → fonksiyonu sınıf üzerinden direkt çağırabilirsin, nesne oluşturmana gerek yok.
    ScaffoldMessenger.of(context).showSnackBar(
      //ekrana kısa süreli mesaj (Snackbar) gösterir.
      SnackBar(
        content: Text(message,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.surface,
            )),
        backgroundColor: context.colorScheme.primary,
      ),

////surface: Material Design’da widget yüzeylerinin arka plan rengi olarak kullanılır.
    );
  }

  static Future<void> showDeleteAlertDialog(
    BuildContext
        context, //Dialog’u hangi widget ağacında göstereceğini belirler.

    WidgetRef
        ref, //Bu sayede dialogdan sonra task’ı silme gibi state güncellemeleri yapabilirsin.
    Task
        task, //Dialog açılırken kullanıcıya hangi görevi sileceğini göstermek için kullanılabilir.
  ) async {
    Widget cancelButton = TextButton(
      onPressed: () =>
          context.pop(), //Flutter’da geçerli sayfayı/dialogu kapatır.
      child: const Text('NO'),
    );
    Widget deleteButton = TextButton(
      onPressed: () async {
        await ref.read(taskProvider.notifier).deleteTask(task).then((value) {
          AppAlerts.displaySnackBar(context,
              'Task delete successfuly'); //silinenler için başarılı oldu uyarısı
          context.pop();
        });
      },
      child: Text('YES'),
    );
    AlertDialog alert = AlertDialog(
      //Flutter’ın uyarı/dialog widget’ı.
      title: const Text('are you sure you want to delete this task?'),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    await showDialog(
      //Flutter fonksiyonu, ekrana modal bir dialog açar.
      context: context,
      builder: (ctx) {
        //dialog’un içeriğini oluşturan fonksiyon.
        return alert;
      },
    );
  }
}
//Bu sınıf, uygulamada her yerde Snackbar göstermek için tekrar tekrar ScaffoldMessenger yazmak yerine kolay bir yöntem sunuyor.
