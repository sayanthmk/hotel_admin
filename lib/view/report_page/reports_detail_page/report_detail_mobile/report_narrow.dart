import 'package:flutter/material.dart';
import 'package:hotel_admin/model/report_model.dart';
import 'package:hotel_admin/view/report_page/reports_detail_page/report_detail_mobile/report_header_mobile.dart';

class ReportNarrowLayout extends StatelessWidget {
  final AdminReportModel? report;
  const ReportNarrowLayout({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportHeaderSectionMobile(report: report),
          // const SizedBox(height: 16),
          // GeneralInformation(hotel: hotel),
          // const SizedBox(height: 16),
          // MediaSection(hotel: hotel),
          // const SizedBox(height: 16),
          // FinanceDetails(hotel: hotel),
          // const SizedBox(height: 16),
          // ContactDetails(hotel: hotel),
        ],
      ),
    );
  }
}
