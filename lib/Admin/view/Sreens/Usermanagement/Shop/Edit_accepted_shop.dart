import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Controller/Bloc/Shop_Authbloc/Shopauthmodel/Shopauthmodel.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';

class ShopEditPage extends StatefulWidget {
  final String shopId;
  final String Shopname;
  final String ownerName;
  final String phone;
  final String floor;

  const ShopEditPage({
    super.key,
    required this.shopId,
    required this.Shopname,
    required this.ownerName,
    required this.phone,
    required this.floor,
  });

  @override
  _ShopEditPageState createState() => _ShopEditPageState();
}

class _ShopEditPageState extends State<ShopEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController shopNameController;
  late TextEditingController ownerNameController;
  late TextEditingController phoneController;
  String? selectedFloor; // Holds selected floor value
  String? selectedAction; // Holds selected action (Accept/Reject)

  final List<String> floors = [
    'Ground Floor',
    '1st Floor',
    '2nd Floor',
    '3rd Floor',
    '4th Floor',
    '5th Floor'
  ]; // List of floor options

  @override
  void initState() {
    super.initState();
    shopNameController = TextEditingController(text: widget.Shopname);
    ownerNameController = TextEditingController(text: widget.ownerName);
    phoneController = TextEditingController(text: widget.phone);
    selectedFloor = floors.contains(widget.floor) ? widget.floor : floors[0];
    selectedAction = null; // No button is selected initially
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
        value: selectedFloor,
        decoration: const InputDecoration(
          labelText: "Select Floor",
          border: InputBorder.none,
        ),
        items: floors.map((floor) {
          return DropdownMenuItem(
            value: floor,
            child: Text(floor),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedFloor = value!;
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

  Widget _buildActionButton(String action) {
    bool isSelected = selectedAction == action;

    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedAction = action;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        side: const BorderSide(color: Colors.grey),
        padding: const EdgeInsets.symmetric(horizontal: 275, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        action,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

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
                              "Enter Shop Name", shopNameController),
                          _buildTextField(
                              "Enter Owner's Name", ownerNameController),
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
                              ShopModel shop = ShopModel(
                                  uid: widget.shopId,
                                  Ownername: ownerNameController.text,
                                  Shopname: shopNameController.text,
                                  phone: phoneController.text,
                                  Selectfloor: selectedFloor!,
                                  status:
                                      selectedAction // Ensure selectedFloor is updated
                                  );

                              context
                                  .read<ShopAuthBloc>()
                                  .add(EditShop(Shop: shop));
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
