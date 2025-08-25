// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:todo_app/utils/utils.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final String note;
  final String time;
  final String date;
  final TaskCategories category;
  final bool isCompleted;
  Task({
    int? id,
    required this.title,
    required this.note,
    required this.time,
    required this.date,
    required this.category,
    required this.isCompleted,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props {
    return [
      id,
      title,
      note,
      time,
      date,
      isCompleted,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      TaskKeys.id: id,
      TaskKeys.title: title,
      TaskKeys.note: note,
      TaskKeys.time: time,
      TaskKeys.date: date,
      TaskKeys.category: category.name,
      TaskKeys.isCompleted: isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> map) {
    //Bu kod JSON (veya Map) verisini tekrar bir Task nesnesine çevirmek için yazılmış.

    return Task(
      id: map[
          TaskKeys.id], //Map’ten id’yi alıyoruz ve Task’in id’sine atıyoruz.
      title: map[TaskKeys.title],
      note: map[TaskKeys.note],
      time: map[TaskKeys.time],
      date: map[TaskKeys.date],
      category: TaskCategories.stringToCategory(map[TaskKeys
          .category]), //TaskCategories bir enum: personal, work, others gibi sabit değerler.
//String ile enum farklı tiplerdir, direkt atayamazsın.
//TaskCategories.stringToCategory() → "personal" String’ini enum değerine çeviriyor: TaskCategories.personal
//stringToCategory() → String → Enum dönüştürücü köprü
      isCompleted: map[TaskKeys.isCompleted],
    );
  }
}
//Enum = kod içinde sabit seçeneklerle çalışmak için güvenli ve okunabilir bir yol.
//Veritabanı veya JSON sadece String saklar; enum → String dönüşümü ile kaydedilir, okunurken tekrar enum’a çevrilir.
