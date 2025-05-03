import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../../../Controller/Bloc/Shop_Authbloc/shopbloc_state.dart';
import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';
import 'listinvoices.dart';

class Shopwrapper extends StatelessWidget {
  const Shopwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShopAuthBloc>(
      create: (context) => ShopAuthBloc()
        ..add(FetchShopesDetailsEvent(searchQuery: null, status: '1')),
      child: Shop(),
    );
  }
}

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) {
                  context.read<ShopAuthBloc>()
                    ..add(FetchShopesDetailsEvent(
                        searchQuery: value, status: '1'));
                },
                decoration: InputDecoration(
                  hintText: "Search here...",
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  // Search Icon inside TextFormField
                  filled: true,
                  fillColor: Colors.grey[200],
                  // Background color
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ShopAuthBloc, ShopAuthState>(
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.7, // Adjusted for subtitle
                    ),
                    itemCount: state.Shopes.length,
                    itemBuilder: (context, index) {
                      final shop = state.Shopes[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListViewShopPage(
                                  ShopID:shop.uid.toString(),
                                    Shopname: shop.Shopname.toString(),
                                    Shopfloor: shop.Selectfloor.toString()),
                              ));
                          print(shop.uid);
                        },
                        child: ShopGridViewItem(
                          image: shop.Image.toString(),
                          name: shop.Shopname.toString(),
                          subtitle: shop.Selectfloor.toString(),
                        ),
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShopGridViewItem extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;

  const ShopGridViewItem({
    Key? key,
    required this.image,
    required this.name,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(12), // Rounded corners for image
                child: CachedNetworkImage(
                  imageUrl: image.toString(),
                  width: 200, // Adjusted width
                  height: 200, // Adjusted height
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[50], // Placeholder background
                    child: Center(
                      child: Loading_Widget(), // Loading indicator
                    ),
                  ),
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                      width: 130,
                      height: 100,
                      color: Colors.grey[300], // Placeholder background
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey[600],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Left-align text
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2), // Small gap between title & subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
