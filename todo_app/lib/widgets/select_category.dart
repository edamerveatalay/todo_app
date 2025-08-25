import 'package:flutter/material.dart';
import 'package:todo_app/providers/category_provider.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/widgets/circle_container.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/widgets/widgets.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// ConsumerWidget kullanıyoruz çünkü Riverpod ile state okuma yapacağız.

    final selectedCategory = ref.watch(categoryProvider);
    final categories = TaskCategories.values
        .toList(); // Enum olan TaskCategories'in tüm değerlerini listeye çeviriyoruz

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text(
            'Category',
            style: context.textTheme.titleLarge,
          ),
          const Gap(10),
          Expanded(
              child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal, // Liste yatay kaydırılabilir

            itemBuilder: (ctx, index) {
              final category = categories[index]; // Listedeki mevcut kategori
              return InkWell(
                onTap: () {
                  // Kullanıcı kategoriye tıkladığında seçili kategori güncelleniyor

                  ref.read(categoryProvider.notifier).state = category;
                },
                borderRadius: BorderRadius.circular(30),
                child: CircleContainer(
                  color: category.color.withValues(alpha: 0.3),
                  child: Icon(
                    category.icon,
                    color: category == selectedCategory
                        ? context
                            .colorScheme.primary // Seçili kategori ise ana renk
                        : category.color, // Değilse kendi rengi
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) =>
                const Gap(8), // Kategoriler arasında 8px boşluk
            itemCount: categories.length, // Toplam kategori sayısı
          ))
        ],
      ),
    );
  }
}
/*Riverpod state, Flutter uygulamalarında state (durum) yönetimi için kullanılan bir yapıdır.
State, bir widget’ın veya uygulamanın anlık verilerini ifade eder (örneğin, seçili kategori, kullanıcı adı, sayaç değeri).*/
