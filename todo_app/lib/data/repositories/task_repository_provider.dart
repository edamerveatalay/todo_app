import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/data/data.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  //Tipi: TaskRepository → Yani bu Provider TaskRepository nesnesi döndürecek.
//Provider → Flutter’da veriyi veya sınıfı tüm uygulama boyunca paylaşan bir yapıdır.
  final datasource = ref.watch(
      taskDataSourceProvider); //ref → Provider içinden diğer Provider’lara erişmek için kullanılır.
  //Yani buradaki datasource, veri kaynağımız (SQLite, API veya başka bir TaskDatasource) olur.
  return TaskRepositoryImpl(datasource);
  /* Artık repository oluşturuyoruz.
TaskRepositoryImpl → Daha önce gördüğümüz repository implementasyonu.
Constructor’a datasource veriyoruz → Repository artık görev ekleme, silme, güncelleme, listeleme işlemlerini datasource üzerinden yapacak.*/
});
