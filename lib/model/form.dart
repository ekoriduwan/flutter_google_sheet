//model untuk menampung form feedbak

class FormFeedback {
  String _name;
  String _email;
  String _feedback;

  FormFeedback(this._name, this._email, this._feedback);

//method untuk mengGET

  String toParams() => "?nama=$_name&email=$_email&feedback=$_feedback";

//formatnya akan seperti ini: URL?nama="xxxnama"&email="email.xxx"&feedback="yyyyyy"

}
