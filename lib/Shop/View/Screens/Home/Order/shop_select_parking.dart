import 'package:flutter/material.dart';
import 'package:mallbuddyproject/Shop/View/Screens/Home/Order/shop_assign_buddy.dart';

import '../../../../../Widgets/Constants/colors.dart';

class InvoiceFormPage extends StatefulWidget {
  final String name;
  final String email;
  final String contact;
  final String Userid;

  const InvoiceFormPage({
    super.key,
    required this.name,
    required this.email,
    required this.contact,
    required this.Userid,
  });

  @override
  State<InvoiceFormPage> createState() => _InvoiceFormPageState();
}

class _InvoiceFormPageState extends State<InvoiceFormPage> {


  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController contactController;
  late TextEditingController invoiceIdController;
  late TextEditingController vehicleNameController;
  late TextEditingController vehicleColorController;
  late TextEditingController vehicleNumberController;
  String? selectedPillar;
  String selectedFloor = "Ground";
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    print(widget.Userid);
    nameController = TextEditingController(text: widget.name);
    emailController = TextEditingController(text: widget.email);
    contactController = TextEditingController(text: widget.contact);
    invoiceIdController = TextEditingController();
    vehicleNameController = TextEditingController();
    vehicleColorController = TextEditingController();
    vehicleNumberController = TextEditingController();
  }

  void _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Invoice Details", style: TextStyle(color: Colors.blue)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRow(
                "Invoice ID",
                buildTextField(
                  "Enter invoice id",
                  invoiceIdController,
                  required: true,
                  pattern: r'^[A-Za-z0-9]{3,10}$',
                  patternError: "Invoice ID must be 3-10 alphanumeric characters",
                ),
              ),

              const Divider(),
              buildRow("Select The Parking Floor", buildFloorSelection()),
              const SizedBox(height: 16),
              buildRow(
                "Select the pillar",
                DropdownButtonFormField<String>(
                  value: selectedPillar,
                  decoration: inputDecoration,
                  hint: const Text("Choose pillar"),
                  items: ["A1", "B2", "C3", "D4"].map((pillar) {
                    return DropdownMenuItem<String>(
                      value: pillar,
                      child: Text(pillar),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPillar = value;
                    });
                  },
                ),
              ),
              buildRow(
                "Customer Name",
                buildTextField(
                  "Enter Customer name",
                  nameController,
                  required: true,
                  pattern: r'^[A-Za-z ]{2,}$',
                  patternError: "Enter a valid name (only letters & spaces, min 2 characters)",
                ),
              ),

              buildRow(
                "Mobile Number",
                buildTextField(
                  "Enter phone number",
                  contactController,
                  required: true,
                  keyboardType: TextInputType.phone,
                  pattern: r'^[0-9]{10}$',
                  patternError: "Enter a valid 10-digit phone number",
                ),
              ),

              buildRow(
                "Vehicle Name",
                buildTextField(
                  "Enter vehicle name",
                  vehicleNameController,
                  required: true,
                  pattern: r'^[A-Za-z ]{2,}$',
                  patternError: "Enter a valid vehicle name (only letters & spaces, min 2 characters)",
                ),
              ),

              buildRow(
                  "Vehicle Color",
                  buildTextField("Enter vehicle color", vehicleColorController,
                      required: true)),
              buildRow(
                "Vehicle Number",
                buildTextField(
                  "Enter vehicle number",
                  vehicleNumberController,
                  required: true,
                  pattern: r'^[A-Z]{2}\d{2}-[A-Z]{2}-\d{4}$',
                  patternError: "Enter a valid vehicle number (e.g., KA01-AB-1234)",
                ),
              ),


              buildRow(
                "Delivery Time",
                GestureDetector(
                  onTap: () => _pickTime(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: inputDecoration.copyWith(
                        hintText: selectedTime != null
                            ? selectedTime!.format(context)
                            : "Time",
                        suffixIcon: const Icon(Icons.access_time),
                      ),
                      validator: (value) {
                        if (selectedTime == null) {
                          return "Please select a delivery time";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AssignRiderWrapper(
                            ownername: widget.name,
                            ownerEmail: widget.email,
                            ownerContact: widget.contact,
                            invoiceId: invoiceIdController.text,
                            parkingfloor: selectedFloor,
                            vehiclename: vehicleNameController.text,
                            vehicleNumber: vehicleNumberController.text,
                            vehicleColor: vehicleColorController.text,
                            deliveryTime: selectedTime?.format(context) ?? "",
                            pillar: selectedPillar.toString(),
                            Userid:widget.Userid
                          );
                        },
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: defaultBlue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Continue",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFloorSelection() {
    return Wrap(
      spacing: 8.0, // Spacing between chips
      children: ["Ground", "First", "Second", "Third", "Fourth", "Fifth"]
          .map((floor) => ChoiceChip(
                label: Text(floor),
                selected: selectedFloor == floor,
                selectedColor: defaultBlue,
                onSelected: (isSelected) {
                  setState(() {
                    selectedFloor = floor;
                  });
                },
                labelStyle: TextStyle(
                    color:
                        selectedFloor == floor ? Colors.white : Colors.black),
              ))
          .toList(),
    );
  }

  Widget buildRow(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Text(label, style: const TextStyle(fontSize: 16))),
          Expanded(flex: 5, child: child),
        ],
      ),
    );
  }

  Widget buildTextField(
      String hint,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
        bool required = false,
        String? pattern,
        String? patternError,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: inputDecoration.copyWith(hintText: hint),
      validator: (value) {
        if (required && (value == null || value.isEmpty)) {
          return "This field is required";
        }
        if (pattern != null && value != null && !RegExp(pattern).hasMatch(value)) {
          return patternError ?? "Invalid input";
        }
        return null;
      },
    );
  }


  final InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    filled: true,
    fillColor: Colors.white,
  );
}
