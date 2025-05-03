// import 'package:course_connect/Admin/Main/Adminmain.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../Controller/Bloc/Dropdown_university/dropdown_bloc.dart';
// import '../../../../Controller/Bloc/Property/Property/Property_Auth/Property_Model/PropertyModel.dart';
// import '../../../../Controller/Bloc/Property/Property/Property_auth_block.dart';
// import '../../../../Controller/Bloc/Property/Property/Property_auth_state.dart';
// import '../../../../Widget/Constands/Loading.dart';
//
// class PropertyAdd extends StatefulWidget {
//   @override
//   _PropertyAddState createState() => _PropertyAddState();
// }
//
// class _PropertyAddState extends State<PropertyAdd> {
//   final _formKey = GlobalKey<FormState>(); // Form key for validation
//   final TextEditingController _propertyNameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _areaController = TextEditingController();
//   final TextEditingController _amountWeekController = TextEditingController();
//   final TextEditingController _amountMonthController = TextEditingController();
//   final TextEditingController _ownerNameController = TextEditingController();
//   final TextEditingController _ownerEmailController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _aboutPropertyController =
//   TextEditingController();
//   final TextEditingController _selectedCityController = TextEditingController();
//   final TextEditingController _availableFromController =
//   TextEditingController();
//   final TextEditingController _moveInController = TextEditingController();
//   final TextEditingController _tokenAmountController = TextEditingController();
//   final TextEditingController _propertyTotalController =
//   TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//
//   void dispose() {
//     _propertyNameController.dispose();
//     _addressController.dispose();
//     _areaController.dispose();
//     _amountWeekController.dispose();
//     _amountMonthController.dispose();
//     _ownerNameController.dispose();
//     _phoneController.dispose();
//     _aboutPropertyController.dispose();
//     _selectedCityController.dispose();
//     _availableFromController.dispose();
//     _moveInController.dispose();
//     _propertyTotalController.dispose();
//     _tokenAmountController.dispose();
//     _ownerEmailController.dispose();
//     super.dispose();
//   }
//
//   String? _selectedCountry;
//   String? _selectedState;
//   String? _selectedRoomType;
//   String? _selectedRoomSize;
//   String? _selectedFurnishing;
//   String? _selectedBedroom;
//   String? _selectedBathroom;
//   String? _selectedKitchen;
//   String? _selectedMinStay;
//   String? _selectedMaxStay;
//   String? _selectedSexualOrientation;
//
//   List<String> photos_Url = [];
//   List<String> location = [];
//
//   DateTime? availableFrom;
//   DateTime? moveInDate;
//
//   bool _parkingAvailable = false;
//   bool _billsIncluded = false;
//   bool _petsAllowed = false;
//   bool _smokingAllowed = false;
//   String? Nearbycollage;
//
//   Future<void> pickAndUpload(BuildContext context) async {
//     final result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.image,
//       withData: true, // Required for web
//     );
//
//     if (result != null && result.files.isNotEmpty) {
//       context.read<PropertyAuthBlock>().add(UploadImagesEvent(result.files));
//     }
//   }
//
//   Future<void> _selectDate(
//       BuildContext context, Function(DateTime) onDateSelected) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2023),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       onDateSelected(picked);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: _formKey, // Wrap the form fields in a Form widget
//         child: ListView(
//           children: [
//             // Top Row (Welcome Text + Notification Icon)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Welcome Text
//                 Row(
//                   children: [
//                     Text(
//                       "Welcome ",
//                       style:
//                       TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       "Landlord,",
//                       style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff0A71CB)),
//                     ),
//                   ],
//                 ),
//                 // Notification & Profile Section
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       backgroundColor: Color(0xffD9D9D9),
//                       child: Icon(Icons.notifications, color: Colors.black),
//                     ),
//                     SizedBox(width: 10),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 14, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(width: 0.5, color: Colors.grey),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 20,
//                             backgroundColor: Colors.grey,
//                             backgroundImage:
//                             AssetImage('assets/Profile/img_3.png'),
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             "Landlord",
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 20),
//
//             BlocConsumer<PropertyAuthBlock, PropertyAuthState>(
//               listener: (context, state) {
//                 if (state is RefreshProperty) {
//                   Navigator.push(context, MaterialPageRoute(
//                     builder: (context) {
//                       return AdminPage(); // Navigate to AdminPage instead of LandlordPage
//                     },
//                   ));
//
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Property added successfully!"),
//                       backgroundColor: Colors.green,
//                       duration: Duration(seconds: 2),
//                     ),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return Padding(
//                   padding: const EdgeInsets.only(left: 25, right: 25),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Property Adding Page",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       InkWell(
//                         onTap: () {
//                           if (photos_Url.isEmpty && Nearbycollage == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                     'Please upload photo and choose nearby university'),
//                               ),
//                             );
//                           } else {
//                             if (_formKey.currentState!.validate()) {
//                               Property_Model property = Property_Model(
//                                   propertyName: _propertyNameController.text,
//                                   propertyAddress: _addressController.text,
//                                   propertyArea: _areaController.text,
//                                   country: _selectedCountry,
//                                   state: _selectedState,
//                                   city: _selectedCityController.text,
//                                   roomTypes: _selectedRoomType,
//                                   roomSizes: _selectedRoomSize,
//                                   availableFrom: _availableFromController.text,
//                                   moveInDate: _moveInController.text,
//                                   propertyImageURL: photos_Url,
//                                   aboutProperty: _aboutPropertyController.text,
//                                   location: _locationController.text,
//                                   bedroom: _selectedBedroom,
//                                   bathroom: _selectedBathroom,
//                                   kitchen: _selectedKitchen,
//                                   furnishingOptions: _selectedFurnishing,
//                                   propertyAmountWeek:
//                                   _amountWeekController.text,
//                                   propertyAmountMonth:
//                                   _amountMonthController.text,
//                                   tokenAmount: _tokenAmountController.text,
//                                   stayDurations: _selectedMinStay,
//                                   sexualOrientations:
//                                   _selectedSexualOrientation,
//                                   minimumStay: _selectedMinStay,
//                                   maximumStay: _selectedMaxStay,
//                                   ownerName: _ownerNameController.text,
//                                   ownerPhone: _phoneController.text,
//                                   propertyTotal: _propertyTotalController.text,
//                                   parking: _parkingAvailable ? "Yes" : "No",
//                                   billStatus: _billsIncluded ? "Yes" : "No",
//                                   pets: _petsAllowed ? "Yes" : "No",
//                                   smoking: _smokingAllowed ? "Yes" : "No",
//                                   owneremail: _ownerEmailController.text,
//                                   NearestUniversity: Nearbycollage.toString());
//
//                               context
//                                   .read<PropertyAuthBlock>()
//                                   .add(Property_Add_Event(Property: property));
//                             }
//                           }
//                         },
//                         borderRadius: BorderRadius.circular(8),
//                         child: Container(
//                           padding:
//                           EdgeInsets.symmetric(vertical: 8, horizontal: 36),
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: state is PropertyaddSuccess
//                               ? Loading_Widget()
//                               : Text(
//                             "+Add",
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//
//             SizedBox(height: 5),
//             Divider(thickness: 2, color: Colors.black),
//
//             _buildSectionTitle("Property Details"),
//             SizedBox(height: 5),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildTextField(
//                       "Property Name",
//                       _propertyNameController,
//                       true // This indicates that this field is required
//                   ),
//                 ),
//                 SizedBox(width: 10), // Adds spacing between the two text fields
//                 Expanded(
//                   child: _buildTextField("Address", _addressController,
//                       true // This indicates that this field is also required
//                   ),
//                 ),
//               ],
//             ),
//
//             SizedBox(height: 10),
//             _buildDropdown(
//                 "Country",
//                 ["India", "Canada", "United States", "United Kingdom"],
//                 _selectedCountry, (value) {
//               setState(() {
//                 _selectedCountry = value;
//                 _selectedState = null; // Reset state when country changes
//               });
//             }, true),
//             const SizedBox(height: 10),
//
//             // State Dropdown
//             if (_selectedCountry != null)
//               _buildDropdown("State", _getStatesForCountry(_selectedCountry!),
//                   _selectedState, (value) {
//                     setState(() {
//                       _selectedState = value;
//                     });
//                   }, true),
//             const SizedBox(height: 15),
//             Row(
//               children: [
//                 Expanded(
//                     child:
//                     _buildTextField("City", _selectedCityController, true)),
//                 SizedBox(width: 10),
//                 Expanded(child: _buildTextField("Area", _areaController, true)),
//               ],
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _locationController,
//               decoration: InputDecoration(
//                 labelText: "Location link",
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.location_on),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter location';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 10),
//             BlocBuilder<DropdownBloc, DropdownState>(
//               builder: (context, state) {
//                 if (state is fetchcatogorydropdownloading) {
//                   return Loading_Widget();
//                 } else if (state is catogoryLoadedDOMAIN) {
//                   return Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                           color:
//                           Nearbycollage == null ? Colors.red : Colors.grey,
//                           width: 1.5),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton<String>(
//                         hint: Text("Select College"),
//                         value: Nearbycollage,
//                         isExpanded: true,
//                         items: state.catogory.map((domain) {
//                           return DropdownMenuItem<String>(
//                             value: domain,
//                             child: Text(domain),
//                           );
//                         }).toList(),
//                         onChanged: (newValue) {
//                           setState(() {
//                             Nearbycollage = newValue;
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 } else if (state is FetchcatogotyError) {
//                   return Text('Error: ${state.msg}');
//                 } else {
//                   return SizedBox();
//                 }
//               },
//             ),
//             SizedBox(height: 10),
//
//             Divider(thickness: 2),
//             SizedBox(height: 10),
//
//             // Room Details
//             _buildSectionTitle("Room Details"),
//             SizedBox(height: 5),
//
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildDropdown(
//                         "Room Type",
//                         ["House", "Apartment", "Townhouse"],
//                         _selectedRoomType, (value) {
//                       setState(() {
//                         _selectedRoomType = value;
//                       });
//                     }, true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _buildDropdown(
//                         "Room Size",
//                         ['Small', 'Medium', 'Large'],
//                         _selectedRoomSize, (value) {
//                       setState(() {
//                         _selectedRoomSize = value;
//                       });
//                     }, true)),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child:
//                   _buildDatePicker("Available From", availableFrom, (date) {
//                     setState(() {
//                       availableFrom = date;
//                       _availableFromController.text =
//                       "${date?.toLocal()}".split(' ')[0];
//                     });
//                   }, _availableFromController),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: _buildDatePicker("Move-in Date", moveInDate, (date) {
//                     setState(() {
//                       moveInDate = date;
//                       _moveInController.text =
//                       "${date?.toLocal()}".split(' ')[0];
//                     });
//                   }, _moveInController),
//                 ),
//               ],
//             ),
//
//             Divider(thickness: 2),
//             SizedBox(height: 10),
//             Text("Property Details:",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//
//             SizedBox(height: 20),
//             BlocConsumer<PropertyAuthBlock, PropertyAuthState>(
//               listener: (context, state) {
//                 if (state is UploadSuccess) {
//                   photos_Url = state.downloadUrls;
//                   print("my photos : $photos_Url");
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content:
//                     Text("Uploaded: ${state.downloadUrls.length} files"),
//                   ));
//                 } else if (state is UploadFailure) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text("Upload failed: ${state.error}"),
//                   ));
//                 }
//               },
//               builder: (context, state) {
//                 if (state is UploadLoading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//
//                 return Container(
//                   height: 100,
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                           color: state is UploadSuccess
//                               ? Colors.green
//                               : Colors.red)),
//                   child: ElevatedButton.icon(
//                     style:
//                     ElevatedButton.styleFrom(backgroundColor: Colors.white),
//                     onPressed: () => pickAndUpload(context),
//                     icon: state is UploadSuccess
//                         ? Icon(
//                       Icons.image,
//                       color: Colors.green,
//                     )
//                         : Icon(Icons.upload_file),
//                     label: state is UploadSuccess
//                         ? Text(
//                       "Uploaded",
//                       style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold),
//                     )
//                         : Text("Pick & Upload Images"),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             // _buildImageContainer(),
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildTextField(
//                         "About Property", _aboutPropertyController, true)),
//               ],
//             ),
//
//             Divider(thickness: 2),
//             // Pricing Details
//             _buildSectionTitle("Pricing Details"),
//             SizedBox(height: 5),
//
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildTextField(
//                         "Amount /Week", _amountWeekController, true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _buildTextField(
//                         "Amount /Month", _amountMonthController, true)),
//               ],
//             ),
//             SizedBox(height: 5),
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildTextField(
//                         "Token Amount", _tokenAmountController, true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _buildTextField(
//                         "Total Amount", _propertyTotalController, true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _buildDropdown(
//                         "Sexual Orientation",
//                         ['Any', 'LGBTQ+ Friendly', 'Male Only', 'Female Only'],
//                         _selectedSexualOrientation, (value) {
//                       setState(() {
//                         _selectedSexualOrientation = value;
//                       });
//                     }, true)),
//               ],
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildDropdown(
//                         "Minimum Stay",
//                         ['1', "2", "3", "4", "5", "6", "7", "8", "9", "10"],
//                         _selectedMinStay, (value) {
//                       setState(() {
//                         _selectedMinStay = value;
//                       });
//                     }, true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _buildDropdown("Maximum Stay",
//                         ["6", "7", "8", "9", "10"], _selectedMaxStay, (value) {
//                           setState(() {
//                             _selectedMaxStay = value;
//                           });
//                         }, true)),
//               ],
//             ),
//
//             Divider(thickness: 2),
//             SizedBox(height: 10),
//
//             // Features (Radio Buttons)
//             _buildSectionTitle("Features"),
//             SizedBox(height: 5),
//
//             // First Row (Furnishing & Bedroom)
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildDropdown(
//                         "Furnishing",
//                         ["Furnished", "Unfurnished", "Semi-furnished"],
//                         _selectedFurnishing, (value) {
//                       setState(() {
//                         _selectedFurnishing = value;
//                       });
//                     }, true)),
//                 SizedBox(width: 10), // Adds spacing
//                 Expanded(
//                     child: _buildDropdown(
//                         "Bedroom",
//                         ['1', '2', '3', '4', '5', '6 and above'],
//                         _selectedBedroom, (value) {
//                       setState(() {
//                         _selectedBedroom = value;
//                       });
//                     }, true)),
//               ],
//             ),
//
//             SizedBox(height: 10),
//
//             // Second Row (Bathroom & Kitchen)
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildDropdown(
//                         "Bathroom",
//                         ['1', '2', '3', '4', '5', '6 and above'],
//                         _selectedBathroom, (value) {
//                       setState(() {
//                         _selectedBathroom = value;
//                       });
//                     }, true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _buildDropdown(
//                         "Kitchen",
//                         ['1', '2', '3', '4', '5', '6 and above'],
//                         _selectedKitchen, (value) {
//                       setState(() {
//                         _selectedKitchen = value;
//                       });
//                     }, true)),
//               ],
//             ),
//
//             SizedBox(height: 10),
//
//             Text("Additional Preferences",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//
//             // First Row (Parking & Bills Included)
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                     child: _buildCheckbox(
//                         "Parking Available", _parkingAvailable, (value) {
//                       setState(() {
//                         _parkingAvailable = value!;
//                       });
//                     }, required: true)),
//                 SizedBox(width: 10), // Adds spacing
//                 Expanded(
//                     child: _buildCheckbox("Bills Included", _billsIncluded,
//                             (value) {
//                           setState(() {
//                             _billsIncluded = value!;
//                           });
//                         }, required: true)),
//               ],
//             ),
//
//             SizedBox(height: 10),
//
//             // Second Row (Pets Allowed & Smoking Allowed)
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                     child:
//                     _buildCheckbox("Pets Allowed", _petsAllowed, (value) {
//                       setState(() {
//                         _petsAllowed = value!;
//                       });
//                     }, required: true)),
//                 SizedBox(width: 10), // Adds spacing
//                 Expanded(
//                     child: _buildCheckbox("Smoking Allowed", _smokingAllowed,
//                             (value) {
//                           setState(() {
//                             _smokingAllowed = value!;
//                           });
//                         }, required: true)),
//               ],
//             ),
//             SizedBox(height: 15),
//
//             Divider(thickness: 2),
//             SizedBox(height: 10),
//
//             // Owner Details
//             _buildSectionTitle("Owner Details"),
//             SizedBox(height: 5),
//
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildTextField(
//                         "Owner Name", _ownerNameController, true)),
//                 SizedBox(width: 10),
//                 Expanded(
//                     child: _buildTextField(
//                         "Phone Number", _phoneController, true)),
//               ],
//             ),
//
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDatePicker(String label, DateTime? date,
//       Function(DateTime) onDateSelected, TextEditingController controller) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15),
//       child: TextFormField(
//         controller: controller,
//         readOnly: true,
//         decoration: InputDecoration(
//           labelText: date == null ? label : "${date?.toLocal()}".split(' ')[0],
//           border: OutlineInputBorder(),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.calendar_today),
//             onPressed: () => _selectDate(context, onDateSelected),
//           ),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return "$label cannot be empty";
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }
//
// Widget _buildTextField(
//     String label, TextEditingController controller, bool isRequired) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: 15),
//     child: TextFormField(
//       controller: controller,
//       decoration:
//       InputDecoration(labelText: label, border: OutlineInputBorder()),
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       validator: (value) {
//         final trimmedValue = value?.trim() ?? "";
//
//         if (isRequired && trimmedValue.isEmpty) {
//           return "$label cannot be empty";
//         }
//
//         // Validate phone number
//         if (label == "Phone Number" &&
//             trimmedValue.isNotEmpty &&
//             !RegExp(r'^\+?[0-9]{10,15}$').hasMatch(trimmedValue)) {
//           return "Enter a valid phone number";
//         }
//
//         // Validate email
//         if (label == "Owner Email" &&
//             trimmedValue.isNotEmpty &&
//             !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                 .hasMatch(trimmedValue)) {
//           return "Enter a valid email address";
//         }
//
//         // Validate amounts
//         if (["Amount /Week", "Amount /Month", "Token Amount", "Total Amount"]
//             .contains(label) &&
//             trimmedValue.isNotEmpty) {
//           if (double.tryParse(trimmedValue) == null) {
//             return "Enter a valid amount";
//           }
//         }
//
//         // Validate property name
//         if (label == "Property Name" && trimmedValue.isNotEmpty) {
//           // Capitalize each word
//           String capitalizedValue = trimmedValue.split(' ').map((word) {
//             if (word.isEmpty) return '';
//             return word[0].toUpperCase() + word.substring(1).toLowerCase();
//           }).join(' ');
//
//           // Validation regex
//           final regex = RegExp(r'^([A-Z][a-z]+)(\s[A-Z][a-z]+)*$');
//           if (!regex.hasMatch(capitalizedValue)) {
//             return "Each word in Property Name must start with a capital letter";
//           }
//         }
//
//         // Validate owner name
//         if (label == "Owner Name" && trimmedValue.isNotEmpty) {
//           final regex = RegExp(r'^[A-Z][a-z]+(\s[A-Z][a-z]+)*$');
//           if (!regex.hasMatch(trimmedValue)) {
//             return "Enter a valid Owner Name";
//           }
//         }
//
//         return null; // valid
//       },
//     ),
//   );
// }
//
// Widget _buildDropdown(String label, List<String> items, String? selectedValue,
//     Function(String?) onChanged, bool isRequired) {
//   return Padding(
//     padding: EdgeInsets.only(bottom: 15),
//     child: DropdownButtonFormField<String>(
//       decoration:
//       InputDecoration(labelText: label, border: OutlineInputBorder()),
//       value: selectedValue,
//       items: items
//           .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//           .toList(),
//       onChanged: onChanged,
//       validator: (value) {
//         if (isRequired && (value == null || value.isEmpty)) {
//           return "$label cannot be empty";
//         }
//         return null;
//       },
//     ),
//   );
// }
//
// Widget _buildCheckbox(String label, bool value, Function(bool?) onChanged,
//     {bool required = true}) {
//   return FormField<bool>(
//     initialValue: value,
//     validator: (val) {
//       if (required && val == false) {
//         return 'Please select $label';
//       }
//       return null;
//     },
//     builder: (state) => Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CheckboxListTile(
//           title: Text(label),
//           value: value,
//           onChanged: onChanged,
//           controlAffinity: ListTileControlAffinity.leading,
//         ),
//         if (state.hasError)
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               state.errorText ?? '',
//               style: TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           )
//       ],
//     ),
//   );
// }
//
// Widget _buildSectionTitle(String title) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 8.0),
//     child: Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }
//
// List<String> _getStatesForCountry(String country) {
//   switch (country) {
//     case "India":
//       return [
//         "Andhra Pradesh",
//         "Arunachal Pradesh",
//         "Assam",
//         "Bihar",
//         "Chhattisgarh",
//         "Goa",
//         "Gujarat",
//         "Haryana",
//         "Himachal Pradesh",
//         "Jharkhand",
//         "Karnataka",
//         "Kerala",
//         "Madhya Pradesh",
//         "Maharashtra",
//         "Manipur",
//         "Meghalaya",
//         "Mizoram",
//         "Nagaland",
//         "Odisha",
//         "Punjab",
//         "Rajasthan",
//         "Sikkim",
//         "Tamil Nadu",
//         "Telangana",
//         "Tripura",
//         "Uttar Pradesh",
//         "Uttarakhand",
//         "West Bengal"
//       ];
//     case "Canada":
//       return [
//         "Alberta",
//         "British Columbia",
//         "Manitoba",
//         "New Brunswick",
//         "Newfoundland and Labrador",
//         "Nova Scotia",
//         "Ontario",
//         "Prince Edward Island",
//         "Quebec",
//         "Saskatchewan",
//         "Northwest Territories",
//         "Nunavut",
//         "Yukon"
//       ];
//     case "United States":
//       return [
//         "Alabama",
//         "Alaska",
//         "Arizona",
//         "Arkansas",
//         "California",
//         "Colorado",
//         "Connecticut",
//         "Delaware",
//         "Florida",
//         "Georgia",
//         "Hawaii",
//         "Idaho",
//         "Illinois",
//         "Indiana",
//         "Iowa",
//         "Kansas",
//         "Kentucky",
//         "Louisiana",
//         "Maine",
//         "Maryland",
//         "Massachusetts",
//         "Michigan",
//         "Minnesota",
//         "Mississippi",
//         "Missouri",
//         "Montana",
//         "Nebraska",
//         "Nevada",
//         "New Hampshire",
//         "New Jersey",
//         "New Mexico",
//         "New York",
//         "North Carolina",
//         "North Dakota",
//         "Ohio",
//         "Oklahoma",
//         "Oregon",
//         "Pennsylvania",
//         "Rhode Island",
//         "South Carolina",
//         "South Dakota",
//         "Tennessee",
//         "Texas",
//         "Utah",
//         "Vermont",
//         "Virginia",
//         "Washington",
//         "West Virginia",
//         "Wisconsin",
//         "Wyoming"
//       ];
//     case "United Kingdom":
//       return [
//         "England",
//         "Scotland",
//         "Wales",
//         "Northern Ireland",
//         "Guernsey",
//         "Jersey",
//         "Isle of Man",
//         "Anguilla",
//         "Bermuda",
//         "British Antarctic Territory",
//         "British Indian Ocean Territory",
//         "British Virgin Islands",
//         "Cayman Islands",
//         "Falkland Islands",
//         "Montserrat",
//         "Pitcairn Islands",
//         "Saint Helena, Ascension and Tristan da Cunha",
//         "South Georgia and the South Sandwich Islands",
//         "Sovereign Base Areas of Akrotiri and Dhekelia",
//         "Turks and Caicos Islands"
//       ];
//     default:
//       return [];
//   }
// }
// //document