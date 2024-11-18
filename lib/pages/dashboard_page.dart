import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  final int rescued = 150;
  final int ongoingRescue = 5;
  final int pending = 10;
  final int adopted = 75;

  @override
  Widget build(BuildContext context) {
    final total = rescued + ongoingRescue + pending;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Pie Chart Section
              const Text(
                'Rescue Status Overview',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: (rescued / total) * 100,
                        color: Colors.pinkAccent,
                        title: '${rescued.toString()}',
                        radius: 80,
                        titleStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: (ongoingRescue / total) * 100,
                        color: Colors.orangeAccent,
                        title: '${ongoingRescue.toString()}',
                        radius: 70,
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: (pending / total) * 100,
                        color: Colors.redAccent,
                        title: '${pending.toString()}',
                        radius: 70,
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    centerSpaceRadius: 50,
                    sectionsSpace: 3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(Colors.pinkAccent, 'Rescued'),
                  const SizedBox(width: 10),
                  _buildLegendItem(Colors.orangeAccent, 'Ongoing'),
                  const SizedBox(width: 10),
                  _buildLegendItem(Colors.redAccent, 'Pending'),
                ],
              ),
              const SizedBox(height: 30),
              // Statistics Boxes
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final data = [
                    {
                      'title': 'Total Rescued',
                      'value': rescued,
                      'color': Colors.pinkAccent,
                      'icon': Icons.pets,
                    },
                    {
                      'title': 'Ongoing Rescues',
                      'value': ongoingRescue,
                      'color': Colors.orangeAccent,
                      'icon': Icons.hourglass_top,
                    },
                    {
                      'title': 'Total Adopted',
                      'value': adopted,
                      'color': Colors.blueAccent,
                      'icon': Icons.home,
                    },
                    {
                      'title': 'Total Pending',
                      'value': pending,
                      'color': Colors.redAccent,
                      'icon': Icons.pending_actions,
                    },
                  ][index];

                  return _buildStatCard(
                    data['title'] as String,
                    data['value'] as int,
                    data['color'] as Color,
                    data['icon'] as IconData,
                    size.width,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color, IconData icon, double width) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: width > 600 ? 50 : 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
