import 'package:flutter/material.dart';
import 'package:hotel_admin/model/report_model.dart';
import 'package:hotel_admin/view/report_page/reports_detail_page/report_detail_mobile/report_narrow.dart';
import 'package:hotel_admin/view/report_page/reports_detail_page/report_detail_web/report_wide_layout.dart';
import 'package:hotel_admin/widgets/list_widgets/detail_page/detail_top_container.dart';

class ReportDetailsPageSection extends StatelessWidget {
  final AdminReportModel? report;
  const ReportDetailsPageSection({super.key, this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const EnhancedTopContainer(
                  title: 'Report Details',
                ),
                if (constraints.maxWidth > 600)
                  ReportWideLayout(report: report)
                else
                  ReportNarrowLayout(report: report),
              ],
            ),
          );
        },
      ),
    );
  }
}
