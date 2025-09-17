class OrderDoneDoneResponse {
  String? jsonrpc;
  dynamic id;
  Result? result;

  OrderDoneDoneResponse({this.jsonrpc, this.id, this.result});

  OrderDoneDoneResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
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
  String? message;
  OrderResult? result;

  Result({this.message, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
    json['result'] != null ? new OrderResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class OrderResult {
  int? orderId;
  String? orderType;
  bool? quickOrder;
  bool? deliveryDone;
  String? deliveryImgUrl;
  String? orderNo;
  String? custName;
  String? deliveryDate;
  String? address;
  List<LineItems>? lineItems;
  String? orderTotal;
  String? paymentState;

  OrderResult(
      {this.orderId,
        this.orderType,
        this.quickOrder,
        this.deliveryDone,
        this.deliveryImgUrl,
        this.orderNo,
        this.custName,
        this.deliveryDate,
        this.address,
        this.lineItems,
        this.orderTotal,
        this.paymentState});

  OrderResult.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderType = json['order_type'];
    quickOrder = json['quick_order'];
    deliveryDone = json['delivery_done'];
    deliveryImgUrl = json['delivery_img_url'];
    orderNo = json['order_no'];
    custName = json['cust_name'];
    deliveryDate = json['delivery_date'];
    address = json['address'];
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
    orderTotal = json['order_total'];
    paymentState = json['payment_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['order_type'] = orderType;
    data['quick_order'] = quickOrder;
    data['delivery_done'] = deliveryDone;
    data['delivery_img_url'] = deliveryImgUrl;
    data['order_no'] = orderNo;
    data['cust_name'] = custName;
    data['delivery_date'] = deliveryDate;
    data['address'] = address;
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    data['order_total'] = orderTotal;
    data['payment_state'] = paymentState;
    return data;
  }
}

class LineItems {
  String? itemName;
  num? qty;

  LineItems({this.itemName, this.qty});

  LineItems.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['qty'] = qty;
    return data;
  }
}
