import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/Bloc/Buddy_Authbloc/Buddyauthmodel/Buddyauthmodel.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/Shopauthmodel/Shopauthmodel.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';

class BuddyEditPage extends StatefulWidget {
  final String BId;
  final String Buddyname;
  final String phone;
  final String Gender;

  const BuddyEditPage({
    super.key,
    required this.BId,
    required this.Buddyname,
    required this.phone,
    required this.Gender,
  });

  @override
  _BuddyEditPageState createState() => _BuddyEditPageState();
}

class _BuddyEditPageState extends State<BuddyEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController BuddyNameController;
  late TextEditingController phoneController;
  String? selectedGender; // Holds selected floor value

  final List<String> Gender = [
    'Male',
    'Female',
    'Other',

  ]; // List of floor options

  @override
  void initState() {
    super.initState();
    BuddyNameController = TextEditingController(text: widget.Buddyname);
    phoneController = TextEditingController(text: widget.phone);
    selectedGender = Gender.contains(widget.Gender) ? widget.Gender : Gender[0];
  }

  // @override
  // void dispose() {
  //   shopNameController.dispose();
  //   ownerNameController.dispose();
  //   phoneController.dispose();
  //   emailController.dispose();
  //   super.dispose();
  // }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildFloorDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        decoration: const InputDecoration(
          labelText: "Select Gender",
          border: InputBorder.none,
        ),
        items: Gender.map((Gender) {
          return DropdownMenuItem(
            value: Gender,
            child: Text(Gender),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value!;
          });
        },
      ),
    );
  }

  // Widget _buildActionButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: [
  //       _buildActionButton("Accept"),
  //       _buildActionButton("Reject"),
  //     ],
  //   );
  // }

  // Widget _buildActionButton(String action) {
  //   bool isSelected = selectedAction == action;
  //
  //   return ElevatedButton(
  //     onPressed: () {
  //       setState(() {
  //         selectedAction = action;
  //       });
  //     },
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: isSelected ? Colors.blue : Colors.white,
  //       side: const BorderSide(color: Colors.grey),
  //       padding: const EdgeInsets.symmetric(horizontal: 275, vertical: 12),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     ),
  //     child: Text(
  //       action,
  //       style: TextStyle(
  //         color: isSelected ? Colors.white : Colors.black,
  //         fontSize: 16,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Edit Shop Information")),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: ListView(children: [
                  Center(
                    // Centering the container
                    child: Container(
                      width: 1250,
                      height: 550,
                      // Set a specific width
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border:
                        Border.all(color: Colors.grey.shade300, width: 1.5),
                      ),
                      child: Column(
                        mainAxisSize:
                        MainAxisSize.min, // Reduce unnecessary height
                        children: [
                          _buildTextField(
                              "Enter Buddy Name", BuddyNameController),
                          _buildTextField(
                              "Enter Contact Number", phoneController),
                          _buildFloorDropdown(),
                          const SizedBox(height: 28),
                          // _buildActionButtons(),
                          const SizedBox(height: 60),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Shop details updated successfully!"),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              BuddyModel Buddy = BuddyModel(
                                  uid: widget.BId,
                                  name: BuddyNameController.text,
                                  phone: phoneController.text,
                                  Gender: selectedGender!,
                              );

                              context
                                  .read<BuddyAuthBloc>()
                                  .add(EditBuddy(Buddy: Buddy));
                              // Show success alert box
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Success"),
                                  content: const Text(
                                      "Shop details updated successfully!"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                        Navigator.of(context)
                                            .pop(); // Go back to the previous page
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 528, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Update Shop Details",
                              style:
                              TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
