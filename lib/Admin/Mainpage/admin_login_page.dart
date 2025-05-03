import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../Controller/Bloc/Order_Authbloc/order_bloc.dart';
import '../../Controller/Bloc/Shop_Authbloc/shopbloc_bloc.dart';
import '../../Controller/Bloc/Shop_Authbloc/shopbloc_event.dart';
import '../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../Notification/admin_notification_bloc.dart';
import '../../Widgets/Constants/colors.dart';
import '../../firebase_options.dart';
import '../view/Auth/Admin_Login.dart';
import '../view/Sreens/Dashboard/dashboard.dart';
import '../view/Sreens/Notification/Admin_Sendnotification.dart';
import '../view/Sreens/Report/admin_report.dart';
import '../view/Sreens/Usermanagement/Shop.dart';
import '../view/Sreens/Usermanagement/buddy.dart';
import '../view/Sreens/Usermanagement/customer.dart';
import '../view/Sreens/ordermonitoring/Orders/AdminAllorders.dart';
import '../view/Sreens/ordermonitoring/Adminriderperformnace.dart';
import '../view/Sreens/ordermonitoring/Orders/Adminorders.dart';
import '../view/Sreens/ordermonitoring/View_Complaint.dart';
import '../view/Sreens/servicecustomization/admin_Delivery_fees.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()
            ..add(FetchUsers(
              searchQuery: null,
            )),
        ),
        BlocProvider<ShopAuthBloc>(
          create: (context) => ShopAuthBloc()
            ..add(FetchShopesDetailsEvent(searchQuery: null, status: "0")),
        ),
        BlocProvider<BuddyAuthBloc>(
          create: (context) => BuddyAuthBloc()
            ..add(FetchBuddyDetailsEvent(searchQuery: null, status: "0")),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc()
            ..add(
              FetchPlaceorderEvent(
                searchQuery: null,
                status: '0',
              ),
            ),
          child: AdminAllOrders(),
        ),
        BlocProvider<AdminNotificationBloc>(
            create: (context) => AdminNotificationBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(seedColor: defaultBlue),
            useMaterial3: true,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AdminPage();
              } else {
                return AdminLoginPage();
              }
            },
          )),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget? _selectedPage; // Variable to hold the currently selected page
  String? _selectedTile; // Tracks the selected tile
  String? _expandedTile;

  @override
  void initState() {
    // TODO: implement initState
    _selectedPage = Dashboard();
    _selectedTile = "Dashboard";
    super.initState();
  }

  var mainExpansionSelectedColor = Colors.blue.shade900;
  var SubExpansionSelectedColor = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left side: Management options
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45),
                  bottomRight: Radius.circular(45)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.5), // Shadow color with transparency
                  spreadRadius: 2, // How much the shadow spreads
                  blurRadius: 10, // Softness of the shadow
                  offset: Offset(4, 4), // Changes position of shadow (x, y)
                ),
              ],
            ),
            width: 300,
            padding: const EdgeInsets.all(6.0),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(45),
                        bottomRight: Radius.circular(45)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ),
                // //////////////////////
                _buildMainListTile('Dashboard', const Dashboard(),
                    icon: Icons.dashboard),
                // /////////////////////////

                _buildMainExpansionTile(
                  title: 'User Management',
                  icon: Icons.perm_identity_sharp,
                  children: [
                    SubListTile("Customer", AdminCustomer()),
                    SubListTile("Buddy", AdminBuddy()),
                    SubListTile("Shop", AdminShop()),
                  ],
                ),
                _buildMainExpansionTile(
                  title: 'Order Monitoring',
                  icon: Icons.monitor_heart_outlined,
                  children: [
                    SubListTile("All Order", AdminOrders()),
                    // SubListTile("Completed order", AdminCompleteOrders()),
                    SubListTile(
                        "Rider Performance", AdminRidrPerformnacewrapper()),
                    SubListTile(
                        "View Complaints", AdminViewComplaintswrapper()),
                    // SubListTile("Customer Feedback", AdminAllOrders()),
                  ],
                ),
                _buildMainExpansionTile(
                  title: 'Service Customization',
                  icon: Icons.phonelink_setup_outlined,
                  children: [
                    SubListTile("Delivery Fees", AdminDeliveryFees()),
                    // SubListTile("Rider Incentives", AdminAllOrders()),
                    // SubListTile("Delivery Time", AdminAllOrders()),
                  ],
                ),
                _buildMainListTile('Notification', Admin_SendNotification(),
                    icon: Icons.send),
                _buildMainListTile('Reports', const Admin_report(),
                    icon: Icons.event_note_outlined),
                // _buildMainListTile(
                //   'Logout',
                //   const Dashboard(),
                //   icon: Icons.logout_outlined,
                //   iconColor: Colors.red,
                //   textColor: Colors.red,
                // ),
                ListTile(
                  onTap: () => FirebaseAuth.instance.signOut(),
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ),
          // Right side: Display selected page or add role form
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: _selectedPage ??
                  Center(
                    child: const Text('Select a management option'),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainExpansionTile({
    required String title,
    IconData? icon, // Made optional
    required List<Widget> children,
    e,
  }) {
    return ExpansionTile(
      textColor: mainExpansionSelectedColor,
      iconColor: mainExpansionSelectedColor,
      leading: Icon(
        icon,
      ), // Show icon only if it's provided
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(
        title,
        style: TextStyle(fontSize: 17),
      ),
      childrenPadding: EdgeInsets.zero,
      initiallyExpanded: _expandedTile == title,
      onExpansionChanged: (isExpanded) {
        setState(() {
          _expandedTile = isExpanded ? title : null; // Collapse other tiles
        });
      },
      children: children,
    );
  }

  Widget _buildESubxpansion({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      textColor: SubExpansionSelectedColor,
      iconColor: SubExpansionSelectedColor,
      leading: Icon(
        null,
      ), // Show icon only if it's provided
      shape: const RoundedRectangleBorder(side: BorderSide.none),
      title: Text(
        title,
        style: TextStyle(fontSize: 14),
      ),
      childrenPadding: EdgeInsets.zero,
      initiallyExpanded: _expandedTile == title,
      onExpansionChanged: (isExpanded) {
        setState(() {
          _expandedTile = isExpanded ? title : null; // Collapse other tiles
        });
      },
      children: children,
    );
  }

  Widget _buildMainListTile(
    String title,
    Widget page, {
    IconData? icon,
    Color textColor = Colors.red, // Added textColor parameter
    Color iconColor = Colors.red,
  }) {
    return Container(
      // decoration: BoxDecoration(
      //   color: _selectedTile == title ? Colors.grey.shade50 : Colors.transparent,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      child: ListTile(
        leading: icon != null
            ? Icon(icon,
                color: _selectedTile == title ? Colors.blue[900] : Colors.black)
            : null,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 17,
              color: _selectedTile == title
                  ? Colors.blue[900]
                  : Colors.black), // Correct fontSize usage
        ),
        onTap: () {
          setState(() {
            _selectedPage = page; // Set the selected page
            _selectedTile = title; // Set the selected tile
          });
        },
      ),
    );
  }

  Widget _buildSubListTile(
    String title,
    Widget page,
  ) {
    return Container(
        // decoration: BoxDecoration(
        //   // color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
        //   // borderRadius: BorderRadius.circular(10),
        // ),
        child: InkWell(
      onTap: () {
        setState(() {
          _selectedPage = page; // Set the selected page
          _selectedTile = title; // Set the selected tile
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  color: _selectedTile == title
                      ? Colors.blue[400]
                      : Colors.black), // Correct fontSize usage
            ),
          ),
        ],
      ),
    ));
  }

  Widget SubListTile(
    String title,
    Widget page,
  ) {
    return Container(
      // decoration: BoxDecoration(
      //   // color: _selectedTile == title ? Colors.grey[400] : Colors.transparent,
      //   // borderRadius: BorderRadius.circular(10),
      // ),
      child: ListTile(
        leading: SizedBox(
          width: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
              fontSize: 14,
              color: _selectedTile == title
                  ? Colors.blue[400]
                  : Colors.black), // Correct fontSize usage
        ),
        onTap: () {
          setState(() {
            _selectedPage = page; // Set the selected page
            _selectedTile = title; // Set the selected tile
          });
        },
      ),
    );
  }
}
