import 'package:flutter/material.dart';
import 'package:online_survey/controller/controller_form.dart';
import 'package:online_survey/model/form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Survey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Online Survey'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  void _submitForm() {
//kita cek validasi dari form
    if (_formKey.currentState.validate()) {
      FormFeedback formFeedback = FormFeedback(
          nameController.text, emailController.text, feedbackController.text);

      FormController formController = FormController((String response) {
        if (response == FormController.STATUS_SUCCESS) {
          _showSnackbar("Feeback berhasil disimpan");
        } else {
          _showSnackbar("Error");
        }
      });

      _showSnackbar("Menyimpan feedback");
      formController.submitForm(formFeedback);
    }
  }

  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukkan Nama';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (!value.contains("@")) {
                    return 'Masukkan Email yang Valid';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: feedbackController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Masukkan Feedback Anda';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Feedback',
                ),
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                  onPressed: _submitForm,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Submit Feedback"))
            ],
          ),
        ),
      ),
    );
  }
}
