import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  Color _lengthColor = const Color.fromRGBO(74, 78, 113, 1);
  Color _uppercaseLowercaseColor = const Color.fromRGBO(74, 78, 113, 1);
  Color _digitColor = const Color.fromRGBO(74, 78, 113, 1);

  void _validatePassword(String password) {
    setState(() {
      _lengthColor =
          password.length < 8 || password.length > 64 || password.contains(' ')
              ? Colors.red
              : Colors.green;
      _uppercaseLowercaseColor =
          !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])').hasMatch(password)
              ? Colors.red
              : Colors.green;
      _digitColor =
          !RegExp(r'^(?=.*\d)').hasMatch(password) ? Colors.red : Colors.green;
    });
  }

  void _showSignUpSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign up success'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue.shade50,
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/stars.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(74, 78, 113, 1),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: ValidationBuilder().email().build(),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Create your password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        _validatePassword(value ?? '');
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '8 characters or more (no spaces)',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: _lengthColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'Uppercase and lowercase letters',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: _uppercaseLowercaseColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'At least one digit',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: _digitColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 40.0),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            if (_lengthColor == Colors.green &&
                                _uppercaseLowercaseColor == Colors.green &&
                                _digitColor == Colors.green) {
                              _showSignUpSuccessDialog();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Sign up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
