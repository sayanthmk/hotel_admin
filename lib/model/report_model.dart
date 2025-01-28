class AdminReportModel {
  final String? id;
  final String? hotelId;
  final String? issueContent;
  final DateTime? issueDate;
  final String? userEmail;
  final String? issueId;

  AdminReportModel({
    this.id,
    this.hotelId,
    this.issueContent,
    this.issueDate,
    this.userEmail,
    this.issueId,
  });

  factory AdminReportModel.fromMap(
    Map<String, dynamic> map, {
    String? id,
  }) {
    final issuerpt = map['issueDetails'];
    return AdminReportModel(
        hotelId: map['hotelId'] ?? '',
        id: id,
        issueDate: (issuerpt['issueDate'] != null)
            ? DateTime.parse(issuerpt['issueDate'])
            : DateTime.now(),
        issueContent: issuerpt['issue_content'] ?? '',
        userEmail: map['userEmail'] ?? '',
        issueId: map['issueId']);
  }
}
