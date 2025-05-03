import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';
import 'Edit_accepted_shop.dart';

class AdminRejectedWrapper extends StatelessWidget {
  const AdminRejectedWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAuthBloc()
        ..add(FetchShopesDetailsEvent(searchQuery: null, status: "2")),
      child: AdminRejectedShop(),
    );
  }
}

class AdminRejectedShop extends StatefulWidget {
  const AdminRejectedShop({super.key});

  @override
  State<AdminRejectedShop> createState() => _AdminRejectedShopState();
}

class _AdminRejectedShopState extends State<AdminRejectedShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 0.5, color: Colors.grey)),
                  child: TextField(
                    onChanged: (value) {
                      context.read<ShopAuthBloc>().add(FetchShopesDetailsEvent(
                          searchQuery: value, status: "2"));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildShopTable()),
        ],
      ),
    );
  }

  Widget _buildShopTable() {
    return BlocConsumer<ShopAuthBloc, ShopAuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ShopgetLoading) {
          return const Center(child: Loading_Widget());
        } else if (state is Shopesfailerror) {
          return Center(child: Text(state.error.toString()));
        } else if (state is Shopesloaded) {
          if (state.Shopes.isEmpty) {
            return const Center(
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
                  minWidth: MediaQuery.of(context).size.width),
              child: DataTable(
                columnSpacing: 15,
                dataRowHeight: 80,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  // _buildColumn('Date and Time'),
                  _buildColumn('Shop Details'),
                  _buildColumn('Owner Details'),
                  _buildColumn('Floor'),
                  _buildColumn('Rejected Shop'),
                  _buildColumn('Edit Shop'),
                ],
                rows: List.generate(
                  state.Shopes.length,
                      (index) {
                    final shop = state.Shopes[index];
                    return DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold))),
                        // const DataCell(Text("")),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Shop ID: ${shop.uid}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              Text("Shop Name: ${shop.Shopname}",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(shop.Ownername.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              Text(shop.phone.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                              Text(shop.email.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1),
                            ],
                          ),
                        ),
                        DataCell(Text(shop.Selectfloor.toString())),
                        DataCell(
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 1.5),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/admin/Rejected.png',
                                  height: 25,
                                  width: 25,
                                ),
                                const SizedBox(width: 5),
                                const Text("Rejected",
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.black, width: 1.5),
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShopEditPage(
                                    shopId: shop.uid.toString(),
                                    Shopname: shop.Shopname.toString(),
                                    ownerName: shop.Ownername.toString(),
                                    phone: shop.phone.toString(),
                                    floor: shop.Selectfloor.toString(),
                                  ),
                                ),
                              );
                            },
                            child: const Text("Edit"),
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
        return const SizedBox();
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
}
