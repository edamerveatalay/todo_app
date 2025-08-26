import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/data/repositories/repositories.dart';
import 'package:todo_app/providers/task/task_state.dart';

class TaskNotifier extends StateNotifier<TaskState> {
  //TaskNotifier → görevlerin yöneticisi.

  final TaskRepository
      _repository; //_repository adında bir değişken tanımlıyoruz. Tipi TaskRepository
  TaskNotifier(this._repository) : super(const TaskState.initial()) {
    getTasks();
  }
/* Uygulamanın hafızasında “görev listesi” var.
TaskNotifier → Bu listeyi güncelleyen kişi.
TaskState → O listenin bulunduğu kutu.*/
  Future<void> createTask(Task task) async {
    //Ama kendisi doğrudan listeye eklemez → _repository üzerinden ekler.
//Eğer hata olursa, konsola yazdırır (debugPrint).
    try {
      await _repository.createTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      final isCompleted = !task.isCompleted;
      final updatedTask = task.copyWith(isCompleted: isCompleted);
      await _repository.updateTask(updatedTask);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
    //Örnek: Kullanıcı alışverişi yaptı, “tamamlandı” olarak işaretledi.
//Notifier → repository → veri tabanına güncellendi.
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _repository.deleteTask(task);
      getTasks();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  //Örnek: Kullanıcı “çöp dök” görevini listeden sildi → repository’den de silindi.

  void getTasks() async {
    try {
      final tasks = await _repository.getAllTasks();
      state = state.copyWith(tasks: tasks);
    } catch (e) {
      debugPrint(e.toString());
    }
    //Uygulama açıldığında getTasks() çağrılır → veritabanındaki tüm görevler ekrana yansır.
  }
}
//initial → Uygulama ilk açıldığında ya da Cubit/BLoC ilk başlatıldığında kullanılacak başlangıç durumu.
