import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {

  @override
    State<StatefulWidget> createState() => new _LoginPageState();
}

enum Formtype {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {

  final formKey = new GlobalKey<FormState>();

  String    _email;
  String    _password;
  Formtype  _formtype = Formtype.login;

  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is valid. Email: $_email, Password: $_password');
      // return true;
    }
    else {
      print('Form is Invalid. Email: $_email, Password: $_password');
      // return false;
    }
  }

  void moveToRegister() {
    setState(() {
      _formtype = Formtype.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formtype = Formtype.login;
    });
  }

  /* Need to figure out firebase integration, conflicting packages*/
  // void validateAndSubmit() async {
  //   if (validateAndSave()) {
  //     try {
  //       FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
  //       print('Signed in: ${user.uid}');
  //     } 
  //     catch (e) {
  //       print('Error: $e');
  //     }
  //   }
  // }

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter login demo'),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButtons(),
            ),
          ), 
        ),
      );
    }

    List<Widget> buildInputs() {
      return [
        new TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          validator: (value) => value.isEmpty ? 'Email field can\'t be empty' : null,
          onSaved: (value) => _email = value,
        ),
        new TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          validator: (value) => value.isEmpty ? 'Password field can\'t be empty' : null,
          onSaved: (value) => _password = value,                  
        ),
      ];
    }
    List<Widget> buildSubmitButtons() {
      if (_formtype == Formtype.login) {
        return [
          new RaisedButton(
            child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
            // onPressed: validateAndSubmit,
            onPressed: validateAndSave,
          ),
          new FlatButton(
            child: new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
            onPressed: moveToRegister,
          )
        ];
      } else {
        return [
          new RaisedButton(
            child: new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
            // onPressed: validateAndSubmit,
            onPressed: validateAndSave,
          ),
          new FlatButton(
            child: new Text('Have an account? Login', style: new TextStyle(fontSize: 20.0)),
            onPressed: moveToLogin,
          )
        ];
      }
    }
}