// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart'; //equatable → Karşılaştırma için kullanılıyor (normalde Dart sınıfları == ile karşılaştırıldığında referans kontrolü yapar, biz değer karşılaştırması yapmak istiyoruz).

import 'package:todo_app/data/models/task.dart';

class TaskState extends Equatable {
  //State mantığı: UI bu sınıftaki verilere göre değişir.
  final List<Task> tasks; //tasks yani tüm görevlerin listesi.

  const TaskState(this.tasks);
  const TaskState.initial({
    //Başlangıçta tasks boş liste ([]) olacak.

    this.tasks = const [],
  });

  TaskState copyWith({
    //State değişmez (immutable) olmalı.
//→ Bu yüzden yeni bir state oluşturuyoruz.
//copyWith → Eski state’in kopyasını alır, sadece değişen alanı günceller.
    List<Task>? tasks,
  }) {
    return TaskState(
      tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [tasks]; //Equatable için gerekli.
}
