import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../firebase_options.dart';
import '../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../Service/Notification_onesignal/onesignal_service.dart';
import 'Screens/Bottomnav/Bottom.dart';
import 'Screens/auth/Spashview.dart';
import 'Screens/auth/User_login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("e84fa84c-e900-4915-9307-d9801d113f7d");
  OneSignal.Notifications.requestPermission(true);
  await initOneSignal();
  runApp(MyApp());
}

Future<void> initOneSignal() async {
  await Future.delayed(const Duration(seconds: 2));

  final id = OneSignal.User.pushSubscription.id;

  if (id != null) {
    print('✅ OneSignal Player ID: $id');
    OneSignalService().setPlayerId(id); // Store in the service
  } else {
    print("❌ Player ID is null. The user may not be subscribed yet......");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(FetchUsers(searchQuery: null)),
        ),
        BlocProvider<ShopAuthBloc>(
          create: (context) => ShopAuthBloc()..add(FetchShopDetailsById()),
        ),
        BlocProvider<ShopAuthBloc>(
          create:
              (context) =>
                  ShopAuthBloc()..add(
                    FetchShopesDetailsEvent(searchQuery: null, status: '1'),
                  ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          '/': (context) => Splashpagewrapper(),
          '/home': (context) => UserBottomnavwrapper(),
          '/login': (context) => User_Loginwrapper(),
        },
      ),
    );
  }
}
