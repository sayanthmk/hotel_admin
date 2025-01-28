import 'package:flutter/material.dart';

class DashWebNavBar extends StatelessWidget {
  const DashWebNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Section
          Row(
            children: [
              SizedBox(width: 8),
              Text(
                '',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          // Navigation Links Section
          Row(
            children: [
              NavItem(title: 'Home', isActive: true),
              NavItem(title: 'Overview', isActive: false),
              NavItem(title: 'Analytics', isActive: false),
              NavItem(title: ' Mangement', isActive: false),
              NavItem(title: 'Services', isActive: false),
              NavItem(title: 'Pricing', isActive: false),
            ],
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final bool isActive;

  const NavItem({
    super.key,
    required this.title,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.blue : Colors.black87,
          ),
        ),
      ),
    );
  }
}
