class DashboardResponse {
  String? jsonrpc;
  dynamic id;
  Result? result;

  DashboardResponse({this.jsonrpc, this.id, this.result});

  DashboardResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonrpc'] = jsonrpc;
    data['id'] = id;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  bool? status;
  String? message;
  DashboardResult? result;

  Result({this.status, this.message, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? DashboardResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class DashboardResult {
  int? pickupRemaining;
  String? totalAmount;
  int? totalPickup;
  List<PickupDoneData>? pickupDoneData;
  List<PickupRemainsData>? pickupRemainsData;
  int? deliveryRemaining;
  int? totalDelivery;
  List<DeliveryRemainingData>? deliveryRemainingData;
  List<DeliveryDoneData>? deliveryDoneData;
  int? totalPayment;
  int? paymentRemainCollect;
  List<PaymentRemainingData>? paymentRemainingData;
  List<Null>? collectPaymentData;
  DashboardDisplayOrder? dashboardDisplayOrder;
  List<Routes>? routes;

  DashboardResult(
      {this.pickupRemaining,
        this.totalAmount,
        this.totalPickup,
        this.pickupDoneData,
        this.pickupRemainsData,
        this.deliveryRemaining,
        this.totalDelivery,
        this.deliveryRemainingData,
        this.deliveryDoneData,
        this.totalPayment,
        this.paymentRemainCollect,
        this.paymentRemainingData,
        this.collectPaymentData,
        this.routes,
        this.dashboardDisplayOrder
      });

  DashboardResult.fromJson(Map<String, dynamic> json) {
    pickupRemaining = json['Pickup Remaining'];
    totalAmount = json['Total amount'];
    totalPickup = json['Total Pickup'];
    if (json['pickup done data'] != null) {
      pickupDoneData = <PickupDoneData>[];
      json['pickup done data'].forEach((v) {
        pickupDoneData!.add(PickupDoneData.fromJson(v));
      });
    }
    if (json['pickup remains data'] != null) {
      pickupRemainsData = <PickupRemainsData>[];
      json['pickup remains data'].forEach((v) {
        pickupRemainsData!.add(PickupRemainsData.fromJson(v));
      });
    }
    deliveryRemaining = json['Delivery Remaining'];
    totalDelivery = json['Total Delivery'];
    if (json['delivery remaining data'] != null) {
      deliveryRemainingData = <DeliveryRemainingData>[];
      json['delivery remaining data'].forEach((v) {
        deliveryRemainingData!.add(DeliveryRemainingData.fromJson(v));
      });
      // deliveryRemainingData = <Null>[];
      // json['delivery remaining data'].forEach((v) {
      //   deliveryRemainingData!.add(v);
      // });
    }
    if (json['Delivery Done data'] != null) {
      deliveryDoneData = <DeliveryDoneData>[];
      json['Delivery Done data'].forEach((v) {
        deliveryDoneData!.add(DeliveryDoneData.fromJson(v));
      });
    }
    totalPayment = json['Total payment'];
    paymentRemainCollect = json['Payment remain collect'];
    if (json['payment remaining data'] != null) {
      paymentRemainingData = <PaymentRemainingData>[];
      json['payment remaining data'].forEach((v) {
        paymentRemainingData!.add(PaymentRemainingData.fromJson(v));
      });
    }
    if (json['Collect Payment data'] != null) {
      collectPaymentData = <Null>[];
      json['Collect Payment data'].forEach((v) {
        collectPaymentData!.add(v);
      });
    }
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(Routes.fromJson(v));
      });
    }
    dashboardDisplayOrder = json['dashboard_display_order'] != null
        ? DashboardDisplayOrder.fromJson(json['dashboard_display_order'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Pickup Remaining'] = pickupRemaining;
    data['Total amount'] = totalAmount;
    data['Total Pickup'] = totalPickup;
    if (pickupDoneData != null) {
      data['pickup done data'] =
          pickupDoneData!.map((v) => v.toJson()).toList();
    }
    if (pickupRemainsData != null) {
      data['pickup remains data'] =
          pickupRemainsData!.map((v) => v.toJson()).toList();
    }
    data['Delivery Remaining'] = deliveryRemaining;
    data['Total Delivery'] = totalDelivery;
    if (deliveryRemainingData != null) {
      data['delivery remaining data'] =
          deliveryRemainingData!.map((v) => v.toJson()).toList();
    }
    if (deliveryDoneData != null) {
      data['Delivery Done data'] =
          deliveryDoneData!.map((v) => v.toJson()).toList();
    }
    data['Total payment'] = totalPayment;
    data['Payment remain collect'] = paymentRemainCollect;
    if (paymentRemainingData != null) {
      data['payment remaining data'] =
          paymentRemainingData!.map((v) => v.toJson()).toList();
    }
    if (collectPaymentData != null) {
      data['Collect Payment data'] =
          collectPaymentData!.map((v) => v).toList();
    }
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
    }
    if (dashboardDisplayOrder != null) {
      data['dashboard_display_order'] = dashboardDisplayOrder!.toJson();
    }
    return data;
  }
}

class PickupDoneData {
  String? orderNo;
  int? orderId;

