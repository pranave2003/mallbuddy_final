import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import 'Admin_sendreply.dart';

class AdminViewComplaintswrapper extends StatelessWidget {
  const AdminViewComplaintswrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(searchQuery: null, status: "1"),
        ),
      child: AdminViewComplaints(),
    );
  }
}

class AdminViewComplaints extends StatefulWidget {
  const AdminViewComplaints({super.key});

  @override
  State<AdminViewComplaints> createState() => _AdminViewComplaintsState();
}

class _AdminViewComplaintsState extends State<AdminViewComplaints>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {};
  Map<int, bool> selectedDelete = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this); // FIXED: length = 4
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hello,", style: TextStyle(fontSize: 22)),
                    Text("Good Morning Team!",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                      "Unlock insights, track growth, and manage performance effortlessly.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 0.5, color: Colors.grey)),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/profile/girl.png'),
                          ),
                          SizedBox(width: 10),
                          Text("Admin",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // TabBar
            TabBar(
              controller: _tabController, // FIXED: Using only one TabController
              isScrollable: true,
              indicatorColor: Colors.blue,
              indicatorWeight: 3,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: "View Complaints"),
                // Tab(text: "Complete Order"),
                // Tab(text: "Rider Performance"),
                // // Tab(text: "Customer Feedback"),
              ],
            ),

            const SizedBox(height: 10),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics:
                    const BouncingScrollPhysics(), // FIXED: Ensures smooth scrolling
                children: [
                  // AdminAllOrders(),
                  // AdminCompleteOrders(),
                  _buildShopTable("View Complaints")
                  // AdminRejectedShop(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build shop tables dynamically
  Widget _buildShopTable(String title) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is BuddyBanRefresh) {
          context
              .read<OrderBloc>()
              .add(FetchPlaceorderEvent(searchQuery: null, status: ''));
        }
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(child: Loading_Widget()),
            ],
          );
        } else if (state is Orderfailerror) {
          return Text(state.error.toString());
        } else if (state is Ordersloaded) {
          if (state.Orders.isEmpty) {
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
              constraints:
                  BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              child: DataTable(
                dataRowMaxHeight: 100,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  // _buildColumn('Date and Time'),
                  _buildColumn('Order Details'),
                  _buildColumn('Shop Details'),
                  _buildColumn('Rider Details'),
                  _buildColumn('User Details'),
                  // _buildColumn('Total Amount'),
                  _buildColumn('Complaint'),
                  _buildColumn('Status'),
                  _buildColumn('Send Reply'),
                ],
                rows: List.generate(
                  state.Orders.length,
                  (index) {
                    final Order = state.Orders[index];
                    return DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        // DataCell(Text("")),
                        // Order Details
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Order_ID:"),
                                Text(
                                  Order.orderid.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Invoice_ID:"),
                                Text(
                                  Order.invoiceid.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Floor:"),
                                Text(
                                  Order.Selectfloor.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Delivery_Fees:"),
                                Text(
                                  Order.payment.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )),
                        // Shop Details
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("ID:"),
                                Text(
                                  Order.shopid.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Shop_Name:"),
                                Text(
                                  Order.shopname.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Owner_Name"),
                                Text(
                                  Order.conatctrider.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email:"),
                                Text(
                                  Order.rideremail.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )),
                        // Rider Details
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("ID:"),
                                Text(
                                  Order.riderid.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Name:"),
                                Text(
                                  Order.Selectfloor.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Ph:"),
                                Text(
                                  Order.conatctrider.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email:"),
                                Text(
                                  Order.rideremail.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )),
                        // User Details
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("ID:"),
                                Text(
                                  Order.userid.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Name:"),
                                Text(
                                  Order.username.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Ph:"),
                                Text(
                                  Order.userphone.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email:"),
                                Text(
                                  Order.useremail.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        )),
                        // DataCell(Text("")),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    Order.complainttype?.isNotEmpty == true
                                        ? Order.complainttype!
                                        : "No complaint",
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    Order.complaint?.isNotEmpty == true
                                        ? Order.complaint!
                                        : "No complaint",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        DataCell(Text(
                          Order.sendReplystatus == "1" ? "Resolved" : "Pending",
                          style: TextStyle(
                              color:
                              Order.sendReplystatus == "1" ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold),
                        )),
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
                                  builder: (context) => AdminSendReplyPage(
                                    complaintId: Order.orderid.toString(),
                                    userName: Order.username.toString(),
                                    complaintSubject:
                                        Order.complainttype.toString(),
                                    complaintText: Order.complaint.toString(),
                                  ),
                                ),
                              ).then(
                                (value) {
                                  context.read<OrderBloc>()
                                    ..add(FetchPlaceorderEvent(
                                        searchQuery: null,
                                        sendReplystatus: "1"));
                                },
                              );
                            },
                            child: Text("Edit"),
                          ),
                        ),
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
            fontSize: 16),
      ),
    );
  }
}
