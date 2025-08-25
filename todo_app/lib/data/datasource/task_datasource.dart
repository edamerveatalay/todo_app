import 'package:sqflite/sqfLite.dart'; //Verileri cihazda saklamak istiyoruz (ör. görevler, notlar).
//sqflite = Flutter için SQLite erişim paketi.
import 'package:path/path.dart';
import 'package:todo_app/data/models/task.dart';
import 'package:todo_app/utils/utils.dart'; // Dosya yollarını birleştirmek için (join)

//iOS ve Android’de dosya yolları farklıdır. join() ile platform bağımsız yol oluşturuyoruz.
class TaskDatasource {
  //Bu sınıf, CRUD (Create, Read, Update, Delete) işlemlerini yapacak.
  static final TaskDatasource _instance = TaskDatasource
      ._(); // Singleton: Uygulama boyunca tek bir TaskDatasource olsun.
  // _instance: sınıfın tek örneği

  factory TaskDatasource() => _instance;
  // Özel (private) kurucu: Dışarıdan çağrılamaz, sadece sınıf içinden
//TaskDatasource() çağrıldığında hep _instance döner.
  TaskDatasource._() {
    // İsterseniz burada tetiklersiniz; asıl garanti 'database' getter'ında.

    _initDB(); //Özel constructor (dışarıdan erişilemez).
  } //DB hazırlığı otomatik başlar.

  static Database? _database; // Veritabanı bağlantısını tutacağımız değişken

  Future<Database> get database async {
    // Veritabanı bağlantısına erişmek için kullanacağımız getter
    // - Eğer bağlantı yoksa (_database == null) önce oluşturur
    // - Varsa aynı bağlantıyı döndürür (kaynak tasarrufu + tutarlılık)
    _database ??= await _initDB(); // "Yoksa oluştur" kısaltması

    return _database!;
  }

//_database = Sadece bağlantıyı saklayan değişken.
//database getter = Bu değişkeni kontrol eden ve gerektiğinde oluşturan yöntem.
  Future<Database> _initDB() async {
    //asenkron fonk çünkü diskten dosya oluşturmak veya açmak zaman alır
    final dbPath =
        await getDatabasesPath(); //getDatabasesPath() → Cihazda veritabanı dosyalarının bulunduğu klasör yolunu verir.
    //await → Bu işlem zaman alabilir, o yüzden bekliyoruz.

    final path = join(dbPath,
        DBKeys.dbName); //Burada, klasör yolu + dosya adı birleştiriliyor.
    //path değişkeni → Tam veritabanı dosyasının yolu.
    return openDatabase(
      //veritabanını açar yoksa oluştur oncreate ile varsa aç
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    //Bu fonksiyon veritabanı ilk kez oluşturulduğunda çalışır.
//db → Yeni oluşturulan veritabanı.
    await db.execute('''
  CREATE TABLE ${DBKeys.dbTable}(
  ${DBKeys.idColumn}INTEGER PRIMARY KEY AUTOINCREMENT,

  ${DBKeys.titleColumn} TEXT,
${DBKeys.noteColumn} TEXT,
${DBKeys.dateColumn} TEXT,
${DBKeys.timeColumn} TEXT,
${DBKeys.categoryColumn} TEXT,
${DBKeys.isCompletedColumn} INTEGER,

  
  )
      ''');
  }

  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      //transaction → veritabanında güvenli bir işlem başlatır.
      return await txn.insert(DBKeys.dbTable,
          task.toJson(), //Task nesnesini SQLite’ın anlayacağı Map formatına çevirir.
          conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        DBKeys.dbTable, //// Hangi tablo
        task.toJson(), // Güncellenecek veriler
        where: 'id = ?', // Hangi kaydı güncelleyeceğiz
        whereArgs: [
          task.id
        ], //Filtreleme yapıyoruz, yalnızca seçili kaydı hedef alıyoruz.
      );
    });
  }

  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.delete(
        DBKeys.dbTable, // Hangi tablo
        where: 'id = ?', // Hangi kaydı sileceğiz
        whereArgs: [task.id],
      );
    });
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      DBKeys.dbTable,
      orderBy: "id DESC", // Son eklenen en üstte olsun
    );
    return List.generate(
      data.length,
      (index) =>
          Task.fromJson(data[index]), // Map’i tekrar Task nesnesine çevir
    ); //List.generate → Map formatındaki veriyi Task nesnesine dönüştürür, uygulamada kullanılabilir hale getirir.
  }
}
//instance burada DB yöneticisi nesnesi.
//Initialize kelimesinin kısaltması → "Başlatmak" anlamında.
