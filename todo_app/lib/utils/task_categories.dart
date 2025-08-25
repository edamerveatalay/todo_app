import 'package:flutter/material.dart';

enum TaskCategories {
  education(icon: Icons.school, color: Colors.blueGrey),
  health(icon: Icons.favorite, color: Colors.orange),
  home(icon: Icons.home, color: Colors.green),
  others(icon: Icons.calendar_month, color: Colors.purple),
  personal(icon: Icons.person, color: Colors.lightBlue),
  shopping(icon: Icons.shopping_bag, color: Colors.pink),
  social(icon: Icons.people, color: Colors.brown),
  travel(icon: Icons.flight, color: Colors.deepOrange),
  work(icon: Icons.work, color: Colors.amber);

//String ile enum arasında dönüşüm yapmak için kullanılır.
//String → enum = dışardan gelen veriyi uygulamada güvenli şekilde kullanabilmek için

  static TaskCategories stringToCategory(String name) {
    //Fonksiyon, String → TaskCategories dönüşümü yapıyor.
    try {
      return TaskCategories
          .values //TaskCategories.values → Enum’daki tüm değerleri liste olarak alır.

          .firstWhere((category) => //Listede ilk eşleşen elementi bulur.
              category.name == name);
      //Enum’daki her öğenin name alanı, verilen String ile eşleşiyor mu diye kontrol eder.
    } catch (e) {
      return TaskCategories.others;
    }
  }

  final IconData icon;
  final Color color;

  const TaskCategories({required this.icon, required this.color});
}
