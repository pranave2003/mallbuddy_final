import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
              _buildHeader(),
              SizedBox(height: 20),
              _buildStatsCards(),
              SizedBox(height: 20),
              _buildAnalyticsChart(),
              SizedBox(height: 20),
              _buildTransactionHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,",
                style: TextStyle(fontSize: 18, color: Colors.black54)),
            Text("Good Morning Team!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Container(
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0.5, color: Colors.grey)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0.5, color: Colors.grey)),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/profile/girl.png'),
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
    );
  }

  Widget _buildStatsCards() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Total Shop ", "35","assets/admin/Shopes.webp"),
          _buildStatItem("Total User", "4000","assets/admin/User.jpeg"),
          _buildStatItem("Total Buddy", "50","assets/admin/Buddy.jpg"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              imagePath,
              height: 100,
              width: 100,
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),

      ],
    );
  }



  Widget _buildAnalyticsChart() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Delivery & Cost",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 4),
          Text("Last 60 Days", style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Row(
            children: [
              Text("₹8589",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent)),
              SizedBox(width: 8),
              Text("▲329%",
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          Text("+956k vs prev. 60 days", style: TextStyle(color: Colors.green)),
          SizedBox(height: 16),
          Container(
            height: 150,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 70,
                barGroups: _chartData(),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        List<String> labels = [
                          "1-10 Aug",
                          "11-20 Aug",
                          "21-30 Aug",
                          "1-10 Nov",
                          "Month"
                        ];
                        return Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(labels[value.toInt()],
                              style: TextStyle(fontSize: 12)),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _chartData() {
    return [
      makeGroupData(0, 20, Colors.blue.withOpacity(0.4)),
      makeGroupData(1, 35, Colors.blue.withOpacity(0.4)),
      makeGroupData(2, 60, Colors.blue, isHighlighted: true),
      makeGroupData(3, 10, Colors.blue.withOpacity(0.4)),
      makeGroupData(4, 30, Colors.blue.withOpacity(0.4)),
    ];
  }

  BarChartGroupData makeGroupData(int x, double y, Color color,
      {bool isHighlighted = false}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 16,
          borderRadius: BorderRadius.circular(4),
          backDrawRodData: BackgroundBarChartRodData(
              show: true, toY: 70, color: Colors.grey.withOpacity(0.2)),
        ),
      ],
      showingTooltipIndicators: isHighlighted ? [0] : [],
    );
  }

  Widget _buildTransactionHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Transaction History",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            title: Text("Kiran Krishnan"),
            subtitle: Text("kiranbalakrishnan97@gmail.com"),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("₹5000",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                Text("Jan 22, 2025, 10:00am",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
