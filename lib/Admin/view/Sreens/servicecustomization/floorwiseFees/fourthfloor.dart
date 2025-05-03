import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import '../../../../Model/User_Management/Buddy_model.dart';
import '../../../../Model/User_Management/shop_model.dart';

class BuddyfeesFourthfloorwrapper extends StatelessWidget {
  const BuddyfeesFourthfloorwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuddyAuthBloc>(
      create: (context) => BuddyAuthBloc()
        ..add(FetchBuddyDetailsEvent(searchQuery: null,  floor: "4th")),
      child: BuddyfeesFourthfloor(),
    );
  }
}

class BuddyfeesFourthfloor extends StatefulWidget {
  const BuddyfeesFourthfloor({super.key});

  @override
  State<BuddyfeesFourthfloor> createState() => _BuddyfeesFourthfloorState();
}

class _BuddyfeesFourthfloorState extends State<BuddyfeesFourthfloor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text("Registered Shops"),
      //   // backgroundColor: Colors.blue,
      // ),
      body: _buildShopTable("Registered Shops"),
    );
  }

  // Function to build shop tables for each tab
  Widget _buildShopTable(String title) {
    return BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is BuddygetLoading) {
          return   Column(
            children: [
              SizedBox(height: 200,),
              Center(child: Loading_Widget()),
            ],
          );
        } else if (state is Buddyfailerror) {
          return Text(state.error.toString());
        } else if (state is Buddyloaded) {
          if (state.Buddys.isEmpty) {
            // Return "No data found" if txhe list is empty
            return Center(
              child: Text(
                "No data found",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: DataTable(
                dataRowMaxHeight: 100,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  _buildColumn('Date and Time'),
                  _buildColumn('Rider_Details'),
                  _buildColumn('Total_Delivery'),
                  // _buildColumn('Phone Number'),
                  // _buildColumn('Email'),
                  _buildColumn('Delivery_Fees'),
                  _buildColumn('Action'),
                ],
                rows: List.generate(
                  state.Buddys.length,
                      (index) {
                    final Buddy = state.Buddys[index];
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          (index + 1).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataCell(Text("")),
                        DataCell(
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Rider_Details:"),
                                    Text(Buddy.uid.toString(),
                                      style:
                                      const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Name:"),
                                    Text(Buddy.name.toString(),style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Email:"),
                                    Text(Buddy.email.toString(),style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Ph:"),
                                    Text(Buddy.phone.toString(),style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,),
                                  ],
                                )
                              ],
                            )),
                        DataCell(Text(Buddy.Gender.toString())),
                        DataCell(Text(Buddy.amount.toString())),
                        DataCell(
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: BorderSide(
                                  color: Colors.black, width: 1.5),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            onPressed: (){},
                            child: Text("Edit"),
                          ),
                        ),
                        // DataCell(Text(shop.Phone_Number)),
                        // DataCell(Text(shop.Email_ID)),
                        // DataCell(
                        //     // _buildOutlinedButton("Accepted", Colors.green, Colors.green, () {})
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  DataColumn _buildColumn(String title) {
    return DataColumn(
      label: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade900,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

// Widget _buildOutlinedButton(String text, Color textColor, Color borderColor, VoidCallback onPressed) {
//   return Padding(
//     padding: const EdgeInsets.all(4.0),
//     child: OutlinedButton(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: textColor, // Text color
//         side: BorderSide(color: borderColor), // Border color
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
//       ),
//       onPressed: onPressed,
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     ),
//   );
// }
}
