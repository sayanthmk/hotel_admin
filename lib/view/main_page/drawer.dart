import 'package:flutter/material.dart';
import 'package:hotel_admin/controller/data_service.dart/admin_data_service.dart';
import 'package:hotel_admin/view/all_hotels/all_hotels_page/all_hotels.dart';
import 'package:hotel_admin/view/dash_board_page/dash_main.dart';
import 'package:hotel_admin/view/main_page/widgets/derawer_sel_page.dart';
import 'package:hotel_admin/view/permissions_page/permission_page/permission_page.dart';
import 'package:hotel_admin/view/report_page/all_reports/all_reports.dart';
import 'package:provider/provider.dart';

class DrawerSample extends StatelessWidget {
  const DrawerSample({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AdminHotelProvider(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 600;

          return Scaffold(
            backgroundColor: const Color(0xFFE4E7E9),
            drawer: isSmallScreen ? const CustomDrawerWidget() : null,
            appBar: isSmallScreen
                ? AppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    backgroundColor: Colors.blue,
                    centerTitle: true,
                  )
                : null,
            body: Row(
              children: [
                if (!isSmallScreen)
                  const SizedBox(
                    width: 250,
                    child: CustomDrawerWidget(),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer<AdminHotelProvider>(
                      builder: (context, drawerState, _) {
                        return IndexedStack(
                          index: drawerState.selectedIndex,
                          children: const [
                            Dashboard(),
                            AllHotels(),
                            PermissionPage(),
                            Reports(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
