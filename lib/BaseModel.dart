import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  int stackIndex = 0;
  List entityList = [];
  var entityBeingEdited;
  String chosenDate;

  void loadData(String inEntityType, dynamic inDatabase) async {
    entityList = await inDatabase.getAll();
    notifyListeners();
  }

  void setChosenDate(String inDate) {
    chosenDate = inDate;
    notifyListeners();
  }

  void setStackIndex(int inStackIndex) {
    stackIndex = inStackIndex;
    notifyListeners();
  }
}
