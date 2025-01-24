class AdminReportModel {
  final String? id;
  final String? hotelId;
  final String? issueContent;
  final DateTime? issueDate;
  final String? userEmail;

  AdminReportModel({
    this.id,
    this.hotelId,
    this.issueContent,
    this.issueDate,
    this.userEmail,
  });

  factory AdminReportModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
  }) {
    return AdminReportModel(
      hotelId: map['hotelId'] ?? '',
      id: id,
      issueDate: (map['issueDate'] != null)
          ? DateTime.parse(map['issueDate'])
          : DateTime.now(),
      issueContent: map['issue_content'] ?? '',
      userEmail: map['userEmail'] ?? '',
    );
  }
}
