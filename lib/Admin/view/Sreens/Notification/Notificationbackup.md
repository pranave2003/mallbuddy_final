import 'package:flutter/material.dart';

class SendNotification extends StatefulWidget {
const SendNotification({super.key});

@override
State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
final _formKey = GlobalKey<FormState>();
final TextEditingController _titleController = TextEditingController();
final TextEditingController _contentController = TextEditingController();
final TextEditingController _searchController = TextEditingController();

String _selectedPriority = "Normal";
bool _sendToAll = false;
bool _isScheduled = false;
DateTime _scheduledDate = DateTime.now().add(const Duration(hours: 1));
TimeOfDay _scheduledTime = TimeOfDay.now();

// Sample recipient data
final List<Map<String, dynamic>> _allRecipients = [
{"id": "1", "name": "Marketing Team", "avatar": "M", "selected": false},
{"id": "2", "name": "Development Team", "avatar": "D", "selected": false},
{"id": "3", "name": "Sales Department", "avatar": "S", "selected": false},
{"id": "4", "name": "Executive Team", "avatar": "E", "selected": false},
{"id": "5", "name": "Customer Support", "avatar": "C", "selected": false},
];

List<Map<String, dynamic>> _filteredRecipients = [];

@override
void initState() {
super.initState();
_filteredRecipients = List.from(_allRecipients);
}

void _filterRecipients(String query) {
setState(() {
if (query.isEmpty) {
_filteredRecipients = List.from(_allRecipients);
} else {
_filteredRecipients = _allRecipients
.where((recipient) =>
recipient['name'].toLowerCase().contains(query.toLowerCase()))
.toList();
}
});
}

void _toggleRecipient(String id) {
setState(() {
final index =
_allRecipients.indexWhere((recipient) => recipient['id'] == id);
if (index != -1) {
_allRecipients[index]['selected'] = !_allRecipients[index]['selected'];

        // Update filtered list to reflect changes
        _filteredRecipients = List.from(_allRecipients);
        if (_searchController.text.isNotEmpty) {
          _filterRecipients(_searchController.text);
        }
      }
    });
}

void _toggleSendToAll() {
setState(() {
_sendToAll = !_sendToAll;
for (var recipient in _allRecipients) {
recipient['selected'] = _sendToAll;
}
_filteredRecipients = List.from(_allRecipients);
});
}

Future<void> _selectDate() async {
final DateTime? picked = await showDatePicker(
context: context,
initialDate: _scheduledDate,
firstDate: DateTime.now(),
lastDate: DateTime.now().add(const Duration(days: 365)),
);

    if (picked != null && picked != _scheduledDate) {
      setState(() {
        _scheduledDate = picked;
      });
    }
}

Future<void> _selectTime() async {
final TimeOfDay? picked = await showTimePicker(
context: context,
initialTime: _scheduledTime,
);

    if (picked != null && picked != _scheduledTime) {
      setState(() {
        _scheduledTime = picked;
      });
    }
}

void _sendNotification() {
if (_formKey.currentState!.validate()) {
String title = _titleController.text.trim();
String content = _contentController.text.trim();



      // Get selected recipients
      final selectedRecipients = _sendToAll
          ? "All Recipients"
          : _allRecipients
              .where((r) => r["selected"] == true)
              .map((r) => r["name"])
              .join(", ");

      // Format scheduled time if applicable
      final scheduledTimeStr = _isScheduled
          ? '${_scheduledDate.toLocal().toString().split(' ')[0]} at ${_scheduledTime.format(context)}'
          : 'Immediately';

      // TODO: Implement notification sending logic here (e.g., Firestore or API)
      print("Sending Notification:\nTitle: $title\nContent: $content");
      print("Priority: $_selectedPriority");
      print("Recipients: $selectedRecipients");


      // Show success dialog instead of just a snackbar
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Notification has been sent successfully!'),
              const SizedBox(height: 16),
              Text('Title: $title'),
              const SizedBox(height: 8),
              Text('Recipients: $selectedRecipients'),
              const SizedBox(height: 8),
              Text('Priority: $_selectedPriority'),
              const SizedBox(height: 8),
              Text('Scheduled: $scheduledTimeStr'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      // Clear form
      _titleController.clear();
      _contentController.clear();
      setState(() {
        for (var recipient in _allRecipients) {
          recipient['selected'] = false;
        }
        _filteredRecipients = List.from(_allRecipients);
        _sendToAll = false;
        _selectedPriority = 'Normal';
        _isScheduled = false;
      });
    }
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
backgroundColor: Theme.of(context).colorScheme.primary,
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
validator: (value) =>
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
validator: (value) =>
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

                    // Recipients Card
                    // Card(
                    //   elevation: 2,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const Text(
                    //               'Recipients',
                    //               style: TextStyle(
                    //                 fontSize: 18,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //             Row(
                    //               children: [
                    //                 const Text('Send to All'),
                    //                 Switch(
                    //                   value: _sendToAll,
                    //                   onChanged: (value) {
                    //                     _toggleSendToAll();
                    //                   },
                    //                   activeColor: Theme.of(context).colorScheme.primary,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         const SizedBox(height: 16),
                    //         if (!_sendToAll) ...[
                    //           TextFormField(
                    //             controller: _searchController,
                    //             decoration: InputDecoration(
                    //               labelText: 'Search Recipients',
                    //               border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.circular(8),
                    //               ),
                    //               prefixIcon: const Icon(Icons.search),
                    //               suffixIcon: _searchController.text.isNotEmpty
                    //                   ? IconButton(
                    //                 icon: const Icon(Icons.clear),
                    //                 onPressed: () {
                    //                   _searchController.clear();
                    //                   _filterRecipients('');
                    //                 },
                    //               )
                    //                   : null,
                    //             ),
                    //             onChanged: _filterRecipients,
                    //           ),
                    //           const SizedBox(height: 16),
                    //           Container(
                    //             decoration: BoxDecoration(
                    //               border: Border.all(color: Colors.grey.shade300),
                    //               borderRadius: BorderRadius.circular(8),
                    //             ),
                    //             height: 200,
                    //             child: _filteredRecipients.isEmpty
                    //                 ? const Center(
                    //               child: Text('No recipients found'),
                    //             )
                    //                 : ListView.builder(
                    //               itemCount: _filteredRecipients.length,
                    //               itemBuilder: (context, index) {
                    //                 final recipient = _filteredRecipients[index];
                    //                 return CheckboxListTile(
                    //                   title: Text(recipient['name']),
                    //                   secondary: CircleAvatar(
                    //                     backgroundColor: Theme.of(context).colorScheme.primary,
                    //                     child: Text(
                    //                       recipient['avatar'],
                    //                       style: const TextStyle(color: Colors.white),
                    //                     ),
                    //                   ),
                    //                   value: recipient['selected'],
                    //                   onChanged: (bool? value) {
                    //                     _toggleRecipient(recipient["id"]);
                    //                   },
                    //                   activeColor: Theme.of(context).colorScheme.primary,
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    const SizedBox(height: 20),

                    // Scheduling Card
                    // Card(
                    //   elevation: 2,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const Text(
                    //               'Schedule',
                    //               style: TextStyle(
                    //                 fontSize: 18,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //             Row(
                    //               children: [
                    //                 const Text('Schedule for later'),
                    //                 Switch(
                    //                   value: _isScheduled,
                    //                   onChanged: (value) {
                    //                     setState(() {
                    //                       _isScheduled = value;
                    //                     });
                    //                   },
                    //                   activeColor: Theme.of(context).colorScheme.primary,
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         if (_isScheduled) ...[
                    //           const SizedBox(height: 16),
                    //           Row(
                    //             children: [
                    //               Expanded(
                    //                 child: OutlinedButton.icon(
                    //                   icon: const Icon(Icons.calendar_today),
                    //                   label: Text(
                    //                     '${_scheduledDate.day}/${_scheduledDate.month}/${_scheduledDate.year}',
                    //                   ),
                    //                   onPressed: _selectDate,
                    //                   style: OutlinedButton.styleFrom(
                    //                     padding: const EdgeInsets.symmetric(vertical: 16),
                    //                   ),
                    //                 ),
                    //               ),
                    //               const SizedBox(width: 16),
                    //               Expanded(
                    //                 child: OutlinedButton.icon(
                    //                   icon: const Icon(Icons.access_time),
                    //                   label: Text(_scheduledTime.format(context)),
                    //                   onPressed: _selectTime,
                    //                   style: OutlinedButton.styleFrom(
                    //                     padding: const EdgeInsets.symmetric(vertical: 16),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // const SizedBox(height: 30),
                    //
                    // // Preview Card
                    // if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty)
                    //   Card(
                    //     elevation: 2,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(16.0),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           const Text(
                    //             'Preview',
                    //             style: TextStyle(
                    //               fontSize: 18,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 16),
                    //           Container(
                    //             padding: const EdgeInsets.all(16),
                    //             decoration: BoxDecoration(
                    //               color: Colors.grey[100],
                    //               borderRadius: BorderRadius.circular(8),
                    //               border: Border.all(color: Colors.grey.shade300),
                    //             ),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Container(
                    //                       padding: const EdgeInsets.symmetric(
                    //                         horizontal: 8,
                    //                         vertical: 4,
                    //                       ),
                    //                       decoration: BoxDecoration(
                    //                         color: _selectedPriority == 'Urgent'
                    //                             ? Colors.red
                    //                             : _selectedPriority == 'High'
                    //                             ? Colors.orange
                    //                             : _selectedPriority == 'Normal'
                    //                             ? Theme.of(context).colorScheme.primary
                    //                             : Colors.green,
                    //                         borderRadius: BorderRadius.circular(4),
                    //                       ),
                    //                       child: Text(
                    //                         _selectedPriority,
                    //                         style: const TextStyle(
                    //                           color: Colors.white,
                    //                           fontSize: 12,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     const SizedBox(width: 8),
                    //                     Text(
                    //                       _titleController.text.isEmpty
                    //                           ? 'Notification Title'
                    //                           : _titleController.text,
                    //                       style: const TextStyle(
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 16,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 8),
                    //                 Text(
                    //                   _contentController.text.isEmpty
                    //                       ? 'Notification content will appear here.'
                    //                       : _contentController.text,
                    //                 ),
                    //                 const SizedBox(height: 8),
                    //                 const Divider(),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Text(
                    //                       'To: ${_sendToAll ? 'All Recipients' : _allRecipients.where((r) => r['selected'] == true).map((r) => r['name']).join(', ')}',
                    //                       style: TextStyle(
                    //                         color: Colors.grey[600],
                    //                         fontSize: 12,
                    //                       ),
                    //                     ),
                    //                     if (_isScheduled)
                    //                       Text(
                    //                         'Scheduled: ${_scheduledDate.day}/${_scheduledDate.month} at ${_scheduledTime.format(context)}',
                    //                         style: TextStyle(
                    //                           color: Colors.grey[600],
                    //                           fontSize: 12,
                    //                         ),
                    //                       ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),

                    const SizedBox(height: 30),

                    // Send Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.send),
                        label: const Text(
                          'Send Notification',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: _sendNotification,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 2,
                        ),
                      ),
                    )
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
