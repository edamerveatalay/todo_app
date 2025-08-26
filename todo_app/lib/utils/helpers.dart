import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/providers/date_provider.dart';

import '../data/data.dart';

class Helpers {
  Helpers._();
  static String timeToString(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      return DateFormat.jm().format(date);
    } catch (e) {
      return '12.00 pm ';
    }
  }

  static bool isTaskFromSelectedDate(Task task, DateTime selectedDate) {
    final DateTime taskDate = _stringToDateTime(task.date);
    if (taskDate.year == selectedDate.year &&
        taskDate.month == selectedDate.month &&
        taskDate.day == selectedDate.day) {
      return true;
    }

    return false;
  }

  static DateTime _stringToDateTime(String dateString) {
    try {
      DateFormat format = DateFormat.yMMMd();
      return format.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
  }

  static void selectDate(BuildContext context, WidgetRef ref) async {
    // 1. Tarih seçmek için async fonksiyon tanımlanıyor
    // dateProvider'dan mevcut tarihi oku
    final initialDate = ref.read(dateProvider);
    DateTime? pickedDate = await showDatePicker(
        // 2. showDatePicker açılıyor ve kullanıcı seçim yapana kadar bekleniyor
        context:
            context, // 3. Dialog’un hangi BuildContext içinde açılacağını belirtiyoruz
        initialDate:
            initialDate, // 4. Dialog açıldığında başlangıç tarihi olarak bugün seçili olacak
        firstDate:
            DateTime(2023), // 5. Kullanıcının seçebileceği en eski tarih (2023)
        lastDate:
            DateTime(2090)); // 6. Kullanıcının seçebileceği en son tarih (2090)

    if (pickedDate != null) {
      ref.read(dateProvider.notifier).state =
          pickedDate; // 4️⃣ dateProvider içindeki state'i güncelle
    }
  }
}
