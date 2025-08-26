import 'package:todo_app/data/repositories/repositories.dart';
import 'package:todo_app/data/data.dart';

class TaskRepositoryImpl implements TaskRepository {
  //"TaskRepository'de create, update, delete, getAllTasks var, bunları burada doldur" demek.
  final TaskDatasource
      _datasource; //TaskDatasource → Bu başka bir sınıf (veri kaynağı ile ilgileniyor, örn. SQLite veya API).
//Bu sınıfın içinde bir değişken var: _datasource.

  TaskRepositoryImpl(
      this._datasource); //Bu sınıfa bir TaskDatasource veriyorsun, o da _datasource'a atanıyor.
  @override
  Future<void> createTask(Task task) async {
    //Bu sınıf, TaskRepository'deki metotları gerçekten çalıştıran kısım.

    try {
      await _datasource.addTask(
          task); //Görev eklemek için TaskDatasource içindeki addTask metodunu çağırıyor.
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
      await _datasource.deleteTask(task);
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<List<Task>> getAllTasks() async {
    try {
      return await _datasource.getAllTasks();
    } catch (e) {
      throw '$e';
    }
  }

  @override
  Future<void> updateTask(Task task) async {
    try {
      await _datasource.updateTask(task);
    } catch (e) {
      throw '$e';
    }
  }
}
/* TaskRepositoryImpl, TaskRepository'nin gerçek uygulaması.
Ama işi kendisi yapmıyor, işi TaskDatasource'a devrediyor.
Bu bir katmanlı mimari yapısı:
UI → TaskRepository üzerinden çağrı yapar.
TaskRepositoryImpl → Görevi datasource'a yönlendirir.
Datasource → Asıl veri işlemleri (SQLite, API vs.).*/
