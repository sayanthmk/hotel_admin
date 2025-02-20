import 'package:flutter/material.dart';
import 'package:hotel_admin/controller/data_service.dart/admin_data_service.dart';
import 'package:hotel_admin/controller/report_service/report_service_page.dart';
import 'package:hotel_admin/model/report_model.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/all_hotel_search.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/filterbutton.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/sort_button.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/userinfo.dart';
import 'package:provider/provider.dart';

class ReportsMobileSection extends StatelessWidget {
  const ReportsMobileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportServiceProvider>(context);
    final hotelProvider = Provider.of<AdminHotelProvider>(context);

    if (reportProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (reportProvider.errorMessage.isNotEmpty) {
      return Center(child: Text('Error: ${reportProvider.errorMessage}'));
    }

    final reports = reportProvider.reportedIssues;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const CustomHotelSearchBar(),
                const SizedBox(height: 16),
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
                // UserInfo(
                //   userName: "John Doe",
                //   userInitials: "JD",
                //   onNotificationsPressed: () {},
                // ),
              ],
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                const SizedBox(height: 16),
                CustomFilterButtons(
                  onSelectDatePressed: () {},
                  onFiltersPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListView.separated(
              shrinkWrap: true,
              itemCount: reports.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                // AdminReportModel report = reports[index] as AdminReportModel;
                AdminReportModel report =
                    AdminReportModel.fromMap(reports[index]);
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(report.issueContent!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${report.issueDate} '),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 18),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         HotelsDetailsPageSection(hotel: report),
                        //   ),
                        // );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
