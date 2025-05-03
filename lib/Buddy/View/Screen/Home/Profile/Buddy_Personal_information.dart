import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_bloc.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_event.dart';
import '../../../../../Controller/Bloc/Buddy_Authbloc/buddy_auth_state.dart';
import '../../../../../Widgets/Constants/Loading.dart';

class BuddyPersonalInformationPageWrapper extends StatelessWidget {
  const BuddyPersonalInformationPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuddyAuthBloc()..add(FetchBuddyDetailsById()),
      child: const BuddyPersonalInformationPage(),
    );
  }
}

class BuddyPersonalInformationPage extends StatelessWidget {
  const BuddyPersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Details"),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<BuddyAuthBloc, BuddyAuthState>(
        listener: (context, state) {
          if (state is BuddyProfileImageSuccess) {
            context.read<BuddyAuthBloc>().add(FetchBuddyDetailsById());
          }
        },
        builder: (context, state) {
          if (state is Buddyloading) {
            return const Center(child: Loading_Widget());
          } else if (state is BuddyByidLoaded) {
            final user = state.Userdata;
// Format DOB with age
            String dob = user.Dob ?? "N/A";
            String dobWithAge = dob;
            try {
              final dobDate = DateFormat('yyyy-MM-dd').parse(dob);
              final today = DateTime.now();
              final age = today.year -
                  dobDate.year -
                  (today.month < dobDate.month ||
                          (today.month == dobDate.month &&
                              today.day < dobDate.day)
                      ? 1
                      : 0);
              dobWithAge = "$dob, Age: $age";
            } catch (_) {
              // Ignore format issues
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: user.Image.toString(),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.white,
                        child: const Center(child: Loading_Widget()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // User Details
                  Expanded(
                    child: ListView(
                      children: [
                        buildDetailRow("User Name", user.name ?? "N/A"),
                        buildDetailRow("Date of Birth", dobWithAge),
                        buildDetailRow("Gender", user.Gender ?? "N/A"),
                        buildDetailRow(
                          "Aadhaar Card",
                          user.aadhaarimage != null ? "Download here!" : "N/A",
                          trailing: user.aadhaarimage != null
                              ? IconButton(
                                  icon: const Icon(Icons.download),
                                  onPressed: () => _downloadAadhaar(
                                      context, user.aadhaarimage!),
                                )
                              : null,
                        ),
                        buildDetailRow("Aadhaar Number ", user.Aadhaarnumber ?? "N/A"),
                        buildDetailRow("Email Address", user.email ?? "N/A"),
                        buildDetailRow("Phone Number", user.phone ?? "N/A"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget buildDetailRow(String label, String value, {Widget? trailing}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _downloadAadhaar(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not launch Aadhaar link")),
      );
    }
  }
}
