import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Controller/Bloc/Shop_Authbloc/Shopauthmodel/Shopauthmodel.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';

class Shopsignupwrapper extends StatelessWidget {
  const Shopsignupwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAuthBloc(),
      child: ShopSignupPage(),
    );
  }
}

class ShopSignupPage extends StatefulWidget {
  const ShopSignupPage({super.key});

  @override
  State<ShopSignupPage> createState() => _ShopSignupPageState();
}

class _ShopSignupPageState extends State<ShopSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? selectedFloor; // Store selected floor
  File? _imageFile;

  @override
  void dispose() {
    _shopNameController.dispose();
    _ownerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to pick an image
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Function to validate and register user
  void _registerUser() {
    if (_formKey.currentState?.validate() ?? false) {
      ShopModel user = ShopModel(
        Shopname: _shopNameController.text,
        Selectfloor: selectedFloor ?? '',
        Ownername: _ownerNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
      );
      // Trigger the sign-up event
      context.read<ShopAuthBloc>().add(ShopSignupEvent(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAuthBloc, ShopAuthState>(
      listener: (context, state) {
        if (state is ShopUnAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
        if (state is ShopAuthenticatedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.toString())),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: defaultBlue,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: Image.asset('assets/logo.png', width: 150),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Create your Mall Buddy Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 15),

                            // **Image Upload Section**
                            // GestureDetector(
                            //   onTap: _pickImage,
                            //   child: Container(
                            //     width: double.infinity,
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(10),
                            //       border: Border.all(color: Colors.black54),
                            //     ),
                            //     child: _imageFile == null
                            //         ? const Center(
                            //       child: Text("Tap to upload image", style: TextStyle(color: Colors.black54)),
                            //     )
                            //         : ClipRRect(
                            //       borderRadius: BorderRadius.circular(10),
                            //       child: Image.file(_imageFile!, width: double.infinity, height: 150, fit: BoxFit.cover),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(height: 20),

                            // **Row with Shop Name and Floor Selection**
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CustomTextForm(
                                    controller: _shopNameController,
                                    hintText: "Shop name",
                                    validator: (value) => value!.isEmpty
                                        ? "Shop name is required"
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedFloor,
                                        hint: const Text("Select floor",
                                            style: TextStyle(
                                                color: Colors.black54)),
                                        isExpanded: true,
                                        items: [
                                          "Ground Floor",
                                          "First Floor",
                                          "Second Floor",
                                          "Third Floor",
                                          "Fourth Floor"
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                              value: value, child: Text(value));
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedFloor = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),
                            CustomTextForm(
                              controller: _ownerNameController,
                              hintText: "Owner name",
                              validator: (value) => value!.isEmpty
                                  ? "Owner name is required"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              controller: _emailController,
                              hintText: "Email address",
                              validator: (value) =>
                                  value!.isEmpty || !value.contains("@")
                                      ? "Enter a valid email"
                                      : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              controller: _phoneController,
                              hintText: "Phone number",
                              validator: (value) => value!.length != 10
                                  ? "Enter a valid 10-digit phone number"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              controller: _passwordController,
                              hintText: "Password",
                              obscureText: true,
                              validator: (value) => value!.length < 6
                                  ? "Password must be at least 6 characters"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              controller: _confirmPasswordController,
                              hintText: "Confirm Password",
                              obscureText: true,
                              validator: (value) =>
                                  value != _passwordController.text
                                      ? "Passwords do not match"
                                      : null,
                            ),
                            const SizedBox(height: 25),

                            // **Register Button**
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              color: defaultBlue,
                              onPressed: _registerUser,
                              child: const Text("Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),

                            const SizedBox(height: 100),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      color: defaultBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
