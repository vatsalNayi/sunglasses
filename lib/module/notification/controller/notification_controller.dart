import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/data/services/api_checker.dart';
import '../model/notification_model.dart';
import '../repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  List<NotificationModel>? _notificationList = [];
  bool _hasNotification = false;
  bool _isLoading = false;
  List<NotificationModel>? get notificationList => _notificationList;
  bool get hasNotification => _hasNotification;
  bool get isLoading => _isLoading;

  Future<void> getNotificationList(int offset, bool reload, String type) async {
    print('Notification_api_call');

    if (offset == 1) {
      _notificationList = [];
      _isLoading = true;
      update();
    }
    Response response =
        await notificationRepo.getNotificationList(offset.toString(), type);
    if (response.statusCode == 200) {
      log('Response 200');
      response.body.forEach((notification) {
        NotificationModel _notification =
            NotificationModel.fromJson(notification);
        _notificationList!.add(_notification);
      });
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    debugPrint('Notification_api_call');

    if (offset == 1) {
      _isLoading = false;
      update();
    }
  }

  void saveSeenNotificationCount(int count) {
    notificationRepo.saveSeenNotificationCount(count);
  }

  int? getSeenNotificationCount() {
    return notificationRepo.getSeenNotificationCount();
  }

  void clearNotification() {
    _notificationList = null;
  }
}
