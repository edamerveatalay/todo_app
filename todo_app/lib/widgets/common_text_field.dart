// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:todo_app/utils/utils.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.controller,
      this.maxLines,
      this.suffixIcon,
      this.readOnly = false})
      : super(key: key);
  final String title;
  final String hintText;
  final TextEditingController controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        const Gap(10),
        TextField(
          //Kullanıcıdan metin girişi alır
          readOnly:
              readOnly, //TextField’ı yalnızca okunur hâle getirir; kullanıcı metin giremez.
          //bunun kullanıldğı yerde yani tarih ve saat kısmında klavyeyle sayı girme engellenecek

          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLines: maxLines,
          decoration: InputDecoration(
            //TextField’ün görünümünü düzenlemek için kullanılır
            hintText:
                hintText, //TextField içine kullanıcı yazmaya başlamadan önce görünen açıklama yazısıdır (placeholder).
            suffixIcon: suffixIcon, //textfieldın sağına ikon ekler
          ),
          onChanged:
              (value) {}, //Kullanıcı TextField içine yazdığında her karakter değişiminde tetiklenen bir callback fonksiyonudur.
          //(value) → Kullanıcının yazdığı güncel metin parametre olarak gelir.
          //onChanged → Kullanıcı girdisini takip etmek ve anlık olarak işlemek.
        )
      ],
    );
  }
}
