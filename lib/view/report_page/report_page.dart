// import 'package:flutter/material.dart';
// import 'package:hotel_admin/model/report_model.dart';
// import 'package:provider/provider.dart';
// import '../../controller/report_service/report_service_page.dart';

// class AdminReportPage extends StatelessWidget {
//   const AdminReportPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ReportServiceProvider()..fetchReportedIssues(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Admin Reports'),
//         ),
//         body: Consumer<ReportServiceProvider>(
//           builder: (context, provider, child) {
//             if (provider.reportedIssues.isEmpty) {
//               return Center(
//                 child: Text('No reports found.'),
//               );
//             }

//             // Parse reported issues into AdminReportModel objects
//             final reports = provider.reportedIssues.map((issue) {
//               return AdminReportModel.fromMap(issue);
//             }).toList();

//             return ListView.builder(
//               itemCount: reports.length,
//               itemBuilder: (context, index) {
//                 final report = reports[index];

//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Issue Content:',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 4.0),
//                         Text(report.issueContent ?? 'No content provided'),
//                         SizedBox(height: 8.0),
//                         Text(
//                           'User Email: ${report.userEmail ?? 'N/A'}',
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           'Hotel ID: ${report.hotelId ?? 'N/A'}',
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           'Issue Date: ${report.issueDate?.toLocal().toString() ?? 'N/A'}',
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
