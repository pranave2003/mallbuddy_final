import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';

class ListViewShopPage extends StatefulWidget {
  final String Shopname;
  final String Shopfloor;
  final String ShopID;
  const ListViewShopPage(
      {super.key,
        required this.Shopname,
        required this.Shopfloor,
        required this.ShopID});

  @override
  State<ListViewShopPage> createState() => _ListViewShopPageState();
}

class _ListViewShopPageState extends State<ListViewShopPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderBloc>(
      create: (context) => OrderBloc()
        ..add(
          FetchPlaceorderEvent(searchQuery: null, status: "1"),
        ),
      child: ShopViewComplaints(),
    );
  }
}

class ShopViewComplaints extends StatefulWidget {
  const ShopViewComplaints({super.key});

  @override
  State<ShopViewComplaints> createState() => _ShopViewComplaintsState();
}

class _ShopViewComplaintsState extends State<ShopViewComplaints>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.white,),
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
                    Tab(text: "View Shop"),
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
                  title: Text("Order_ID: ${order.orderid}"),
                  subtitle: Text("Shop_Name: ${order.shopname}"),
                  children: [
                    ListTile(
                      title: Text(" Order_ID: ${order.orderid}"),
                    ),ListTile(
                      title: Text("Invoice ID: ${order.invoiceid}"),
                    ),ListTile(
                      title: Text("Shop_Name: ${order.shopname}"),
                    ),ListTile(
                      title: Text("Shop_Floor: ${order.Selectfloor}"),
                    ),
                    ListTile(
                      title: Text("Rider_ID: ${order.riderid}"),
                    ), ListTile(
                      title: Text("Rider_Name: ${order.Ridername}"),
                    ),

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