  PickupDoneData({this.orderNo, this.orderId});

  PickupDoneData.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_no'] = orderNo;
    data['order_id'] = orderId;
    return data;
  }
}

class PickupRemainsData {
  String? orderNo;
  int? orderId;
  String? custName;
  String? orderAddress;
  bool? contact;

  PickupRemainsData(
      {this.orderNo,
        this.orderId,
        this.custName,
        this.orderAddress,
        this.contact});

  PickupRemainsData.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    orderId = json['order_id'];
    custName = json['cust_name'];
    orderAddress = json['order_address'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_no'] = orderNo;
    data['order_id'] = orderId;
    data['cust_name'] = custName;
    data['order_address'] = orderAddress;
    data['contact'] = contact;
    return data;
  }
}

class DeliveryDoneData {
  String? invoiceNo;
  int? orderId;
  String? laundryOrderNo;
  int? laundryOrderId;
  String? paymentStatus;

  DeliveryDoneData(
      {this.invoiceNo,
        this.orderId,
        this.laundryOrderNo,
        this.laundryOrderId,
        this.paymentStatus});

  DeliveryDoneData.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['Invoice No'];
    orderId = json['order_id'];
    laundryOrderNo = json['laundry order no'];
    laundryOrderId = json['laundry order id'];
    paymentStatus = json['payment status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Invoice No'] = invoiceNo;
    data['order_id'] = orderId;
    data['laundry order no'] = laundryOrderNo;
    data['laundry order id'] = laundryOrderId;
    data['payment status'] = paymentStatus;
    return data;
  }
}

class PaymentRemainingData {
  String? invoiceNo;
  String? paymentStatus;

  PaymentRemainingData({this.invoiceNo, this.paymentStatus});

  PaymentRemainingData.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['Invoice no'];
    paymentStatus = json['payment status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Invoice no'] = invoiceNo;
    data['payment status'] = paymentStatus;
    return data;
  }
}

class Routes {
  String? name;

  Routes({this.name});

  Routes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class DashboardDisplayOrder {
  dynamic invNo;
  String? orderNo;
  int? orderId;
  String? custName;
  String? address;
  String? orderType;
  String? contact;
  String? date;
  String? amount;

  DashboardDisplayOrder(
      {this.invNo,
        this.orderNo,
        this.orderId,
        this.custName,
        this.address,
        this.orderType,
        this.contact,
        this.date,
        this.amount,
      });

  DashboardDisplayOrder.fromJson(Map<String, dynamic> json) {
    invNo = json['inv_no'];
    orderNo = json['order_no'];
    orderId = json['order_id'];
    custName = json['cust_name'];
    address = json['address'];
    orderType = json['order_type'];
    contact = json['contact'].toString();
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['inv_no'] = invNo;
    data['order_no'] = orderNo;
    data['order_id'] = orderId;
    data['cust_name'] = custName;
    data['address'] = address;
    data['order_type'] = orderType;
    data['contact'] = contact;
    data['date'] = date;
    data['amount'] =amount;
    return data;
  }
}

class DeliveryRemainingData {
  String? invoiceNo;
  int? orderId;
  String? laundryOrderNo;
  int? laundryOrderId;
  String? customerName;
  String? deliveryAddress;
  bool? contact;
  String? paymentStatus;
  String? deliveryDate;
  String? amount;

  DeliveryRemainingData(
      {this.invoiceNo,
        this.orderId,
        this.laundryOrderNo,
        this.laundryOrderId,
        this.customerName,
        this.deliveryAddress,
        this.contact,
        this.paymentStatus,
        this.deliveryDate,
        this.amount});

  DeliveryRemainingData.fromJson(Map<String, dynamic> json) {
    invoiceNo = json['Invoice No'];
    orderId = json['order_id'];
    laundryOrderNo = json['laundry order no'];
    laundryOrderId = json['laundry order id'];
    customerName = json['Customer Name'];
    deliveryAddress = json['Delivery Address'];
    contact = json['contact'];
    paymentStatus = json['payment status'];
    deliveryDate = json['delivery_date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Invoice No'] = invoiceNo;
    data['order_id'] = orderId;
    data['laundry order no'] = laundryOrderNo;
    data['laundry order id'] = laundryOrderId;
    data['Customer Name'] = customerName;
    data['Delivery Address'] = deliveryAddress;
    data['contact'] = contact;
    data['payment status'] = paymentStatus;
    data['delivery_date'] = deliveryDate;
    data['amount'] = amount;
    return data;
  }
}

