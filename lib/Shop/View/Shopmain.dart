import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase_options.dart';
import '../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../User/View/Screens/auth/Spashview.dart';
import '../Bottomnav/Shop_Bottom.dart';
import 'Screens/auth/shop_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopAuthBloc>(
          create: (context) => ShopAuthBloc()..add(FetchShopDetailsById()),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()
            ..add(FetchUsers(
              searchQuery: null,
            )),
        ),
        BlocProvider<BuddyAuthBloc>(
          create: (context) => BuddyAuthBloc()
            ..add(FetchBuddyDetailsEvent(searchQuery: null, status: "1")),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc()
            ..add(FetchPlaceorderEvent(searchQuery: null, status: "1")),
        ),
        BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => Splashpagewrapper(),
          '/home': (context) => ShopBottomnavwrapper(),
          '/login': (context) => Shop_Loginwrapper(),
        },
      ),
    );
  }
}
