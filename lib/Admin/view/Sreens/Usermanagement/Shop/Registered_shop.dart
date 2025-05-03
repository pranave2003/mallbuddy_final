import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import '../../../../Model/User_Management/Buddy_model.dart';
import '../../../../Model/User_Management/shop_model.dart';

class PegisterdShopwrapper extends StatelessWidget {
  const PegisterdShopwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopAuthBloc>(
      create: (context) => ShopAuthBloc()
        ..add(FetchShopesDetailsEvent(searchQuery: null, status: "0")),
      child: RegisteredShop(),
    );
  }
}

class RegisteredShop extends StatefulWidget {
  const RegisteredShop({super.key});

  @override
  State<RegisteredShop> createState() => _RegisteredBuddyState();
}

class _RegisteredBuddyState extends State<RegisteredShop> {
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
    return BlocConsumer<ShopAuthBloc, ShopAuthState>(
      listener: (context, state) {
        if (state is ShopRefresh) {
          context
              .read<ShopAuthBloc>()
              .add(FetchShopesDetailsEvent(searchQuery: null, status: "0"));
        }
      },
      builder: (context, state) {
        if (state is ShopgetLoading) {
          return Center(child: Loading_Widget());
        } else if (state is Shopesfailerror) {
          return Text(state.error.toString());
        } else if (state is Shopesloaded) {
          if (state.Shopes.isEmpty) {
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
                  // _buildColumn('Date and Time'),
                  _buildColumn('Shop Details'),
                  _buildColumn('Owner Details'),
                  _buildColumn('Floor'),
                  _buildColumn('Accept'),
                  _buildColumn('Reject'),
                ],
                rows: List.generate(
                  state.Shopes.length,
                  (index) {
                    final shop = state.Shopes[index];
                    return DataRow(
                      cells: [
                        DataCell(Text(
                          (index + 1).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        // DataCell(Text("")),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Shop_ID:"),
                                Text(
                                  shop.uid.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Shop_Name"),
                                Text(
                                  shop.Shopname.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        )),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shop.Ownername.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(shop.phone.toString(),
                                  overflow: TextOverflow.ellipsis),
                              Text(shop.email.toString(),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        DataCell(Text(shop.Selectfloor.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context.read<ShopAuthBloc>().add(
                                        ShopAcceptRejectbuddyevent(
                                            status: "1", id: shop.uid));
                                  },
                                  icon: Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )),
                            ],
                          ),
                        ),
                        DataCell(Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<ShopAuthBloc>().add(
                                      ShopAcceptRejectbuddyevent(
                                          status: "2", id: shop.uid));
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                )),
                          ],
                        ))
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
