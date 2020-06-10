import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:online_survey/model/form.dart';

class FormController {
  final void Function(String) callback;

  static const String URL =
      "https://script.google.com/macros/s/AKfycbwMtjQCfigdnd3_8QtNB6T_IbHnmwWTN_H6lGJ9IytoCT9OBG8/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FormFeedback formFeedback) async {
    try {
      await http
          .get(URL + formFeedback.toParams())
          .then((value) => callback(convert.jsonDecode(value.body)['status']));
    } catch (e) {
      print(e);
    }
  }
}
