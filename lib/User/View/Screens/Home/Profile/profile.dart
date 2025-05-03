import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mallbuddyproject/User/View/Screens/Home/Profile/privacyandpolicy.dart';

import '../../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import '../../../../../Widgets/Constants/colors.dart';
import '../../myorders.dart';
import '../../notification.dart';

import 'dart:io';

import 'Editprofile.dart';
import 'Termsandconditions.dart';

class userprofileavwrapper extends StatelessWidget {
  const userprofileavwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(FetchUserDetailsById()),
      child: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  // IconButton(
                  //   icon: const Icon(Icons.notifications, color: Colors.white),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => NotificationScreen()));
                  //   },
                  // ),
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
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is loading) {
                              return SizedBox(
                                height: 200,
                                child: Loading_Widget(),
                              );
                            } else if (state is UserByidLoaded) {
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
                                          builder: (context) => EditProfilePage(
                                              image: user.Image),
                                        ),
                                      ).then((_) {
                                        // This block runs when BuddyEditProfilePage is popped
                                        context
                                            .read<AuthBloc>()
                                            .add(FetchUserDetailsById());
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
                                  Text('${user.name ?? ''}',
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
                                    title: Text("Email"),
                                    subtitle: Text('${user.email ?? ''}'),
                                  ),
                                  Divider(
                                    color: Colors.black54,
                                  ),
                                  ListTile(
                                    title: Text("Mobile"),
                                    subtitle: Text('Name: ${user.phone ?? ''}'),
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
                        // ...List.generate(
                        //     contactDetails.length,
                        //     (index) => _buildSelectableContactRow(
                        //         contactDetails[index]["label"]!, index)),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryScreen(),));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPolicyPage(),
                                ));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TermsAndConditionsPage(),
                                ));
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
                            final Authbloc = BlocProvider.of<AuthBloc>(context);
                            Authbloc.add(SigOutEvent());
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
                                border:
                                    Border.all(width: 1, color: Colors.black)
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
