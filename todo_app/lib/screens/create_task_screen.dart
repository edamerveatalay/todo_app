import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/widgets/display_white_text.dart';
import 'package:go_router/go_router.dart';

class CreateTaskScreen extends StatelessWidget {
  static CreateTaskScreen builder(
          BuildContext context,
          GoRouterState //Bu parametre aslında builder fonksiyonuna route ile ilgili bilgi taşıyor.
              state) => //builder adında fonksiyon, HomeScreen döndürüyor
//build con vs Fonksiyonun aldığı parametreler //
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DisplayWhiteText(text: 'Add New Task'),
      ),
    );
  }
}
