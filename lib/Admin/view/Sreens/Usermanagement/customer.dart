import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../Controller/Bloc/User_Authbloc/auth_bloc.dart';
import '../../../../Widgets/Constants/Loading.dart';

class AdminCustomer extends StatefulWidget {
  const AdminCustomer({super.key});

  @override
  State<AdminCustomer> createState() => _AdminCustomerState();
}

class _AdminCustomerState extends State<AdminCustomer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<int, bool> selectedEdit = {}; // Track Edit button state
  Map<int, bool> selectedDelete = {}; // Track Delete button state

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTabBar(),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildShopTable("All Customer"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Hello,", style: TextStyle(fontSize: 22)),
              Text("Good Morning Team!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(
                "Unlock insights, track growth, and manage performance effortlessly.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(width: 300),
          Row(
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: TextField(
                  onChanged: (value) {
                    context.read<AuthBloc>().add(
                        FetchUsers(searchQuery: value)); // Pass search query
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.grey)),
                child: Row(
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile/girl.png'),
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
    );
  }

  Widget _buildTabBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black,
        indicatorColor: Colors.blue,
        isScrollable: true,
        tabs: const [
          Tab(text: "All Customers"),
        ],
      ),
    );
  }

  Widget _buildShopTable(String title) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is BanRefresh) {
          context.read<AuthBloc>().add(FetchUsers(
                searchQuery: null,
              ));
        }
      },
      builder: (context, state) {
        if (state is UsersLoading) {
          return Center(child: Loading_Widget());
        } else if (state is Usersfailerror) {
          return Text(state.error.toString());
        } else if (state is Usersloaded) {
          if (state.Users.isEmpty) {
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
              constraints:
                  BoxConstraints(minWidth: MediaQuery.of(context).size.width),
              child: DataTable(
                dataRowMaxHeight: 80,
                decoration: const BoxDecoration(color: Colors.white),
                columns: [
                  _buildColumn('SL NO'),
                  // _buildColumn('Date and Time'),
                  _buildColumn('Customer Details'),
                  // _buildColumn('Invoice ID'),
                  _buildColumn('Action'),
                  _buildColumn('Ban User'),
                ],
                rows: List.generate(
                  state.Users.length,
                  (index) {
                    final User = state.Users[index];
                    return DataRow(
                      cells: [
                        DataCell(Text((index + 1).toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                        // DataCell(Text("")),
                        DataCell(
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.Users[index].name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(User.phone.toString(),
                                  overflow: TextOverflow.ellipsis),
                              Text(User.email.toString(),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        // DataCell(Text(User.uid.toString())),

                        DataCell(
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: User.Ban == "1"
                                      ? Colors.red
                                      : Colors.green,
                                  width: 1.5),
                              borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                              color: Colors.white, // Background color
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  User.Ban == "1"
                                      ? Icons.close
                                  : Icons.check_circle_rounded,
                                  color: User.Ban == "1"
                                      ? Colors.red
                                      : Colors.green,
                                ),
                                SizedBox(width: 5), // Spacing
                                Text(
                                  User.Ban == "1" ? "Baned" : "Active",
                                  style: TextStyle(
                                      color: User.Ban == "1"
                                          ? Colors.red
                                          : Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),

                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(BanUserevent(Ban: "1", id: User.uid));
                            },
                            child: Text(
                              "Ban",
                              style: TextStyle(color: Colors.red),
                            ),
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
