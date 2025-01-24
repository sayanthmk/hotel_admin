import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_admin/model/hotel_model.dart';

class AdminHotelProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Hotel data
  List<HotelModel> _hotels = [];
  List<HotelModel> _approvedHotels = [];
  List<HotelModel> _nonApprovedHotels = [];

  // State management
  bool _isLoading = true;
  String _errorMessage = '';

  // Getters
  List<HotelModel> get hotels => _hotels;
  List<HotelModel> get approvedHotels => _approvedHotels;
  List<HotelModel> get nonApprovedHotels => _nonApprovedHotels;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Constructor
  AdminHotelProvider() {
    fetchApprovedHotels();
    fetchNonApprovedHotels();
    fetchHotels();
  }

  // Fetch all hotels
  Future<void> fetchHotels() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot =
          await _firestore.collection('approved_hotels').get();
      _hotels =
          snapshot.docs.map((doc) => HotelModel.fromFirestore(doc)).toList();

      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> fetchApprovedHotels() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('approved_hotels')
          .where('status', isEqualTo: 'approved')
          .get();

      _approvedHotels =
          snapshot.docs.map((doc) => HotelModel.fromFirestore(doc)).toList();

      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<void> fetchNonApprovedHotels() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('approved_hotels')
          .where('status', isEqualTo: 'pending')
          .get();

      _nonApprovedHotels =
          snapshot.docs.map((doc) => HotelModel.fromFirestore(doc)).toList();

      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<void> approveHotel(HotelModel hotel) async {
    try {
      _isLoading = true;
      notifyListeners();

      DocumentReference destHotelRef =
          _firestore.collection('approved_hotels').doc(hotel.hotelId);

      await destHotelRef.update({
        'status': 'approved',
        'approvedAt': FieldValue.serverTimestamp(),
      });

      await fetchApprovedHotels();

      _isLoading = false;
      notifyListeners();

      // print(
      //     'Hotel status successfully updated to approved in approved_hotels!');
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Error approving hotel: ${e.toString()}';
      notifyListeners();
      // print('Error in approveHotel: $_errorMessage');
      rethrow;
    }
  }

  Future<String?> getTheAdminName() async {
    try {
      final String? currentUserId = FirebaseAuth.instance.currentUser?.email;

      if (currentUserId == null) {
        throw Exception('Error: User is not logged in.');
      }

      return currentUserId;
    } catch (e) {
      print('Error fetching admin ID: $e');
      return null; // Return `null` in case of an error
    }
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}
