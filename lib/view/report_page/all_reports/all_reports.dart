import 'package:flutter/material.dart';
import 'package:hotel_admin/view/report_page/all_reports/report_mobile.dart';
import 'package:hotel_admin/view/report_page/all_reports/report_web.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return const ReportsMobileSection();
          } else {
            return const ReportsWebSection();
          }
        },
      ),
    );
  }
}
