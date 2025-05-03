import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mall_bud/User/View/Screens/Home/User_shop.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';

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
  State<RegisteredShop> createState() => _RegisteredShopState();
}

class _RegisteredShopState extends State<RegisteredShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text("Registered Shops"),
      //   // backgroundColor: Colors.blue,
      // ),
      body: Column(
        children: [
          Row(
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
                        searchQuery: value, status: "0")); // Pass search query
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          _buildShopTable("Registered Shops"),
        ],
      ),
    );
  }

  // Function to build shop tables for each tab
  Widget _buildShopTable(String title) {
    return BlocConsumer<ShopAuthBloc, ShopAuthState>(
      listener: (context, state) {
        // TODO: implement listener
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
          return ConstrainedBox(
            constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width),
            child: DataTable(
              dataRowMaxHeight: 100,
              decoration: const BoxDecoration(color: Colors.white),
              columns: [
                _buildColumn('SL NO'),
                _buildColumn('Owner Details'),
                _buildColumn('Shop Name'),
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
                      DataCell(Text((index + 1).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(shop.uid.toString())),
                      DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              shop.Ownername.toString(),
                              style:
                              const TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(shop.phone.toString(),
                                overflow: TextOverflow.ellipsis),
                            Text(shop.email.toString(),
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      DataCell(Text(shop.Shopname.toString())),
                      DataCell(Text(shop.Selectfloor.toString())),
                      DataCell(IconButton(
                          onPressed: () {
                            context.read<ShopAuthBloc>().add(
                                ShopAcceptRejectbuddyevent(
                                    status: "1", id: shop.uid));
                          },
                          icon: Icon(
                            Icons.done,
                            color: Colors.green,
                          ))),
                      DataCell(IconButton(
                          onPressed: () {
                            context.read<ShopAuthBloc>().add(
                                ShopAcceptRejectbuddyevent(
                                    status: "2", id: shop.uid));
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ))),
                    ],
                  );
                },
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
}
//////////////////////////////////////Accepted Buudy//////////////////////////////////////
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
  import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
  import '../../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
  import '../../../../../Widgets/Constants/Loading.dart';

class AdminAcceptedwrapper extends StatelessWidget {
const AdminAcceptedwrapper({super.key});

@override
Widget build(BuildContext context) {
return BlocProvider<ShopAuthBloc>(
create: (context) => ShopAuthBloc()
..add(FetchShopesDetailsEvent(searchQuery: null, status: "1")),
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
@override
Widget build(BuildContext context) {
return Scaffold(
// appBar: AppBar(
//   // title: const Text("Registered Shops"),
//   // backgroundColor: Colors.blue,
// ),
body: Column(
children: [
Row(
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
searchQuery: value, status: "1")); // Pass search query
},
decoration: InputDecoration(
hintText: 'Search',
prefixIcon: Icon(Icons.search, color: Colors.black),
border: InputBorder.none,
),
),
),
const SizedBox(width: 20),
],
),
_buildShopTable("Registered Shops"),
],
),
);
}

// Function to build shop tables for each tab
Widget _buildShopTable(String title) {
return BlocConsumer<ShopAuthBloc, ShopAuthState>(
listener: (context, state) {
// TODO: implement listener
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
return Column(
children: [
ConstrainedBox(
constraints:
BoxConstraints(minWidth: MediaQuery.of(context).size.width),
child: DataTable(
dataRowMaxHeight: 100,
decoration: const BoxDecoration(color: Colors.white),
columns: [
_buildColumn('SL NO'),
_buildColumn('Owner Details'),
_buildColumn('Shop Name'),
_buildColumn('Floor'),
_buildColumn('Edit'),
_buildColumn('Delete'),
],
rows: List.generate(
state.Shopes.length,
(index) {
final shop = state.Shopes[index];
return DataRow(
cells: [
DataCell(Text((index + 1).toString(),
style: const TextStyle(
fontWeight: FontWeight.bold))),
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
DataCell(Text(shop.Shopname.toString())),
DataCell(Text(shop.Selectfloor.toString())),
DataCell(IconButton(
onPressed: () {},
icon: Icon(
Icons.done,
color: Colors.green,
))),
DataCell(IconButton(
onPressed: () {},
icon: Icon(
Icons.close,
color: Colors.red,
))),
],
);
},
),
),
),
],
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

//////////////////////////////////////////close////////////////////////////////////////////