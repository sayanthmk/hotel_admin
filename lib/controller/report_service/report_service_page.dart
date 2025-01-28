import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportServiceProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> _reportedIssues = [];
  bool _isLoading = true;
  String _errorMessage = '';

  List<Map<String, dynamic>> get reportedIssues => _reportedIssues;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  ReportServiceProvider() {
    fetchReportedIssues();
  }

  Future<void> fetchReportedIssues() async {
    try {
      final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) {
        _errorMessage = 'User not logged in';
        _isLoading = false;
        notifyListeners();
        return;
      }

      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('admin')
          .doc(currentUserId)
          .collection('reported_issues')
          .get();

      _reportedIssues.clear();

      for (var doc in querySnapshot.docs) {
        _reportedIssues.add(doc.data());
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> blockHotel(String hotelId) async {
    try {
      _isLoading = true;
      notifyListeners();

      DocumentReference destHotelRef =
          _firestore.collection('approved_hotels').doc(hotelId);

      await destHotelRef.update({
        'status': 'pending',
      });

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Error approving hotel: ${e.toString()}';
      notifyListeners();

      rethrow;
    }
  }
}
