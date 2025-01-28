import 'package:flutter/material.dart';
import 'package:hotel_admin/model/report_model.dart';
import 'package:hotel_admin/view/report_page/reports_detail_page/report_detail_web/report_gen_information.dart';
import 'package:hotel_admin/view/report_page/reports_detail_page/report_detail_web/report_header_web.dart';

class ReportWideLayout extends StatelessWidget {
  final AdminReportModel? report;
  const ReportWideLayout({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReportHeaderSectionWeb(report: report),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    ReportGeneralInformationWeb(report: report),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(
                flex: 1,
                child: Column(
                  children: [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
