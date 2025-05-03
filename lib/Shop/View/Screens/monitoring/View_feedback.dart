import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';

class ShopViewFeedbackwrapper extends StatelessWidget {
  const ShopViewFeedbackwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(searchQuery: null, status: "1"),
        ),
      child: ShopViewFeedback(),
    );
  }
}

class ShopViewFeedback extends StatefulWidget {
  const ShopViewFeedback({super.key});

  @override
  State<ShopViewFeedback> createState() => _ShopViewFeedbackState();
}

class _ShopViewFeedbackState extends State<ShopViewFeedback>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.blue,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "View Complaints"),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildComplaintList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintList() {
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
          return Center(child: Loading_Widget());
        } else if (state is Orderfailerror) {
          return Center(child: Text(state.error.toString()));
        } else if (state is Ordersloaded) {
          if (state.Orders.isEmpty) {
            return Center(
              child: Text("No data found",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            );
          }
          return ListView.builder(
            itemCount: state.Orders.length,
            itemBuilder: (context, index) {
              final order = state.Orders[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  title: Text("Order ID: ${order.orderid}"),
                  subtitle: Text("Rider_ID: ${order.riderid}"),
                  children: [
                    ListTile(
                      title: Text("Rider_Name: ${order.Ridername}"),
                    ),
                    ListTile(
                      title: Text("Review: ${order.Review}"),
                    ),

                    ListTile(
                      title: Text("Rating: ${order.Ratingstatus}"),
                    ),
                    // ListTile(
                    //   title: Text(
                    //     "Status: ${order.sendReplystatus == '1' ? 'Resolved' : 'Pending'}",
                    //     style: TextStyle(
                    //       color: order.sendReplystatus == '1'
                    //           ? Colors.green
                    //           : Colors.red,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       // Navigator.push(
                    //       //   context,
                    //       //   MaterialPageRoute(
                    //       //     builder: (context) => AdminSendReplyPage(
                    //       //       complaintId: order.orderid.toString(),
                    //       //       userName: order.username.toString(),
                    //       //       complaintSubject: order.complainttype.toString(),
                    //       //       complaintText: order.complaint.toString(),
                    //       //     ),
                    //       //   ),
                    //       // ).then((value) {
                    //       //   context.read<OrderBloc>().add(FetchPlaceorderEvent(
                    //       //       searchQuery: null, sendReplystatus: "1"));
                    //       // });
                    //     },
                    //     child: Text("Send Reply"),
                    //   ),
                    // ),
                  ],
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
