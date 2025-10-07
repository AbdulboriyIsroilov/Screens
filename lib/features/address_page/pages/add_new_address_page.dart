import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:screens/core/utils/app_colors.dart';
import 'package:screens/core/utils/app_svg.dart';
import 'package:screens/features/common/widgets/app_bar_common.dart';

import '../../../core/l10n/app_localizations.dart';
import '../widgets/address_bottom_sheet.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({super.key});

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> with TickerProviderStateMixin {
  final controller = MapController();
  final addressNameController = TextEditingController();
  final fullAddressController = TextEditingController();

  Marker? marker;
  double lat = 0;
  double lng = 0;
  String fullAddress = "";
  bool isDefault = false;

  @override
  void dispose() {
    controller.dispose();
    addressNameController.dispose();
    fullAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyLocalizations local = MyLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarCommon(
        title: "New Address",
        activ: 3,
        onPressed: () {
          context.pop();
        },
      ),
      body: Column(
        children: [
          Builder(
            builder:(context)=> SizedBox(
              width: double.infinity,
              height: 600.h,
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: controller,
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
                        fullAddressController.text = fullAddress;

                        final tween = LatLngTween(
                          begin: controller.camera.center,
                          end: point,
                        );

                        final animation = tween.animate(animationController);
                        animation.addListener(() {
                          controller.move(animation.value, controller.camera.zoom);
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
                                addressNameController: addressNameController,
                                fullAddressController: fullAddressController,
                                lat: lat,
                                lng: lng,
                                fullAddress: fullAddress,
                                isDefault: isDefault,
                                onDefaultChanged: (val) {
                                  setState(() {
                                    isDefault = val;
                                  });
                                },
                              );
                            },
                          );
                        }
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        userAgentPackageName: "dars419_flutter_map",
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
                        controller.move(
                          LatLng(position.latitude, position.longitude),
                          controller.camera.zoom,
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
            ),
          ),
        ],
      ),
    );
  }
}
