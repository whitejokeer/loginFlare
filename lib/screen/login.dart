import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import '../controller/rest_request.dart';
import '../database/database_user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  RestDataRequest api = new RestDataRequest();
  String _email, _password;

  ///This should be in a splash screen
  loguedInQuestion() async {
    var db = new DatabaseHelper();
    var isLoggedIn = await db.isLoggedIn();
    isLoggedIn ? Navigator.of(context).pushReplacementNamed('/home') : null;
  }

  void initState() {
    super.initState();
    loguedInQuestion();
  }

  loginRequest() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      api.login(_email, _password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      height: 200.0,
      width: 150.0,
      child: FlareActor("assets/prueba 1.flr",
          alignment: Alignment.center, animation: "Idle"),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (val) {
        return val.isEmpty ? "Este campo es obligatorio" : null;
      },
      onSaved: (val) => _email = val,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (val) {
        return val.isEmpty ? "Este campo es obligatorio" : null;
      },
      onSaved: (val) => _password = val,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: loginRequest,
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  email,
                  SizedBox(height: 8.0),
                  password,
                ],
              ),
            ),
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
