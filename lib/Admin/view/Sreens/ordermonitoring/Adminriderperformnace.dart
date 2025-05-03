import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../Model/ordermonitoring_model/Rider_performance_model.dart';

class AdminRidrPerformnacewrapper extends StatelessWidget {
  const AdminRidrPerformnacewrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) =>OrderBloc()
        ..add(
          FetchPlaceorderEvent(searchQuery: null, status: "1"),
        ),
      child: AdminRidrPerformnace(),
    );
  }
}


class AdminRidrPerformnace extends StatefulWidget {
  const AdminRidrPerformnace({super.key});

  @override
  State<AdminRidrPerformnace> createState() => _AdminRidrPerformnaceState();
}

class _AdminRidrPerformnaceState extends State<AdminRidrPerformnace>
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
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
                Tab(text: "Rider Performace"),
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
                physics: const BouncingScrollPhysics(), // FIXED: Ensures smooth scrolling
                children: [
                  // AdminAllOrders(),
                  // AdminCompleteOrders(),
                  _buildShopTable("Rider Performace")
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
        }       },
  builder: (context, state) {
    if (state is OrderLoading) {
      return Column(
        children: [
          SizedBox(height: 200,),
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
          constraints: BoxConstraints(minWidth: MediaQuery
              .of(context)
              .size
              .width),
          child: DataTable(
            dataRowMaxHeight: 100,
            decoration: const BoxDecoration(color: Colors.white),
            columns: [
              _buildColumn('SL NO'),
              // _buildColumn('Date and Time'),
              _buildColumn('Order Details'),
              _buildColumn('Rider Details'),
              // _buildColumn('Total Delivery'),
              // _buildColumn('Total Amount'),
              _buildColumn('Review'),
              _buildColumn('Rating'),

            ],
            rows: List.generate(
              state.Orders.length,
                  (index) {
                    final Order = state.Orders[index];
                return DataRow(
                  cells: [
                    DataCell(Text((index + 1).toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                    // DataCell(Text("")),
                    DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Order_ID:"),
                                Text(Order.orderid.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),Row(
                              children: [
                                Text("Invoice_ID:"),
                                Text(Order.invoiceid.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),Row(
                              children: [
                                Text("Floor:"),
                                Text(Order.Selectfloor.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),Row(
                              children: [
                                Text("Delivery_Fees:"),
                                Text(Order.payment.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ],
                        )),DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("ID:"),
                                Text(Order.riderid.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),Row(
                              children: [
                                Text("Name:"),
                                Text(Order.Ridername.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),Row(
                              children: [
                                Text("Ph:"),
                                Text(Order.conatctrider.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Email:"),
                                Text(Order.rideremail.toString(),
                                  style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                          ],
                        )),
                    // DataCell(Text("")),
                    // DataCell(Text("")),
                    DataCell(
                      Text(
                        Order.Review?.isNotEmpty == true ? Order.Review! : "No review",
                      ),
                    ),
                    DataCell(Text(
                      Order.Ratingstatus?.isNotEmpty == true ? Order.Ratingstatus! : "No Rating",
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
            fontSize: 16),
      ),
    );
  }

}
