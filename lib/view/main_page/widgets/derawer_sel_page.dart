// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:hotel_admin/controller/auth_service/auth_service.dart';
import 'package:hotel_admin/controller/data_service.dart/admin_data_service.dart';
import 'package:hotel_admin/view/auth/login_page/login.dart';
import 'package:hotel_admin/view/main_page/widgets/draweritems.dart';
import 'package:provider/provider.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<AdminHotelProvider>().selectedIndex;

    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        color: Colors.grey[100],
        child: Column(
          children: [
            const DrawerHeaderWidget(
              logoPath: 'assets/images/logo_hotel.jpg',
              title: 'StayWise',
              subtitle: 'Admin Panel',
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerItemWidget(
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    selected: selectedIndex == 0,
                    onTap: () => context
                        .read<AdminHotelProvider>()
                        .updateSelectedIndex(0),
                  ),
                  DrawerItemWidget(
                    icon: Icons.hotel,
                    title: 'Hotels List',
                    selected: selectedIndex == 1,
                    onTap: () => context
                        .read<AdminHotelProvider>()
                        .updateSelectedIndex(1),
                  ),
                  DrawerItemWidget(
                    icon: Icons.person,
                    title: 'Permissions',
                    selected: selectedIndex == 2,
                    onTap: () => context
                        .read<AdminHotelProvider>()
                        .updateSelectedIndex(2),
                  ),
                  DrawerItemWidget(
                    icon: Icons.bar_chart,
                    title: 'Reports',
                    selected: selectedIndex == 3,
                    onTap: () => context
                        .read<AdminHotelProvider>()
                        .updateSelectedIndex(3),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Log out',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Navigator.of(context).pop();
                              await context.read<AuthService>().signOut();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                dense: true,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
