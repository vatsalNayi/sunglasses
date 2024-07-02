import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/module/notification/widgets/notification_type_widget.dart';
import '../../routes/pages.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen();

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'notification'.tr),
      body: Center(
        child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child: Column(
            children: [
              const SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              NotificationType(
                  image: ImagePath.offer,
                  title: 'offer'.tr,
                  unSeenCount: 2,
                  onTap: () =>
                      Get.toNamed(Routes.notificationViewRoute('offer'))),
              NotificationType(
                  image: ImagePath.feed,
                  title: 'feed'.tr,
                  unSeenCount: 2,
                  onTap: () =>
                      Get.toNamed(Routes.notificationViewRoute('feed'))),
              NotificationType(
                  image: ImagePath.activity,
                  title: 'activity'.tr,
                  unSeenCount: 2,
                  onTap: () =>
                      Get.toNamed(Routes.notificationViewRoute('activity'))),
            ],
          ),
        ),
      ),
    );
  }
}
