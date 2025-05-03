import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/Shop_Authbloc/Shopauthmodel/Shopauthmodel.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../Widgets/Constants/Loading.dart';

class ShopEditProfilePage extends StatefulWidget {
  ShopEditProfilePage(
      {required this.image,
      required this.name,
      required this.email,
      required this.contact,
        required this.uid,
      });

  final image;
  final String name;
  final String email;
  final String contact;
  final String uid;


  @override
  _ShopEditProfilePageState createState() => _ShopEditProfilePageState();
}

class _ShopEditProfilePageState extends State<ShopEditProfilePage> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController contactController;
  String? image;


  bool isPasswordVisible = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    contactController = TextEditingController(text: widget.contact);
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.green),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ShopModel Shop = ShopModel(
                  uid: widget.uid,
                  Ownername: nameController.text.toString(),
                  phone: contactController.text.toString(),
                  Image: image ?? "",
                );

                context.read<ShopAuthBloc>().add(EditShopProfile(Shop: Shop));
                Navigator.of(context).pop();
              }
            },
          ),

        ],
      ),
      body: BlocConsumer<ShopAuthBloc, ShopAuthState>(
        listener: (context, state) {
          if (state is ShopProfileImageSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child:Form(
          key: _formKey,
            child: ListView(
              children: [
                // Profile Picture with Edit Icon
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12), // Rounded corners for image
                        child: CachedNetworkImage(
                          imageUrl:widget.image,
                          width: 100, // Adjusted width
                          height: 100, // Adjusted height
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300], // Placeholder background
                            child: Center(
                              child: Loading_Widget(), // Loading indicator
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300], // Placeholder background
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.read<ShopAuthBloc>()
                              ..add(ShopPickAndUploadImageEvent());
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.camera_alt,
                                color: Colors.white, size: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  child: state is ShopProfileImageLoading
                      ? Column(
                          children: [
                            Loading_Widget(),
                            Text("Profile Updating.....")
                          ],
                        )
                      : Text(""),
                ),
                SizedBox(height: 20),
                // Editable Fields inside Containers
                buildEditableField("Name", nameController, false),
                buildEditableField("Phone Number", contactController, false),
              ],
            ),
            ));
        },
      ),
    );
  }

  // Custom Widget for Editable Fields
  // Custom Widget for Editable Fields
  Widget buildEditableField(
      String label, TextEditingController controller, bool isPassword) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !isPasswordVisible,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label cannot be empty';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          )
              : null,
        ),
      ),
    );
  }

}
