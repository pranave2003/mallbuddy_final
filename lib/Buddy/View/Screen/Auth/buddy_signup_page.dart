import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../Controller/Bloc/Buddy_Authbloc/Buddyauthmodel/Buddyauthmodel.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../../../../Widgets/Constants/custom_field.dart';

class Buddysignupwrapper extends StatelessWidget {
  const Buddysignupwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuddyAuthBloc(),
      child: BuddySignupPage(),
    );
  }
}

class BuddySignupPage extends StatefulWidget {
  const BuddySignupPage({super.key});

  @override
  State<BuddySignupPage> createState() => _BuddySignupPageState();
}

class _BuddySignupPageState extends State<BuddySignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _aadhaarnumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  String? selectedGender;
  String? _selectedFileName;
  String? _selectedFilePath;
  String? _uploadedFileUrl;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _genderController.dispose();
    dobController.dispose();
    _aadhaarnumberController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final today = DateTime.now();
      int age = today.year - picked.year -
          ((today.month < picked.month || (today.month == picked.month && today.day < picked.day)) ? 1 : 0);

      final dobFormatted = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      dobController.text = "$dobFormatted , Age: $age";
    }
  }


  Future<void> _uploadFile() async {
    try {
      if (kIsWeb) {
        // For web, FilePicker works differently
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'pdf'],
        );
        if (result != null) {
          PlatformFile file = result.files.first;
          setState(() {
            _selectedFileName = file.name;
            _selectedFilePath = file.path;
          });

          // Upload to Firebase Storage
          final fileRef = FirebaseStorage.instance.ref().child('aadhaar_cards/${file.name}');
          await fileRef.putData(file.bytes!);  // Web uploads use bytes
          String downloadUrl = await fileRef.getDownloadURL();

          setState(() {
            _uploadedFileUrl = downloadUrl;
          });
        }
      } else {
        // For mobile platforms (Android/iOS), using FilePicker with file paths
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'pdf'],
        );
        if (result != null) {
          PlatformFile file = result.files.first;
          setState(() {
            _selectedFileName = file.name;
            _selectedFilePath = file.path;
          });

          // Upload to Firebase Storage
          final fileRef = FirebaseStorage.instance.ref().child('aadhaar_cards/${file.name}');
          await fileRef.putFile(File(file.path!)); // Upload mobile file
          String downloadUrl = await fileRef.getDownloadURL();

          setState(() {
            _uploadedFileUrl = downloadUrl;
          });
        }
      }
    } catch (e) {
      print("Error uploading file: $e");
    }
  }
  void _registerUser() {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select your gender")),
        );
        return;
      }

      if (_uploadedFileUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please upload your Aadhaar card")),
        );
        return;
      }

      BuddyModel user = BuddyModel(
        name: _usernameController.text,
        Gender: _genderController.text,
        Dob: dobController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        Aadhaarnumber: _aadhaarnumberController.text,
        aadhaarimage: _uploadedFileUrl!, // use the URL instead of file path
      );

      context.read<BuddyAuthBloc>().add(
          BuddySignupEvent(user: user, aadhaarFilePath: _uploadedFileUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
      listener: (context, state) {
        if (state is BuddyUnAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        }
        if (state is BuddyAuthenticatedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.toString())),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: defaultBlue,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Image.asset('assets/logo.png', width: 150),
                    ),
                  ),
                  const SizedBox(height: 30),
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
                              "Create your Mall Buddy Account",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 30),
                            CustomTextForm(
                              hintText: "User name",
                              controller: _usernameController,
                              validator: (value) => value!.isEmpty
                                  ? "Username is required"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: CustomTextForm(
                                  hintText: "Date of Birth",
                                  controller: dobController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Date of birth is required";
                                    }

                                    final dobString = value.split(" ").first; // extract just the date part
                                    final dob = DateTime.tryParse(dobString);
                                    if (dob == null) {
                                      return "Invalid date format";
                                    }

                                    final today = DateTime.now();
                                    final age = today.year - dob.year -
                                        ((today.month < dob.month || (today.month == dob.month && today.day < dob.day)) ? 1 : 0);

                                    if (age < 18) {
                                      return "You must be at least 18 years old to sign up";
                                    }

                                    return null;
                                  },

                                ),
                              ),
                            ),

                            const SizedBox(height: 15),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedGender,
                                  hint: const Text("Select Gender",
                                      style: TextStyle(color: Colors.black54)),
                                  isExpanded: true,
                                  items: ["Male", "Female", "Other"]
                                      .map((String value) {
                                    return DropdownMenuItem<String>(value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedGender = newValue;
                                      _genderController.text = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              hintText: "Aadhaar number",
                              controller: _aadhaarnumberController,
                              validator: (value) => value!.length != 12
                                  ? "Enter a valid 12-digit Aadhaar number"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: _uploadFile,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.upload_file,
                                        color: Colors.grey),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        _selectedFileName ?? "Upload Aadhaar",
                                        style: TextStyle(
                                          color: _selectedFileName == null
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              hintText: "Email address",
                              controller: _emailController,
                              validator: (value) =>
                              value!.isEmpty || !value.contains("@")
                                  ? "Enter a valid email"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              hintText: "Phone number",
                              controller: _phoneController,
                              validator: (value) => value!.length != 10
                                  ? "Enter a valid 10-digit phone number"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              hintText: "Password",
                              controller: _passwordController,
                              obscureText: true,
                              validator: (value) => value!.length < 6
                                  ? "Password must be at least 6 characters"
                                  : null,
                            ),
                            const SizedBox(height: 15),
                            CustomTextForm(
                              hintText: "Confirm Password",
                              controller: _confirmPasswordController,
                              obscureText: true,
                              validator: (value) =>
                              value != _passwordController.text
                                  ? "Passwords do not match"
                                  : null,
                            ),
                            const SizedBox(height: 10),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minWidth: MediaQuery.of(context).size.width,
                              height: 50,
                              color: defaultBlue,
                              onPressed: _registerUser,
                              child: state is BuddyAuthloading
                                  ? Loading_Widget()
                                  : const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
