import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/widgets/display_white_text.dart';
import 'package:todo_app/widgets/common_text_field.dart';
import 'package:todo_app/widgets/select_category.dart';
import 'package:todo_app/widgets/select_data_time.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          // İçerik kaydırılabilir olsun
          physics:
              const AlwaysScrollableScrollPhysics(), //Kaydırmayı her zaman aktif yapar
          padding: EdgeInsets.all(20.0), //kenarlarda 20 piksel boşluk
          child: Column(
            //içine yazılanlar dikeyde hizalanacak
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //column içine widgetlar koymak için children içine konur
              CommonTextField(
                title: 'Task Title',
                hintText: 'Task Title',
                controller: TextEditingController(),
              ),
              const Gap(16),
              const SelectCategory(),
              const Gap(16),

              SelectDataTime(),
              const Gap(16),
              CommonTextField(
                title: 'Note',
                hintText: 'Task note',
                maxLines: 6,
                controller: TextEditingController(),
              ),
              const Gap(120),
              ElevatedButton(
                onPressed: () {},
                child: DisplayWhiteText(
                  text: 'Save',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primary, // Temadaki mor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
