import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget{
  @override
    State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  final _formKey =GlobalKey<FormState>();
  final _scaffoldKey =GlobalKey<ScaffoldState>();

  String _username, _email, _password;
  bool _isSubmitting =false;
  bool _showObsecure =true;

  Widget _showText(){
    return Text('Register', style: Theme.of(context).textTheme.headline);
  }

  Widget _showUsername(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        validator: (val) => val.length < 6 ? 'Username Too Short' : null,
        onSaved: (val) => _username =val,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
          hintText: 'Enter Your Username',
          icon: Icon(Icons.face, color: Colors.white)
        ),
      ),
    );
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
          RaisedButton(
            child: Text('Register'),
            color: Theme.of(context).primaryColor,
            elevation: 0.8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            onPressed: _submit,
          ),
          FlatButton(
            child: Text('Existing User ? Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          )
        ],
      ),
    );
  }

  void _submit(){
    final form =_formKey.currentState;
    print('Tadaaaa');
      if(form.validate()){
        form.save();
        _registerUser();
      }else{

      }

  }

  void _registerUser() async {
    
    http.Response response =await http.post('', 
    body: {
      "username": _username,
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
      //   title: Text('Register'),
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
                  _showUsername(),
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