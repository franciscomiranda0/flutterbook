import 'package:flutter/material.dart';
import 'package:flutter_book/appointments/AppointmentsDBWorker.dart';
import 'package:flutter_book/appointments/AppointmentsEntry.dart';
import 'package:flutter_book/appointments/AppointmentsList.dart';
import 'package:flutter_book/appointments/AppointmentsModel.dart';
import 'package:scoped_model/scoped_model.dart';

class Appointments extends StatelessWidget {
  Appointments() {
    appointmentsModel.loadData("appointments", AppointmentsDBWorker.db);
  }

  Widget build(BuildContext inContext) {
    return ScopedModel<AppointmentsModel>(
      model: appointmentsModel,
      child: ScopedModelDescendant<AppointmentsModel>(
        builder: (BuildContext inContext, Widget inChild,
            AppointmentsModel inModel) {
          return IndexedStack(
            index: inModel.stackIndex,
            children: <Widget>[AppointmentsList(), AppointmentsEntry()],
          );
        },
      ),
    );
  }
}
