import 'package:flutter/material.dart';
import 'package:supplier_portal_flutter/screens/job_location_screen.dart';
import '../services/auth_service.dart';


class Login extends StatefulWidget {
  const Login({super.key, required this.authService});

  final AuthService authService;

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => JobLocationsScreen(authService: widget.authService)),
    );
  }

  void checkLoggedIn() async {
    final isLoggedIn = await widget.authService.isLoggedIn();
    if (isLoggedIn) {
      navigateToHome();
    }
  }

  void loggedIn() async {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      final token = await widget.authService.login(email, password);

      if (token != null) {
        navigateToHome();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Credentials')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill input')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/images/ImpulzLogo.jpg'),
              ),
              // form of email, password and login button
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // email
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), hintText: "Email"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      // password
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Password"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      // login button
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              )),
                              backgroundColor: MaterialStateProperty.all<
                                  Color>(Theme.of(
                                      context)
                                  .colorScheme
                                  .inversePrimary), // Change background color
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary), // Change text color
                            ),
                            onPressed: () {
                              debugPrint("onPressed");
                              loggedIn();

                            },
                            child: const Text(
                              'Login',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const SafeArea(
            child: BottomAppBar(
          height: 45,
          child: Center(
            child: Text(
              'Impulz Technologies LLC © 2023', // Updated footer text
              style: TextStyle(
                color: Colors.grey, // Set the desired color for the footer text
                fontSize: 16,
              ),
            ),
          ),
        )),
      ),
    );
  }
}