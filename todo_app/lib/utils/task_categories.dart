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

  final IconData icon;
  final Color color;

  const TaskCategories({required this.icon, required this.color});
}
