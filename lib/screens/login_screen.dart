import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_keep/helpers/auth_helper.dart';
import 'package:note_keep/models/login_cred_model.dart';
import 'package:note_keep/screens/home_screen.dart';
import 'package:note_keep/screens/signup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginCredModel _loginCredModel = LoginCredModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.user,
                      size: 18.0,
                    ),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (newValue) => _loginCredModel.email = newValue,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      FontAwesomeIcons.lock,
                      size: 18.0,
                    ),
                  ),
                ),
                obscureText: true,
                onSaved: (newValue) => _loginCredModel.password = newValue,
                validator: (value) =>
                    value!.length < 6 ? 'Password minimal 6 characters' : null,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logging in...')),
                      );
                      try {
                        bool result = await AuthHelper.instance
                            .loginEmailPassword(_loginCredModel.email!,
                                _loginCredModel.password!);
                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login Success')),
                          );
                          Get.to(() => const HomeScreen());
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    backgroundColor: Color.fromARGB(255, 162, 117, 80), // Ganti warna sesuai keinginan Anda
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Log In'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
                width: 12.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(color: Color.fromARGB(255, 162, 117, 80)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
