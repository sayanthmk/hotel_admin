import 'package:flutter/material.dart';

class CustomHotelStatusChip extends StatelessWidget {
  final String status;

  const CustomHotelStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color chipColor;
    String displayStatus;
    switch (status.toLowerCase()) {
      case 'approved':
        chipColor = Colors.green;
        displayStatus = 'Approved';
        break;
      case 'pending':
        chipColor = Colors.orange;
        displayStatus = 'Pending';
        break;
      case 'report':
        chipColor = Colors.red;
        displayStatus = 'Report Review';
        break;
      default:
        chipColor = Colors.grey;
        displayStatus = 'Maintenance';
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          displayStatus,
          style: TextStyle(color: chipColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
