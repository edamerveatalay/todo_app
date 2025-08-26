import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/routes/route_location.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/utils/helpers.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/display_white_text.dart';
import 'package:todo_app/widgets/common_text_field.dart';
import 'package:todo_app/widgets/select_category.dart';
import 'package:todo_app/widgets/select_date_time.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(
          BuildContext context,
          GoRouterState //Bu parametre aslında builder fonksiyonuna route ile ilgili bilgi taşıyor.
              state) => //builder adında fonksiyon, HomeScreen döndürüyor
//build con vs Fonksiyonun aldığı parametreler //
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  //Bu, CreateTaskScreen için state oluşturan class.(durum)

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
//Bunlar TextField’larda girilen metni yönetmek için kullanılan kontrolcüler.

  @override
  void dispose() {
    //Flutter’da Widget yok edilirken (örn. başka sayfaya geçince, bu sayfa kapanınca) çağrılan bir yaşam döngüsü (lifecycle) metodudur.
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  } //dispose() içinde bu controller’ları temizliyoruz (.dispose() metodu çağrılır) → RAM boşaltılır.

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
                controller: _titleController,
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
                controller: _noteController,
              ),
              const Gap(120),
              ElevatedButton(
                onPressed:
                    _createTask, //Kullanıcının girdiği title (başlık) ve note (not) değerlerini TextField’dan alır.

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

  /* Özetle bu fonksiyon:
Kullanıcının yazdığı başlık ve notu alır, seçilen tarih, saat ve kategoriyi okur.
Başlık boş değilse yeni bir Task nesnesi oluşturur.
Oluşturulan Task’ı Riverpod notifier üzerinden veritabanına kaydeder.*/

  void _createTask() async {
    //Eğer başlık boşsa → Konsola "empty Title" yazar.
    final title = _titleController.text
        .trim(); //Kullanıcının yazdığı başlık ve notu alıyor.
    //trim() → Başında ve sonunda boşluk varsa siliyor.
    final note = _noteController.text.trim();
    //Yani kullanıcı arayüzünde seçtiği tarih, saat ve kategori burada okunuyor.
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      //Eğer başlık boş değilse (kullanıcı bir şey yazdıysa) → görev oluştur.
      final task = Task(
        //Task sınıfından bir nesne oluşturuluyor.
        title: title,
        note: note,
        time: Helpers.timeToString(
            time), //seçilen zamanı string formatına çeviriyor.
        date: DateFormat.yMMMd().format(date),
        category: category,
        isCompleted: false,
      );
      await ref.read(taskProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackBar(context, 'Task created Successfuly');
        context.go(RouteLocation.home);
      }); //Riverpod ile Task yönetici (notifier) nesnesini alıyor.
    } else {
      AppAlerts.displaySnackBar(context, 'Task title cannot be empty');
    }
    /* ref.read(taskProvider.notifier) → Riverpod ile Task yönetici (notifier) nesnesini alıyor.
createTask(task) → bu notifier üzerinden task’ı veritabanına ekleyen fonksiyonu çağırıyor.
await → veritabanına ekleme işleminin tamamlanmasını bekliyor.
.then((value) {}) → işlemin sonrası için boş bir callback verilmiş.*/
  }
}
