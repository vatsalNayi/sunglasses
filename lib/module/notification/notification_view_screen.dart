import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunglasses/core/utils/dimensions.dart';
import 'package:sunglasses/core/values/strings.dart';
import 'package:sunglasses/custom_widgets/custom_appbar.dart';
import 'package:sunglasses/custom_widgets/no_data_page.dart';
import 'package:sunglasses/custom_widgets/not_logged_in_screen.dart';
import 'package:sunglasses/custom_widgets/paginated_list_view.dart';
import 'package:sunglasses/module/auth/controller/auth_controller.dart';
import 'package:sunglasses/routes/pages.dart';
import '../../controller/theme_controller.dart';
import 'controller/notification_controller.dart';
import 'widgets/notification_dialog.dart';
import 'widgets/notification_widget.dart';

class NotificationViewScreen extends StatefulWidget {
  final String? form;
  final bool? fromNotification;
  NotificationViewScreen({required this.form, this.fromNotification});
  @override
  State<NotificationViewScreen> createState() => _NotificationViewScreenState();
}

class _NotificationViewScreenState extends State<NotificationViewScreen> {
  late bool _isLoggedIn;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    debugPrint(widget.form);
    Get.find<NotificationController>()
        .getNotificationList(1, false, widget.form!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.form!.tr,
          leadingIcon: ImagePath.backLeftSvg,
          onTapLeading: () {
            if (widget.fromNotification!) {
              Get.offAllNamed(Routes.getInitialRoute());
            } else {
              Get.back();
            }
          }),
      // notificationController.notificationList.length ==0 ?
      body: RefreshIndicator(
        onRefresh: () async {
          await Get.find<NotificationController>()
              .getNotificationList(1, true, widget.form!);
        },
        child: GetBuilder<NotificationController>(
            builder: (notificationController) {
          return (widget.form == 'activity' && !_isLoggedIn)
              ? NotLoggedInScreen()
              : (!notificationController.isLoading &&
                      notificationController.notificationList!.isEmpty)
                  ? NoDataScreen(
                      text: 'no_notification_found'.tr,
                      type: NoDataType.NOTIFICATION)
                  : notificationController.notificationList!.isNotEmpty
                      ? SingleChildScrollView(
                          controller: scrollController,
                          child: Center(
                              child: SizedBox(
                            width: Dimensions.WEB_MAX_WIDTH,
                            child: Column(
                              children: [
                                !notificationController.isLoading
                                    ? SizedBox(
                                        height: context.height - 90,
                                        child: SingleChildScrollView(
                                          controller: _scrollController,
                                          child: PaginatedListView(
                                            perPage: 10,
                                            scrollController: _scrollController,
                                            dataList: notificationController
                                                .notificationList,
                                            onPaginate: (int? offset) async =>
                                                Get.find<
                                                        NotificationController>()
                                                    .getNotificationList(
                                                        offset!,
                                                        false,
                                                        widget.form!),
                                            itemView: ListView.builder(
                                                key: UniqueKey(),
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount:
                                                    notificationController
                                                        .notificationList!
                                                        .length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return NotificationWidget(
                                                    title:
                                                        notificationController
                                                            .notificationList![
                                                                index]
                                                            .title,
                                                    description:
                                                        notificationController
                                                            .notificationList![
                                                                index]
                                                            .description,
                                                    dateTime:
                                                        notificationController
                                                            .notificationList![
                                                                index]
                                                            .date,
                                                    image:
                                                        notificationController
                                                            .notificationList![
                                                                index]
                                                            .image,
                                                    form: widget.form,
                                                    id: notificationController
                                                        .notificationList![
                                                            index]
                                                        .id,
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return NotificationDialog(
                                                                notificationModel:
                                                                    notificationController
                                                                            .notificationList![
                                                                        index],
                                                                type: widget
                                                                    .form);
                                                          });
                                                    },
                                                  );
                                                }),
                                          ),
                                        ),
                                      )
                                    :
                                    //: NoDataScreen(text: 'no_notification_found'.tr, type: NoDataType.NOTIFICATION) :
                                    const Expanded(
                                        child: Center(
                                            child:
                                                CupertinoActivityIndicator())),
                              ],
                            ),
                          )))
                      : _notificationWidget();
        }),
      ),
    );
  }

  Widget _notificationWidget() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 700 : 300]),
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 15,
                      width: 200,
                      color: Colors.grey[
                          Get.find<ThemeController>().darkTheme ? 700 : 300]),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(
                      height: 12,
                      width: 150,
                      color: Colors.grey[
                          Get.find<ThemeController>().darkTheme ? 700 : 300]),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Container(
                      height: 10,
                      width: 150,
                      color: Colors.grey[
                          Get.find<ThemeController>().darkTheme ? 700 : 300]),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}



//   PaginatedListView(
//     scrollController: _scrollController,
//     perPage: 10,
//     dataList: blogController.blogPostList,
//     onPaginate: (int offset) async => await blogController.getBlogPosts(offset),
//     itemView :
//     ListView.builder(
//         itemCount: blogController.blogPostList.length,
//         shrinkWrap: true,
//         physics: ClampingScrollPhysics(),
//         itemBuilder: (context,index){
//           return Padding(
//             padding:  EdgeInsets.fromLTRB(2, 2, Dimensions.PADDING_SIZE_SMALL, 2),
//             child: Container(
//                 padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                   boxShadow: [BoxShadow(
//                     color: Colors.grey[Get.find<ThemeController>().darkTheme ? 700 : 300],
//                     blurRadius: 5, spreadRadius: 1,
//                   )],
//                 ),
//                 child: PostWidget(post: blogController.blogPostList[index], isAllPost:true)),
//           );
//           //  PostView(blogController.blogPostList[index]);
//         })
// );
