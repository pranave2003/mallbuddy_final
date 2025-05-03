import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_html/html.dart' as html;
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import 'Edit_accepted_buddy.dart';


class AdminAcceptedwrapper extends StatelessWidget {
  const AdminAcceptedwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuddyAuthBloc>(
      create: (context) => BuddyAuthBloc()
        ..add(FetchBuddyDetailsEvent(searchQuery: null, status: "1")),
      child: AdminAcceptedShop(),
    );
  }
}

class AdminAcceptedShop extends StatefulWidget {
  const AdminAcceptedShop({super.key});

  @override
  State<AdminAcceptedShop> createState() => _AdminAcceptedShopState();
}

class _AdminAcceptedShopState extends State<AdminAcceptedShop> {
  String selectedValue = "All";
  String? _aadhaarFileUrl;

  final List<String> dropdownItems = [
    "All",
    "Ground",
    "First",
    "Second",
    "Third",
    "Fourth"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildDropdown(),
          _buildShopTable("Registered Shops"),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 50,
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              items: dropdownItems.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShopTable(String title) {
    return BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
      listener: (context, state) {
        if (state is BuddyBanRefresh) {
          context.read<BuddyAuthBloc>().add(
                FetchBuddyDetailsEvent(searchQuery: null, status: '1'),
              );
        }
      },
      builder: (context, state) {
        if (state is BuddygetLoading) {
          return Column(
            children: [
              SizedBox(height: 200),
              Center(child: Loading_Widget()),
            ],
          );
        } else if (state is Buddyfailerror) {
          return Text(state.error.toString());
        } else if (state is Buddyloaded) {
          if (state.Buddys.isEmpty) {
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
                dataRowMaxHeight: 140,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  _buildColumn('Rider Details'),
                  _buildColumn('Personal Details'),
                  _buildColumn('Accepted'),
                  _buildColumn('Edit Buddy'),
                  _buildColumn('Ban Buddy'),
                ],
                rows: List.generate(state.Buddys.length, (index) {
                  final Buddy = state.Buddys[index];
                  return DataRow(
                    cells: [
                      DataCell(Text((index + 1).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text("Rider_ID:"),
                            Text(Buddy.uid.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                          Row(children: [
                            Text("Floor:"),
                            Text(Buddy.floor.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                          Row(children: [
                            Text("Delivery_Fees:"),
                            Text(Buddy.amount.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                        ],
                      )),
                      DataCell(Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text("Name:"),
                            Text(Buddy.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                          Row(children: [
                            Text("Gender:"),
                            Text(Buddy.Gender.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                          Row(
                            children: [
                              const Text("Aadhaar_Card:"),
                              const SizedBox(
                                  width:
                                      8), // Add space between text and button
                              GestureDetector(
                                onTap: () {
                                  final url = Buddy.aadhaarimage;
                                  if (url != null &&
                                      url.startsWith("https://")) {
                                    final anchor = html.AnchorElement(href: url)
                                      ..setAttribute(
                                          "download", "aadhaar_card.pdf")
                                      ..click();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "No valid Aadhaar file to download."),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade600,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.4),
                                        blurRadius: 6,
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.cloud_download_rounded,
                                          color: Colors.white),
                                      SizedBox(width: 4),
                                      Text(
                                        "Download",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(children: [
                            Text("Aadhaar_No:"),
                            Text(Buddy.Aadhaarnumber.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                          Row(children: [
                            Text("Email:"),
                            Text(Buddy.email.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                          Row(children: [
                            Text("Ph:"),
                            Text(Buddy.phone.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis),
                          ]),
                        ],
                      )),
                      DataCell(
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Buddy.Ban == "1"
                                    ? Colors.red
                                    : Colors.green,
                                width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Buddy.Ban == "1" ? Icons.close : Icons.done_all,
                                color: Buddy.Ban == "1"
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              SizedBox(width: 5),
                              Text(
                                Buddy.Ban == "1" ? "Baned" : "Accepted",
                                style: TextStyle(
                                    color: Buddy.Ban == "1"
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black, width: 1.5),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BuddyEditPage(
                                  BId: Buddy.uid.toString(),
                                  Buddyname: Buddy.name.toString(),
                                  phone: Buddy.phone.toString(),
                                  Gender: Buddy.Gender.toString(),
                                ),
                              ),
                            ).then((value) {
                              context.read<BuddyAuthBloc>().add(
                                  FetchBuddyDetailsEvent(
                                      searchQuery: null, status: "1"));
                            });
                          },
                          child: Text("Edit"),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<BuddyAuthBloc>()
                                .add(BanBuddyrevent(Ban: "1", id: Buddy.uid));
                          },
                          child:
                              Text("Ban", style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                  );
                }),
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

  Widget _previewAadhaarFile(String url) {
    if (url.endsWith(".pdf")) {
      return Text("PDF preview not supported. Please download to view.");
    } else {
      return Image.network(url, fit: BoxFit.contain);
    }
  }
}
