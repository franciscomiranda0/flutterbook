import 'package:flutter_book/appointments/AppointmentsModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../utils.dart' as utils;

class AppointmentsDBWorker {
  AppointmentsDBWorker._();

  static final AppointmentsDBWorker db = AppointmentsDBWorker._();
  Database _db;

  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  Future<Database> init() async {
    String path = join(utils.docsDir.path, "appointments.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS appointments("
          "id INTERGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "appointmentDate TEXT,"
          "appointmentTime TEXT)");
    });
    return db;
  }

  Future create(Appointment inAppointment) async {
    Database db = await database;
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS is FROM appointments");
    int id = val.first["id"];

    if (id == null) {
      id = 1;
    }

    return await db.rawInsert(
        "INSERT INTO appointments(id, title, description, appointmentDate, appointmentTime) "
        "VALUES(?, ?, ?, ?, ?)",
        [
          id,
          inAppointment.title,
          inAppointment.description,
          inAppointment.appointmentDate,
          inAppointment.appointmentTime
        ]);
  }

  Future<Appointment> get(int inID) async {
    Database db = await database;
    var rec =
        await db.query("appointments", where: "id = ?", whereArgs: [inID]);
    return appointmentFromMap(rec.first);
  }

  Future<List> getAll() async {
    Database db = await database;
    var recs = await db.query("appointments");
    return recs.isNotEmpty
        ? recs.map((e) => appointmentFromMap(e)).toList()
        : [];
  }

  Future update(Appointment inAppointment) async {
    Database db = await database;
    return await db.update("appointments", appointmentToMap(inAppointment),
        where: "id = ?", whereArgs: [inAppointment.id]);
  }

  Future delete(int inID) async {
    Database db = await database;
    return await db.delete("appointments", where: "id = ?", whereArgs: [inID]);
  }

  Map<String, dynamic> appointmentToMap(Appointment inAppointment) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = inAppointment.id;
    map["title"] = inAppointment.title;
    map["description"] = inAppointment.description;
    map["appointmentDate"] = inAppointment.appointmentDate;
    map["appointmentTime"] = inAppointment.appointmentTime;
    return map;
  }

  Appointment appointmentFromMap(Map inMap) {
    Appointment appointment = Appointment();
    appointment.id = inMap["id"];
    appointment.title = inMap["tile"];
    appointment.description = inMap["description"];
    appointment.appointmentDate = inMap["appointmentDate"];
    appointment.appointmentTime = inMap["appointmentTime"];
    return appointment;
  }
}
