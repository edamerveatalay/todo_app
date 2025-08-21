import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    required this.color,
    this.child,
  });
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
          9.0), //kenar boşlukları tanımlamak için kullanılan sınıf
      decoration: BoxDecoration(
        //containerin arka planını ve kenarlarını düzenlemek için
        shape: BoxShape //shape boxdecoration içinde kullanılır sadece
            .circle, //containerin kenarlarını yuvarlak yapar daire

        color: color,
        border: Border.all(width: 2, color: color),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
