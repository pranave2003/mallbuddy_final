import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Admin_report(),
    );
  }
}

class Admin_report extends StatelessWidget {
  const Admin_report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello,", style: TextStyle(fontSize: 20)),
                      Text("Good Morning Team!",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(
                        "Unlock insights, track growth, and manage performance effortlessly.",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.search, size: 28),
                      SizedBox(width: 12),
                      CircleAvatar(backgroundImage: AssetImage('assets/admin.jpg')),
                      SizedBox(width: 8),
                      Text("Admin")
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoCard("Monthly Revenue", "₹1000", "+200%", "Previous month ₹800"),
                    _buildInfoCard("Monthly Delivery", "₹4000", "+150%", "Previous month ₹2550"),
                    _buildInfoCard("Total Profit", "₹5000", "+400%", "Previous year ₹4000"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatsCard("Total Customer", "50"),
                  _buildStatsCard("New Customer", "25"),
                  _buildStatsCard("Active Sessions", "5"),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(value: 25, color: Colors.lightBlue, title: '25%'),
                              PieChartSectionData(value: 20, color: Colors.orangeAccent, title: '20%'),
                              PieChartSectionData(value: 20, color: Colors.deepOrange, title: '20%'),
                              PieChartSectionData(value: 10, color: Colors.indigo, title: '10%'),
                              PieChartSectionData(value: 5, color: Colors.green, title: '5%'),
                              PieChartSectionData(value: 20, color: Colors.teal, title: '20%'),
                            ],
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 10),
                    // Expanded(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(16),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(12),
                    //       border: Border.all(color: Colors.grey.shade300),
                    //     ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         const Text("Total Revenue", style: TextStyle(fontWeight: FontWeight.bold)),
                    //         const SizedBox(height: 10),
                    //         Expanded(
                    //           child: BarChart(
                    //             BarChartData(
                    //               barGroups: [
                    //                 BarChartGroupData(x: 0, barRods: [
                    //                   BarChartRodData(toY: 40, color: Colors.grey, width: 10),
                    //                   BarChartRodData(toY: 80, color: Colors.blue, width: 10),
                    //                 ]),
                    //                 BarChartGroupData(x: 1, barRods: [
                    //                   BarChartRodData(toY: 15, color: Colors.grey, width: 10),
                    //                   BarChartRodData(toY: 36, color: Colors.blue, width: 10),
                    //                 ]),
                    //               ],
                    //               borderData: FlBorderData(show: false),
                    //               titlesData: FlTitlesData(show: false),
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, String percentage, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(value,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(percentage, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildStatsCard(String title, String value) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
