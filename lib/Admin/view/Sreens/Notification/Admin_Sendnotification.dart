import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Notification/NotificationModel/NotificationModel.dart';
import '../../../../Notification/admin_notification_bloc.dart';
import '../../../../Notification/admin_notification_state.dart';
import '../../../../Widgets/Constants/Loading.dart';
import '../../../../Widgets/Constants/colors.dart';

class Admin_SendNotification extends StatefulWidget {
  const Admin_SendNotification({super.key});

  @override
  State<Admin_SendNotification> createState() => _Admin_SendNotificationState();
}

class _Admin_SendNotificationState extends State<Admin_SendNotification> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  DateTime now = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
        centerTitle: true,
        backgroundColor: defaultBlue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Colors.grey[50],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notification Details Card
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Notification Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _titleController,
                              decoration: InputDecoration(
                                labelText: 'Notification Title',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: const Icon(Icons.title),
                              ),
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Enter title'
                                          : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _contentController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: 'Notification Content',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: const Icon(Icons.message),
                                alignLabelWithHint: true,
                              ),
                              validator:
                                  (value) =>
                                      value == null || value.isEmpty
                                          ? 'Enter content'
                                          : null,
                            ),
                            const SizedBox(height: 16),
                            // DropdownButtonFormField<String>(
                            //   value: _selectedPriority,
                            //   decoration: InputDecoration(
                            //     labelText: 'Priority',
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     prefixIcon: const Icon(Icons.priority_high),
                            //   ),
                            //   items: ['Low', 'Normal', 'High', 'Urgent']
                            //       .map((priority) => DropdownMenuItem(
                            //     value: priority,
                            //     child: Text(priority),
                            //   ))
                            //       .toList(),
                            //   onChanged: (value) {
                            //     if (value != null) {
                            //       setState(() {
                            //         _selectedPriority = value;
                            //       });
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Send Button
                    BlocConsumer<AdminNotificationBloc, AdminNotificationState>(
                      listener: (context, state) {
                        if (state is NotificationSend_message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                state.message,
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.send),
                            label:
                                state is NotificationSend_Loading
                                    ? Loading_Widget()
                                    : Text(
                                      'Send Notification',
                                      style: TextStyle(fontSize: 16),
                                    ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final Notification = Notificationmodel(
                                  NotificationContent:
                                      _contentController.text.trim(),
                                  NotificationDate:
                                      "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}",
                                  NotificationTime:
                                      "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
                                  NotificationMatter:
                                      _titleController.text.trim(),
                                );
                                context.read<AdminNotificationBloc>()..add(
                                  SendNotification_event(
                                    nofification: Notification,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: defaultBlue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 2,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 400,
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text("Title"),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Matter asdhsajdhah dsasjdgsajhdgadhasgdsjadsgd asjdhgsjdgdhgasdjgsda djsahgsdhdjahjsdghjasgd sajgdsjhdagshjdgasjdgahjsgd sajgsdjhgdasjhdghjdgdajh dsasjhdsgadgashdjsgdgahdsd asdsjdghajhgdsjdgsadajsgdjhg",
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Date : 10/10/25",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                "Time : 10.00",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete, color: Colors.red),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
