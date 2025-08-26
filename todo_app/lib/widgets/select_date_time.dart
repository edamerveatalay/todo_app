import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/widgets/common_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SelectDataTime extends ConsumerWidget {
  const SelectDataTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
              title: 'Date',
              hintText: DateFormat.yMMMd()
                  .format(date), //yMMMd() → hazır bir tarih formatıdır.
              readOnly: true,
              controller: TextEditingController(),
              suffixIcon: IconButton(
                onPressed: () => Helpers.selectDate(context, ref),
                icon: const FaIcon(FontAwesomeIcons.calendar),
              )),
        ),
        const Gap(10),
        Expanded(
          child: CommonTextField(
            title: 'Time',
            hintText: Helpers.timeToString(time),
            readOnly: true,
            controller: TextEditingController(),
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: const FaIcon(FontAwesomeIcons.clock),
            ),
          ),
        ),
      ],
    );
  }

  void _selectTime(BuildContext context, WidgetRef ref) async {
    // 1. Zaman seçmek için async fonksiyon tanımlanıyor
    TimeOfDay? pickedTime = await showTimePicker(
      // 2. showTimePicker açılıyor ve kullanıcı seçim yapana kadar bekleniyor
      context:
          context, // 3. TimePicker’ın hangi BuildContext içinde açılacağını söylüyoruz
      initialTime: TimeOfDay
          .now(), // 4. Başlangıç zamanı olarak mevcut saat gösteriliyor
    );

    if (pickedTime != null) {
      // 5. Kullanıcı bir zaman seçtiyse (iptal etmediyse)
      //print(pickedTime); // 6. Seçilen zamanı konsola yazdırıyoruz
      ref.read(timeProvider.notifier).state = pickedTime;
    }
  }
}
