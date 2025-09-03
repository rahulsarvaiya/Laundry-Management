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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_type'] = this.orderType;
    data['quick_order'] = this.quickOrder;
    data['delivery_done'] = this.deliveryDone;
    data['delivery_img_url'] = this.deliveryImgUrl;
    data['order_no'] = this.orderNo;
    data['cust_name'] = this.custName;
    data['delivery_date'] = this.deliveryDate;
    data['address'] = this.address;
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    data['order_total'] = this.orderTotal;
    data['payment_state'] = this.paymentState;
    return data;
  }
}

class LineItems {
  String? itemName;
  int? qty;

  LineItems({this.itemName, this.qty});

  LineItems.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['qty'] = this.qty;
    return data;
  }
}
