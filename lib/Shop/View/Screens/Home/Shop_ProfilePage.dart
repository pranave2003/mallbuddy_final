import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';

import '../../../../User/View/Screens/Home/Profile/Termsandconditions.dart';
import '../../../../User/View/Screens/Home/Profile/privacyandpolicy.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';
import '../ordersstatus/shoporderhistory.dart';
import 'Shopeditprofile.dart';

class Shopprofileavwrapper extends StatelessWidget {
  const Shopprofileavwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAuthBloc()..add(FetchShopDetailsById()),
      child: ShopProfilePage(),
    );
  }
}

class ShopProfilePage extends StatefulWidget {
  const ShopProfilePage({super.key});

  @override
  State<ShopProfilePage> createState() => _ShopProfilePageState();
}

class _ShopProfilePageState extends State<ShopProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Profile",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => NotificationScreen()));
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        BlocConsumer<ShopAuthBloc, ShopAuthState>(
                          listener: (context, state) {
                            if (state is ShopProfileImageSuccess) {
                              context.read<ShopAuthBloc>()
                                ..add(FetchShopDetailsById());
                            }
                          },
                          builder: (context, state) {
                            if (state is Shoploading) {
                              return SizedBox(
                                height: 200,
                                child: Loading_Widget(),
                              );
                              Center(child: CircularProgressIndicator());
                            } else if (state is ShopByidLoaded) {
                              final user = state.Userdata;
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            50), // Half of width/height to form a circle
                                        child: CachedNetworkImage(
                                          imageUrl: user.Image.toString(),
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.white,
                                                child:
                                                Center(child: Loading_Widget()),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                                width: 100,
                                                height: 100,
                                                color: Colors.grey[300],
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 50,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShopEditProfilePage(
                                            image: user.Image,
                                                name: user.Ownername.toString(),
                                            email: user.email.toString(),
                                            contact: user.phone.toString(),
                                            uid: user.uid.toString(),
                                          ),
                                        ),
                                      ).then((_) {
                                        // This block runs when BuddyEditProfilePage is popped
                                        context
                                            .read<ShopAuthBloc>()
                                            .add(FetchShopDetailsById());
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text("Edit Profile"),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('${user.Shopname ?? ''}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 20),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Text("Contact Details",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold))),
                                  ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Owner Name"), // Left side label
                                        Text('${user.Ownername ?? ''}',
                                            style: TextStyle(
                                                fontWeight: FontWeight
                                                    .w500)), // Right side email text
                                      ],

                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  ),
                                  ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Email"), // Left side label
                                        Text('${user.email ?? ''}',
                                            style: TextStyle(
                                                fontWeight: FontWeight
                                                    .w500)), // Right side email text
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  ),
                                  ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Mobile"), // Left side label
                                        Text('${user.phone ?? ''}',
                                            style: TextStyle(
                                                fontWeight: FontWeight
                                                    .w500)), // Right side email text
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  ),
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShopOrderHistoryScreen(),
                                ));
                            print("object");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(width: 1, color: Colors.black)
                                // border: Border.all(
                                //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                                ),
                            child: Row(
                              children: [
                                Icon(Icons.shopping_bag, color: Colors.grey),
                                const SizedBox(width: 10),
                                Text("My Orders",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage(),));
                            print("object");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(width: 1.2, color: Colors.black)
                                // border: Border.all(
                                //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                                ),
                            child: Row(
                              children: [
                                Icon(Icons.lock, color: Colors.grey),
                                const SizedBox(width: 10),
                                Text("Privacy and policy",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage(),));
                            print("object");
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(width: 1, color: Colors.black)
                                // border: Border.all(
                                //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                                ),
                            child: Row(
                              children: [
                                Icon(Icons.article, color: Colors.grey),
                                const SizedBox(width: 10),
                                Text("Terms and Condition",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            final ShopAuthbloc =
                                BlocProvider.of<ShopAuthBloc>(context);
                            ShopAuthbloc.add(ShopSigOutEvent());
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "/login",
                              (route) => false,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 1, color: Colors.red)
                                // border: Border.all(
                                //     color: isSelected ? Colors.blue : Colors.grey.shade300),
                                ),
                            child: Row(
                              children: [
                                Icon(Icons.login, color: Colors.red),
                                const SizedBox(width: 10),
                                Text("Logout",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
