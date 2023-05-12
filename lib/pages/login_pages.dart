import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authservice/authentication.dart';
import 'launcher_page.dart';
import 'register_page_users.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Image.asset(
            'assets/b3.jpg',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/logo2.png',
                height: 200,
                width: 200,
              )),
          Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: Center(
                  child: Text(
                'LOGIN',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ))),
          Positioned(
            top: 280,
            left: 20,
            right: 20,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.email), labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid email address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.key), labelText: 'Password'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Provide a valid Password';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(errorMsg,
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w100,
                              fontSize: 8)),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('Forget password?',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w600,
                                fontSize: 10))),
                    SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton(
                      onPressed:_authentication,
                      child: Icon(
                        Icons.arrow_forward_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.teal.shade200,
                    ),
                  ],
                )),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(onTap:(){},
                  child: Container(
                    height: 40,
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/g.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Sign in with google',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w600,
                                fontSize: 10.5,
                                ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1)),
                  ),
                ),
                SizedBox(
                  width: 26,
                ),
                InkWell(onTap:(){},
                  child: Container(
                    height: 40,
                    width: 165,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/m.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Sign in with Microsoft',
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w600,
                                fontSize: 10,
                                ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 1)),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 25,
              right: 19,
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  child: Text('Donot have an account?',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 12)))),
        ],
      ),
    );
  }
  void _authentication() async{
    if(_formKey.currentState!.validate()){
      final email= _emailController.text;
      final password =_passwordController.text;
      try{
        final satus =await AuthService.login(email, password);
        if(mounted){

          Navigator.pushReplacementNamed(context, LauncherPage.routeName);
        }
      }on FirebaseAuthException catch(error){
        setState(() {
          errorMsg=error.message!;
        });
      }
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
