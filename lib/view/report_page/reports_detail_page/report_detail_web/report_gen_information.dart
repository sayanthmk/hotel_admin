import 'package:flutter/material.dart';
import 'package:hotel_admin/model/report_model.dart';
import 'package:hotel_admin/widgets/list_widgets/detail_page/detail_widgets.dart';
import 'package:hotel_admin/widgets/list_widgets/detail_page/info_row.dart';

class ReportGeneralInformationWeb extends StatelessWidget {
  final AdminReportModel? report;
  const ReportGeneralInformationWeb({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    if (report == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 4,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              icon: Icons.report,
              title: 'Report Reason',
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EnhancedInfoRow(
                    icon: Icons.content_copy,
                    label: 'Report Content',
                    value: report!.issueContent!,
                    valueStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Divider(height: 1),
            ),
            const SectionHeader(
              icon: Icons.details,
              title: 'Details',
              fontSize: 16,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EnhancedInfoRow(
                    icon: Icons.mail,
                    label: 'User mail',
                    value: report!.userEmail!,
                  ),
                  const SizedBox(height: 16),
                  EnhancedInfoRow(
                      icon: Icons.calendar_view_day_rounded,
                      label: 'Report Date',
                      value: report!.issueDate.toString()),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
