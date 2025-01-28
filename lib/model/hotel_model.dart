import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class HotelModel {
  final String hotelId;
  final String hotelType;
  final String propertySetup;
  final String hotelName;
  final String bookingSince;
  final String contactNumber;
  final String emailAddress;
  final String city;
  final String state;
  final String country;
  final bool entireProperty;
  final bool privateProperty;
  final int pincode;
  final bool freeCancel;
  final bool coupleFriendly;
  final bool parkingFacility;
  final bool restaurantFacility;
  final String panNumber;
  final String propertyNumber;
  final String gstNumber;
  final bool leased;
  final bool registration;
  final bool documentImage;
  final List<String> images;

  HotelModel({
    required this.hotelId,
    required this.hotelType,
    required this.propertySetup,
    required this.hotelName,
    required this.bookingSince,
    required this.contactNumber,
    required this.emailAddress,
    required this.city,
    required this.state,
    required this.country,
    required this.entireProperty,
    required this.privateProperty,
    required this.pincode,
    required this.freeCancel,
    required this.coupleFriendly,
    required this.parkingFacility,
    required this.restaurantFacility,
    required this.panNumber,
    required this.propertyNumber,
    required this.gstNumber,
    required this.leased,
    required this.registration,
    required this.documentImage,
    required this.images,
  });

  // Modify the fromFirestore factory constructor to include the hotelId
  factory HotelModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    Map<String, dynamic> hotelDetails = data;

    // log('Parsing hotel data');
    return HotelModel(
      hotelId: doc.id, // Extract the hotelId from the DocumentSnapshot ID
      hotelType: hotelDetails['hotel_type'] ?? '',
      propertySetup: hotelDetails['property_setup'] ?? '',
      hotelName: hotelDetails['hotel_name'] ?? '',
      bookingSince: hotelDetails['Booking_since'] ?? '',
      contactNumber: hotelDetails['contact_number'] ?? '',
      emailAddress: hotelDetails['email_address'] ?? '',
      city: hotelDetails['city'] ?? '',
      state: hotelDetails['state'] ?? '',
      country: hotelDetails['country'] ?? '',
      pincode: hotelDetails['pincode'] ?? 0,
      entireProperty: hotelDetails['entire_property'] ?? false,
      privateProperty: hotelDetails['private_property'] ?? false,
      freeCancel: hotelDetails['free_cancel'] ?? false,
      coupleFriendly: hotelDetails['couple_friendly'] ?? false,
      parkingFacility: hotelDetails['parking_facility'] ?? false,
      restaurantFacility: hotelDetails['restaurant_facility'] ?? false,
      panNumber: hotelDetails['pan_number'] ?? '',
      propertyNumber: hotelDetails['property_number'] ?? '',
      gstNumber: hotelDetails['gst_number'] ?? '',
      leased: hotelDetails['leased'] ?? false,
      registration: hotelDetails['registration'] ?? false,
      documentImage: hotelDetails['document image'] ?? false,
      images: (hotelDetails['images'] is List)
          ? List<String>.from(hotelDetails['images'])
          : [],
    );
  }

  // Update the toJson method to include hotelId if needed for saving
  Map<String, dynamic> toJson() {
    return {
      "hotel_type": hotelType,
      "property_setup": propertySetup,
      "hotel_name": hotelName,
      "Booking_since": bookingSince,
      "contact_number": contactNumber,
      "email_address": emailAddress,
      "city": city,
      "state": state,
      "country": country,
      "entire_property": entireProperty,
      "private_property": privateProperty,
      "pincode": pincode,
      "free_cancel": freeCancel,
      "couple_friendly": coupleFriendly,
      "parking_facility": parkingFacility,
      "restaurant_facility": restaurantFacility,
      "pan_number": panNumber,
      "property number": propertyNumber,
      "gst_number": gstNumber,
      "leased": leased,
      "registration": registration,
      "document image": documentImage,
      "images": images,
    };
  }
}





// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HotelModel {
//   final String hotelId; // Add the hotelId field
//   final String hotelType;
//   final String propertySetup;
//   final String hotelName;
//   final int bookingSince;
//   final String contactNumber;
//   final String emailAddress;
//   final String city;
//   final String state;
//   final String country;
//   final int pincode;
//   final bool policy1;
//   final bool policy2;
//   final bool policy3;
//   final bool policy4;
//   final String panNumber;
//   final String propertyNumber;
//   final String gstNumber;
//   final bool leased;
//   final bool registration;
//   final String documentImage;
//   final List<String> images;

//   HotelModel({
//     required this.hotelId, // Add this to the constructor
//     required this.hotelType,
//     required this.propertySetup,
//     required this.hotelName,
//     required this.bookingSince,
//     required this.contactNumber,
//     required this.emailAddress,
//     required this.city,
//     required this.state,
//     required this.country,
//     required this.pincode,
//     required this.policy1,
//     required this.policy2,
//     required this.policy3,
//     required this.policy4,
//     required this.panNumber,
//     required this.propertyNumber,
//     required this.gstNumber,
//     required this.leased,
//     required this.registration,
//     required this.documentImage,
//     required this.images,
//   });

//   // Modify the fromFirestore factory constructor to include the hotelId
//   factory HotelModel.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     Map<String, dynamic> hotelDetails = data['hotel details'] ?? {};

//     log('Parsing hotel data');
//     return HotelModel(
//       hotelId: doc.id, // Extract the hotelId from the DocumentSnapshot ID
//       hotelType: hotelDetails['hotel_type']?.toString() ?? '',
//       propertySetup: hotelDetails['property_setup']?.toString() ?? '',
//       hotelName: hotelDetails['hotel_name']?.toString() ?? '',
//       bookingSince: hotelDetails['Booking_since'] is int
//           ? hotelDetails['Booking_since']
//           : int.tryParse(hotelDetails['Booking_since']?.toString() ?? '') ?? 0,
//       contactNumber: hotelDetails['contact number']?.toString() ?? '',
//       emailAddress: hotelDetails['email address']?.toString() ?? '',
//       city: hotelDetails['city']?.toString() ?? '',
//       state: hotelDetails['state']?.toString() ?? '',
//       country: hotelDetails['country']?.toString() ?? '',
//       pincode: hotelDetails['pincode'] is int
//           ? hotelDetails['pincode']
//           : int.tryParse(hotelDetails['pincode']?.toString() ?? '') ?? 0,
//       policy1:
//           hotelDetails['policy 1'] is bool ? hotelDetails['policy 1'] : false,
//       policy2:
//           hotelDetails['policy 2'] is bool ? hotelDetails['policy 2'] : false,
//       policy3:
//           hotelDetails['policy 3'] is bool ? hotelDetails['policy 3'] : false,
//       policy4:
//           hotelDetails['policy 4'] is bool ? hotelDetails['policy 4'] : false,
//       panNumber: hotelDetails['pan number']?.toString() ?? '',
//       propertyNumber: hotelDetails['property number']?.toString() ?? '',
//       gstNumber: hotelDetails['GST number']?.toString() ?? '',
//       leased: hotelDetails['leased'] is bool ? hotelDetails['leased'] : false,
//       registration: hotelDetails['registration'] is bool
//           ? hotelDetails['registration']
//           : false,
//       documentImage: hotelDetails['document image']?.toString() ?? '',
//       images: (hotelDetails['images'] is List)
//           ? List<String>.from(hotelDetails['images'])
//           : [],
//     );
//   }

//   // Update the toJson method to include hotelId if needed for saving
//   Map<String, dynamic> toJson() {
//     return {
//       "hotel details": {
//         "hotel_type": hotelType,
//         "property_setup": propertySetup,
//         "hotel_name": hotelName,
//         "Booking_since": bookingSince,
//         "contact number": contactNumber,
//         "email address": emailAddress,
//         "city": city,
//         "state": state,
//         "country": country,
//         "pincode": pincode,
//         "policy 1": policy1,
//         "policy 2": policy2,
//         "policy 3": policy3,
//         "policy 4": policy4,
//         "pan number": panNumber,
//         "property number": propertyNumber,
//         "GST number": gstNumber,
//         "leased": leased,
//         "registration": registration,
//         "document image": documentImage,
//         "images": images,
//       },
//     };
//   }
// }
