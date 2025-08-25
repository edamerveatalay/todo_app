import 'package:flutter/material.dart';
import 'package:todo_app/utils/utils.dart';

@immutable
class DBKeys {
  //veritabanı (DB) ile çalışırken kullanılan sabit değerleri tutmak için yazılmış bir sınıf.
  DBKeys._(); //Private constructor → dışarıdan bu sınıftan nesne oluşturulamaz.

  static const String dbName = 'task.db';
  static const String dbTable = 'tasks';
  static const String idColumn = TaskKeys.id;
  static const String titleColumn = TaskKeys.title;
  static const String noteColumn = TaskKeys.note;
  static const String timeColumn = TaskKeys.time;
  static const String dateColumn = TaskKeys.date;
  static const String categoryColumn = TaskKeys.category;
  static const String isCompletedColumn = TaskKeys.isCompleted;
}
