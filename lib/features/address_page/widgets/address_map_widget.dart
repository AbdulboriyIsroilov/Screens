import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';

import 'address_bottom_sheet.dart';

class AddressMapWidget extends StatefulWidget {
  final MapController controller;
  final TextEditingController addressNameController;
  final TextEditingController fullAddressController;
  final bool isDefault;
  final Function(bool) onDefaultChanged;

  const AddressMapWidget({
    super.key,
    required this.controller,
    required this.addressNameController,
    required this.fullAddressController,
    required this.isDefault,
    required this.onDefaultChanged,
  });

  @override
  State<AddressMapWidget> createState() => _AddressMapWidgetState();
}

class _AddressMapWidgetState extends State<AddressMapWidget> with TickerProviderStateMixin {
  Marker? marker;
  double lat = 0;
  double lng = 0;
  String fullAddress = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 600.h,
      child: Stack(
        children: [
          FlutterMap(
            mapController: widget.controller,
            options: MapOptions(
              initialCenter: LatLng(41.285779, 69.203493),
              initialZoom: 15,
              onTap: (tapPosition, point) async {
                final parentContext = context;

                final animationController = AnimationController(
                  vsync: this,
                  duration: const Duration(milliseconds: 500),
                );

                final newMarker = Marker(
                  point: point,
                  width: 44,
                  height: 56,
                  child: SvgPicture.asset(AppSvgs.locationFilled, width: 44, height: 56),
                );

                setState(() {
                  marker = newMarker;
                  lat = point.latitude;
                  lng = point.longitude;
                });

                List<Placemark> placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
                final place = placemarks.first;
                fullAddress = "${place.street ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
                widget.fullAddressController.text = fullAddress;

                final tween = LatLngTween(
                  begin: widget.controller.camera.center,
                  end: point,
                );

                final animation = tween.animate(animationController);
                animation.addListener(() {
                  widget.controller.move(animation.value, widget.controller.camera.zoom);
                });

                animationController.forward().then((_) {
                  animationController.dispose();
                });

                if (parentContext.mounted) {
                  showBottomSheet(
                    context: parentContext,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (bottomSheetContext) {
                      return AddressBottomSheet(
                        addressNameController: widget.addressNameController,
                        fullAddressController: widget.fullAddressController,
                        lat: lat,
                        lng: lng,
                        fullAddress: fullAddress,
                        isDefault: widget.isDefault,
                        onDefaultChanged: widget.onDefaultChanged,
                      );
                    },
                  );
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "flutter_map_example",
              ),
              MarkerLayer(markers: marker != null ? [marker!] : []),
            ],
          ),
          Positioned(
            top: 15.h,
            right: 15.w,
            child: FloatingActionButton(
              backgroundColor: AppColors.white,
              onPressed: () async {
                await Geolocator.requestPermission();
                final position = await Geolocator.getCurrentPosition();
                widget.controller.move(
                  LatLng(position.latitude, position.longitude),
                  widget.controller.camera.zoom,
                );
              },
              child: SvgPicture.asset(
                AppSvgs.locationTarget,
                width: 25.w,
                height: 25.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
