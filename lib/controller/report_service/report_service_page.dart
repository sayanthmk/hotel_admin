import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportServiceProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Map<String, dynamic>> _reportedIssues = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Map<String, dynamic>> get reportedIssues => _reportedIssues;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Future<void> fetchReportedIssues() async {
    try {
      notifyListeners();
      final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserId == null) {
        print('Error: User ID is null');
        return;
      }
      log(currentUserId);

      final querySnapshot = await _firestore
          .collection('admin')
          .doc(currentUserId)
          .collection('reported_issues')
          .get();

      // Clear the list before adding new data
      _reportedIssues.clear();

      for (var doc in querySnapshot.docs) {
        _reportedIssues.add(doc.data());
      }

      // Notify listeners about the change
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;

      print('Error fetching reported issues: $e');
    }
  }
}
