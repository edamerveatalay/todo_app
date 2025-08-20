import 'package:flutter/material.dart';
import 'package:todo_app/utils/utils.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer(
      {super.key,
      this.child,
      this.height}); //child ve height widgetlarının tekrar kullanılabilmesini sağlr
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final colors = context.colorScheme;

    return Container(
      width: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.colorScheme.primaryContainer,
      ),
      child: child,
    );
  }
}
