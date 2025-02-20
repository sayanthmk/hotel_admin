import 'package:flutter/material.dart';
import 'package:hotel_admin/controller/data_service.dart/admin_data_service.dart';
import 'package:hotel_admin/controller/report_service/report_service_page.dart';
import 'package:hotel_admin/model/report_model.dart';
import 'package:hotel_admin/view/report_page/reports_detail_page/report_detail_page.dart';
import 'package:hotel_admin/view/report_page/widgets/report_list_heading.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/all_hotel_search.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/filterbutton.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/heading_all.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/sort_button.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/statuschip.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/userinfo.dart';
import 'package:provider/provider.dart';

class ReportsWebSection extends StatelessWidget {
  const ReportsWebSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<AdminHotelProvider>(context);
    final reportProvider = Provider.of<ReportServiceProvider>(context);

    if (reportProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (reportProvider.errorMessage.isNotEmpty) {
      return Center(child: Text('Error: ${reportProvider.errorMessage}'));
    }

    final reports = reportProvider.reportedIssues;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 3,
                  child: CustomHotelSearchBar(),
                ),
                const SizedBox(width: 20),
                FutureBuilder<String?>(
                  future: hotelProvider.getTheAdminName(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return UserInfo(
                        userName: "Loading...",
                        userInitials: "..",
                        onNotificationsPressed: () {},
                      );
                    } else if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data == null) {
                      return UserInfo(
                        userName: "Admin",
                        userInitials: "A",
                        onNotificationsPressed: () {},
                      );
                    } else {
                      final name = snapshot.data!;
                      final initials = name.isNotEmpty
                          ? name
                              .trim()
                              .split(' ')
                              .map((word) => word[0])
                              .take(2)
                              .join()
                              .toUpperCase()
                          : "A";
                      return UserInfo(
                        userName: name,
                        userInitials: initials,
                        onNotificationsPressed: () {},
                      );
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            HeadingSection(
              title: 'Report Details',
              onAddNewHotelPressed: () {},
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SortButton(
                      text: "All Reports",
                      isActive: true,
                      onPressed: () {},
                    ),
                    SortButton(
                      text: "Active",
                      isActive: false,
                      onPressed: () {},
                    ),
                    SortButton(
                      text: "Solved",
                      isActive: false,
                      onPressed: () {},
                    ),
                    SortButton(
                      text: "UnderView",
                      isActive: false,
                      onPressed: () {},
                    ),
                  ],
                ),
                CustomFilterButtons(
                  onSelectDatePressed: () {},
                  onFiltersPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ReportListHeading(),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reports.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    AdminReportModel report =
                        AdminReportModel.fromMap(reports[index]);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReportDetailsPageSection(report: report)),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(report.userEmail!.split('@')[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                            ),
                            Expanded(
                                flex: 2,
                                child:
                                    Text(report.issueDate?.toString() ?? '')),
                            Expanded(
                              flex: 2,
                              child: Text('${report.userEmail}'),
                            ),
                            Expanded(flex: 2, child: Text(report.issueId!)),
                            const Expanded(
                              flex: 2,
                              child: CustomHotelStatusChip(status: 'report'),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(Icons.more_vert,
                                    color: Color(0xFF5B6871)),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
