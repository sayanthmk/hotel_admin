import 'package:flutter/material.dart';
import 'package:hotel_side/controllers/widgets_controller/widgets_controlle.dart';
import 'package:hotel_side/views/dashboard/hotel_dash.dart';
import 'package:hotel_side/views/home_page/home.dart';
import 'package:hotel_side/views/profile/profile_page.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatelessWidget {
  final List<Widget> pages = [
    const DashboardPage(),
    const HomePage(),
    const HomePage(),
    const UserProfileScreen(),
  ];

  BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WidgetsController>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Navigation Example'),
      // ),
      body: pages[provider.currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.setIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Rating',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
