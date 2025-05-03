import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallbuddyproject/Shop/View/Screens/Home/Order/shop_select_parking.dart';


import '../../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../../Widgets/Constants/Loading.dart';

class UserListselectparkingwrapper extends StatelessWidget {
  const UserListselectparkingwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc()
        ..add(FetchUsers(
          searchQuery: null,
        )),
      child: UserListSelectparking(),
    );
  }
}

class UserListSelectparking extends StatefulWidget {
  const UserListSelectparking({super.key});

  @override
  State<UserListSelectparking> createState() => _UserListSelectparkingState();
}

class _UserListSelectparkingState extends State<UserListSelectparking> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text("User", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // iconTheme: const IconThemeData(color: Colors.blue),
      )   ,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   "Users",
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 10),
            Expanded(child: _buildUserList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: (value) {

        },
        decoration: const InputDecoration(
          hintText: "Search here...",
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildUserList() {

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is UsersLoading) {
          return Center(child: Loading_Widget());
        } else if (state is Usersfailerror) {
          return Text(state.error.toString());
        } else if (state is Usersloaded) {
          if (state.Users.isEmpty) {
            // Return "No data found" if txhe list is empty
            return Center(
              child: Text(
                "No data found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.Users.length,
            itemBuilder: (context, index) {
              final user = state.Users[index];
              return Card(
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              user.Image.toString(),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Email: ${user.email}"),
                                Text("Contact: ${user.phone}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InvoiceFormPage(
                                name: user.name.toString(),
                                email: user.email.toString(),
                                contact: user.phone.toString(),
                                Userid: user.uid.toString(),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Select",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
