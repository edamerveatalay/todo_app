import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/utils/task_categories.dart';

final categoryProvider = StateProvider<TaskCategories>((ref) {
  return TaskCategories.others;
});
//Bu kod, kullanıcının seçtiği kategori bilgisini tutar ve Riverpod üzerinden yönetir. Başlangıçta others kategorisi seçili olur.
