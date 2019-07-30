import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget{
  @override
    State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final _formKey =GlobalKey<FormState>();
  final _scaffoldKey =GlobalKey<ScaffoldState>();

  String _email, _password;
  bool _isSubmitting =false;
  bool _showObsecure =true;

  Widget _showText(){
    return Text('Login', style: Theme.of(context).textTheme.headline);
  }

  Widget _showEmail(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
        onSaved: (val) => _email =val,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          hintText: 'Enter Your Email',
          icon: Icon(Icons.mail, color: Colors.white)
        ),
      ),
    );
  }

  Widget _showPassword(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.length < 6 ? 'Password Too Short' : null,
        onSaved: (val) => _password =val,
        obscureText: _showObsecure,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() => _showObsecure != _showObsecure);
            },
            child: Icon(
              _showObsecure
              ? Icons.visibility
              : Icons.visibility_off
            ),
          ),
          labelText: 'Password',
          hintText: 'Enter Your Password',
          icon: Icon(Icons.lock, color: Colors.white)
        ),
      ),
    );
  }

  Widget _showButtons(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          _isSubmitting 
          ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
          )
          : RaisedButton(
            child: Text('Login'),
            color: Theme.of(context).primaryColor,
            elevation: 0.8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            onPressed: _submit,
          ),
          FlatButton(
            child: Text('New User ? Register'),
            onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
          )
        ],
      ),
    );
  }

  void _submit(){
    final form =_formKey.currentState;

      setState(() => _isSubmitting =true);

      if(form.validate()){
        form.save();
        _registerUser();
      }else{
        setState(() => _isSubmitting =false);
      }

  }

  void _registerUser() async {
    
    http.Response response =await http.post('', 
    body: {
      "email": _email,
      "password": _password
    });

    final responseBody =jsonDecode(response.body);

    if(response.statusCode == 200){
      setState(() => _isSubmitting =false);
      _saveUser(responseBody);
      _showSuccessSnack();
      _redirectUser();
    }else{
      setState(() => _isSubmitting =false);
      
    }

  }


  void _saveUser(responseBody) async {
    final prefs =await SharedPreferences.getInstance();
    
    Map<String, dynamic> user =responseBody['user'];
    user.putIfAbsent('jwt', responseBody['jwt']);

    final String storedUser =jsonEncode(user);

    // prefs.setString('user', user);

  }

  void _showSuccessSnack(){
    final snackbar =SnackBar(
      content: Text('Register Success',
      style: TextStyle(color: Colors.green)),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);

  }

  void _showErrorSnack(errorMessage){
    final snackbar =SnackBar(
      content: Text(errorMessage,
      style: TextStyle(color: Colors.red)),
    );

    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _redirectUser(){
    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, '/products');
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _showText(),
                  _showEmail(),
                  _showPassword(),
                  _showButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}