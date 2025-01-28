import 'package:flutter/material.dart';

class DashWebQuickStats extends StatelessWidget {
  const DashWebQuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.5,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          StatCard(
              title: 'Total Hotels',
              value: '3',
              icon: Icons.hotel,
              color: Colors.blue),
          StatCard(
              title: 'Active Bookings',
              value: '15',
              icon: Icons.book_online,
              color: Colors.green),
          StatCard(
              title: 'Total Revenue',
              value: '₹2413',
              icon: Icons.attach_money,
              color: Colors.orange),
          StatCard(
              title: 'Active Users',
              value: '4',
              icon: Icons.people,
              color: Colors.purple),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
