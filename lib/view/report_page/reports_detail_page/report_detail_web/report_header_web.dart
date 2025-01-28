import 'package:flutter/material.dart';
import 'package:hotel_admin/controller/report_service/report_service_page.dart';
import 'package:hotel_admin/model/report_model.dart';
import 'package:hotel_admin/view/permissions_page/permission_detail_page/widgets/approval_button.dart';
import 'package:hotel_admin/view/permissions_page/permission_detail_page/widgets/snackbars.dart';
import 'package:provider/provider.dart';

class ReportHeaderSectionWeb extends StatelessWidget {
  final AdminReportModel? report;
  const ReportHeaderSectionWeb({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final reportProvider =
        Provider.of<ReportServiceProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blue.shade100,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.hotel_rounded,
                  size: 18,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hotel ID: ${report!.hotelId}'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                        letterSpacing: 0.5,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 12),
                ApprovalActionButton(
                  onPressed: () async {
                    try {
                      await reportProvider.blockHotel(report?.hotelId ?? '');
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);

                      const SuccessSnackBar(message: 'Hotel blocked!');
                    } catch (e) {
                      const ErrorSnackBar(
                          message: 'Failed to block hotel. Please try again.');
                    }
                  },
                  icon: Icons.check_rounded,
                  label: 'Block',
                  isReject: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
