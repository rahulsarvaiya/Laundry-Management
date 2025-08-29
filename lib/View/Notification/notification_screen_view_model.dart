import 'package:flutter/material.dart';

class NotificationScreenViewModel extends ChangeNotifier{
  late BuildContext context;
  init(BuildContext context){
    this.context = context;
    notifyListeners();
  }

  List<NotificationModel> notificationList=[
    NotificationModel(title: "New Order Assigned", description: "You have a new pickup from [Customer Name]. Tap to view details."),
    NotificationModel(title: "Order Pickup Confirmed", description: "Order #[12345] picked up successfully. Proceed to delivery."),
    NotificationModel(title: "Share Location", description: "Update your live location to help customers track your delivery."),
    NotificationModel(title: "Delivery Running Late?", description: "You’re behind schedule. Please update delivery status or ETA."),
    NotificationModel(title: "Payment Collected", description: "\$250 received for Order #[12345]."),
    NotificationModel(title: "Order Delivered", description: "Order #[12345] successfully delivered. Good job!"),
    NotificationModel(title: "Order Cancelled", description: "Order #[12345] has been cancelled by the customer."),
    NotificationModel(title: "Important Update", description: "New delivery zones have been added. Check the updated service area."),
    NotificationModel(title: "Your Shift Starts Soon", description: "Get ready! Your shift starts at 10:00 AM."),
    NotificationModel(title: "App Update Available", description: "Update your app to enjoy the latest features and improvements."),
  ];
}
class NotificationModel{
  String title;
  String description;

  NotificationModel({required this.title, required this.description});
}