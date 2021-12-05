import 'package:shared_preferences/shared_preferences.dart';

class FormUtil{


  static String emptyValidator(value, {String message}){
    if (value.isEmpty) {
      return message != null ? message : 'Tidak boleh kosong';
    } else {
      return null;
    }
  }


}