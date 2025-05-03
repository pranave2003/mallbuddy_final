import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import '../../../../Model/User_Management/Buddy_model.dart';
import '../../../../Model/User_Management/shop_model.dart';

class RegisterdBuddywrapper extends StatelessWidget {
  const RegisterdBuddywrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuddyAuthBloc>(
      create: (context) => BuddyAuthBloc()
        ..add(FetchBuddyDetailsEvent(searchQuery: null, status: "0")),
      child: RegisteredBuddy(),
    );
  }
}

class RegisteredBuddy extends StatefulWidget {
  const RegisteredBuddy({super.key});

  @override
  State<RegisteredBuddy> createState() => _RegisteredBuddyState();
}

class _RegisteredBuddyState extends State<RegisteredBuddy> {
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // _buildFloorSelection(),
          _buildShopTable("Registered Shops"),
        ],
      ),
    );
  }

  // Function to build shop tables for each tab
  Widget _buildShopTable(String title) {
    return BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
      listener: (context, state) {
        if (state is Refresh) {
          context
              .read<BuddyAuthBloc>()
              .add(FetchBuddyDetailsEvent(searchQuery: null, status: "0"));
        }
      },
      builder: (context, state) {
        if (state is BuddygetLoading) {
          return Column(
            children: [
              SizedBox(
                height: 200,
              ),
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: DataTable(
                dataRowMaxHeight: 100,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  _buildColumn('Rider Details'),
                  _buildColumn('Accept'),
                  _buildColumn('Reject'),
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
                        DataCell(Column(
                          children: [
                            Row(
                              children: [
                                Text("Rider_ID:"),
                                Text(
                                  Buddy.uid.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Name:"),
                                Text(
                                  Buddy.name.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Gender:"),
                                Text(
                                  Buddy.Gender.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                           Row(
                              children: [
                                Text("Ph:"),
                                Text(Buddy.phone.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email:"),
                                Text(Buddy.email.toString()),
                              ],
                            )
                          ],
                        )),
                        // DataCell(Text(shop.Phone_Number)),
                        // DataCell(Text(shop.Email_ID)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String? selectedFloor;
                                      amountController.text =
                                          Buddy.amount.toString();
                                      return AlertDialog(
                                        title: Text('Accept Request'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Floor dropdown
                                            DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                  labelText: 'Select Floor'),
                                              items: [
                                                'GND',
                                                '1st',
                                                '2nd',
                                                '3rd',
                                                '4th'
                                              ]
                                                  .map((floor) =>
                                                      DropdownMenuItem<String>(
                                                        value: floor,
                                                        child: Text(floor),
                                                      ))
                                                  .toList(),
                                              onChanged: (value) {
                                                selectedFloor = value;
                                              },
                                            ),
                                            SizedBox(height: 10),
                                            // Amount input
                                            TextField(
                                              controller: amountController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  labelText: 'Enter Amount'),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (selectedFloor != null &&
                                                  amountController
                                                      .text.isNotEmpty) {
                                                context
                                                    .read<BuddyAuthBloc>()
                                                    .add(
                                                      AcceptRejectbuddyevent(
                                                        status: "1",
                                                        id: Buddy.uid,
                                                        amount: amountController
                                                            .text,
                                                        floor: selectedFloor!,
                                                      ),
                                                    );
                                                Navigator.of(context)
                                                    .pop(); // Close
                                              } else {
                                                // You can show an error or toast
                                              }
                                            },
                                            child: Text('Accept'),
                                          ),
                                        ],
                                      );
                                    },
                                  ).then(
                                    (value) {
                                      context.read<BuddyAuthBloc>()
                                        ..add(FetchBuddyDetailsEvent(
                                            status: "0", searchQuery: null));
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<BuddyAuthBloc>().add(
                                      AcceptRejectbuddyevent(
                                          status: "2",
                                          id: Buddy.uid,
                                          floor: '',
                                          amount: ''));
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )),
                          ],
                        )),
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

  Widget _buildOutlinedButton(
      String text, Color textColor, Color borderColor, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor, // Text color
          side: BorderSide(color: borderColor), // Border color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 12), // Button padding
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
