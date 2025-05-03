import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';
import 'User_signup_page.dart';
import 'forgotpassword.dart';

class User_Loginwrapper extends StatelessWidget {
  const User_Loginwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: User_LoginPage(),
    );
  }
}

class User_LoginPage extends StatefulWidget {
  const User_LoginPage({super.key});

  @override
  State<User_LoginPage> createState() => _User_LoginPageState();
}

class _User_LoginPageState extends State<User_LoginPage> {
  bool rememberMe = false;

  // Create controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Create a global key for the form state
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          });
        }
        if (state is AuthenticatedError) {
          print("Failed");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: defaultBlue,
          body: SafeArea(
            child: Form(
              key: _formKey, // Wrap with Form
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 160,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Welcome to Mall Buddy!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),const SizedBox(height: 10),
                            Text(
                              "User Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 40),

                            // Email Field with Validation
                            CustomTextForm(
                              hintText: "Enter your email",
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),

                            // Password Field with Validation
                            CustomTextForm(
                              hintText: "Enter your password",
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 60),
                            //
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       value: rememberMe,
                            //       onChanged: (bool? value) {
                            //         setState(() {
                            //           rememberMe = value ?? false;
                            //         });
                            //       },
                            //     ),
                            //     const Text("Remember Me"),
                            //   ],
                            // ),
                            // const SizedBox(height: 10),

                            // Login Button
                            // SizedBox(
                            //     height: 100,
                            //     child: Column(
                            //       children: [
                            //         state is Authloading
                            //             ? Text("Login...")
                            //             : Text(""),
                            //         state is Authloading
                            //             ? Loading_Widget()
                            //             : Text(""),
                            //       ],
                            //     )),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              color: state is Authloading
                                  ? Colors.blue.shade50
                                  : defaultBlue,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // If form is valid, send login event
                                  final authBloc =
                                      BlocProvider.of<AuthBloc>(context);
                                  authBloc.add(LoginEvent(
                                    Email: _emailController.text,
                                    Password: _passwordController.text,
                                  ));
                                }
                              },
                              child: state is Authloading
                                  ? Loading_Widget()
                                  : Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.only(left: 220),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),


                        const SizedBox(height: 140),

                            // Sign Up Section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "New to Mall Buddy?",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Usersignupwrapper(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: defaultBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                             ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
