import 'package:flutter/material.dart';
import 'package:hotel_admin/controller/data_service.dart/admin_data_service.dart';
import 'package:hotel_admin/model/hotel_model.dart';
import 'package:hotel_admin/view/permissions_page/permission_detail_page/permission_detail.dart';
import 'package:hotel_admin/view/permissions_page/widgets/list_heading.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/all_hotel_search.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/filterbutton.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/heading_all.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/sort_button.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/statuschip.dart';
import 'package:hotel_admin/widgets/list_widgets/list_page/userinfo.dart';
import 'package:provider/provider.dart';

class PermissionsWebSection extends StatelessWidget {
  const PermissionsWebSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<AdminHotelProvider>(context);

    if (hotelProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hotelProvider.errorMessage.isNotEmpty) {
      return Center(child: Text('Error: ${hotelProvider.errorMessage}'));
    }

    final hotels = hotelProvider.nonApprovedHotels;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 3,
                  child: CustomHotelSearchBar(),
                ),
                const SizedBox(width: 20),
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
            const SizedBox(height: 32),
            HeadingSection(
              title: 'Permissions List',
              onAddNewHotelPressed: () {},
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SortButton(
                      text: "All Hotels",
                      isActive: true,
                      onPressed: () {},
                    ),
                    SortButton(
                      text: "Available",
                      isActive: false,
                      onPressed: () {},
                    ),
                    SortButton(
                      text: "Occupied",
                      isActive: false,
                      onPressed: () {},
                    ),
                    SortButton(
                      text: "Maintenance",
                      isActive: false,
                      onPressed: () {},
                    ),
                  ],
                ),
                CustomFilterButtons(
                  onSelectDatePressed: () {},
                  onFiltersPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PermissionListHeading(),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: hotels.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    HotelModel hotel = hotels[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PermissionsDetailsPageSection(hotel: hotel),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Text(hotel.hotelName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500))),
                            Expanded(flex: 2, child: Text(hotel.hotelType)),
                            Expanded(
                                flex: 2,
                                child:
                                    Text(' ${hotel.state},${hotel.country}')),
                            Expanded(
                                flex: 2, child: Text('${hotel.contactNumber}')),
                            Expanded(
                              flex: 2,
                              child: CustomHotelStatusChip(
                                  status: '${hotel.status}'),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(Icons.more_vert,
                                    color: Color(0xFF5B6871)),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
