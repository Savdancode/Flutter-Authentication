import 'package:flutter/material.dart';
import 'package:splash_and_firebase/Authen/classAuth.dart';
import 'package:splash_and_firebase/Authen/signIn.dart';
import 'package:splash_and_firebase/Screens/homeScreen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _email = TextEditingController();
  TextEditingController _passwoord = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  bool _isHiden = true;
  void _showPass() {
    setState(() {
      _isHiden = !_isHiden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: isLoading == false
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          autofocus: false,
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter email' : null,
                          controller: _email,
                          decoration: InputDecoration(
                            focusColor: Colors.green,
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          validator: (value) => value!.length < 6
                              ? 'Enter more than 6 charactor'
                              : null,
                          controller: _passwoord,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: InkWell(
                              onTap: _showPass,
                              child: _isHiden
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : Icon(Icons.visibility),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          obscureText: _isHiden,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              AuthClass()
                                  .createAccount(
                                      email: _email.text.trim(),
                                      password: _passwoord.text.trim())
                                  .then((value) {
                                if (value == "Account created") {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DashBoardPage()),
                                      (route) => false);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value)));
                                }
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 50,
                          minWidth: MediaQuery.of(context).size.width / 2,
                          color: Colors.green,
                          child: Text('Sign Up'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ready have account ?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()),
                                    (route) => false);
                              },
                              child: Text('Sign In'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
