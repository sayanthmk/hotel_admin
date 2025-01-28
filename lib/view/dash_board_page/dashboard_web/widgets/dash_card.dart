import 'package:flutter/material.dart';
import 'package:hotel_admin/controller/data_service.dart/admin_data_service.dart';
import 'package:hotel_admin/model/hotel_model.dart';
import 'package:provider/provider.dart';

class DashWebHotelManagement extends StatelessWidget {
  const DashWebHotelManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hotel Management',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Consumer<AdminHotelProvider>(
              builder: (context, hotelProvider, child) {
                if (hotelProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (hotelProvider.errorMessage.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${hotelProvider.errorMessage}'));
                }

                final hotels = hotelProvider.approvedHotels;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: hotels.length,
                  itemBuilder: (context, index) {
                    HotelModel hotel = hotels[index];
                    return HotelCard(hotel: hotel);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final HotelModel hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(4)),
              image: DecorationImage(
                image: NetworkImage(hotel.images[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.hotelName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '${hotel.city},${hotel.country}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.hotel, color: Colors.green, size: 16),
                    Text(' ${hotel.hotelType}'),
                    const Spacer(),
                    Text(
                      '₹${hotel.propertySetup}/night',
                      style: TextStyle(
                          color: Colors.grey[800], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
