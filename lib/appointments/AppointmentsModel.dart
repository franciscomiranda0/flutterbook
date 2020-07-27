import 'package:flutter_book/BaseModel.dart';

class Appointment {
  int id;
  String title;
  String description;
  String appointmentDate;
  String appointmentTime;

  String toString() {
    return "id = ${id}, description = ${description}, date = ${appointmentDate}, "
        "time = ${appointmentTime}";
  }
}

class AppointmentsModel extends BaseModel {
  String appointmentTime;

  void setAppointmentTime(String inAppointmentTime) {
    appointmentTime = inAppointmentTime;
    notifyListeners();
  }
}

AppointmentsModel appointmentsModel = AppointmentsModel();
