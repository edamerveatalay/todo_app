import 'package:todo_app/data/models/task.dart';

abstract class TaskRepository {
  //Bu sınıf, TaskRepository adında bir arayüz gibi davranarak, görev (task) verileriyle ilgili işlemleri belirtiyor.
  Future<void> createTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
  Future<List<Task>> getAllTasks(); //Tüm görevleri liste olarak döndürür.
}
//Verinin kaynağı (SQLite, API, Hive vs.) değişse bile üst katmandaki kodu etkilemeden yönetmek için.
