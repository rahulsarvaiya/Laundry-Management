class OrderResponseModel {
  String? jsonrpc;
  dynamic id;
  Result? result;

  OrderResponseModel({this.jsonrpc, this.id, this.result});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<OrderDataResult>? result;

  Result({this.status, this.message, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <OrderDataResult>[];
      json['result'].forEach((v) {
        result!.add(OrderDataResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDataResult {
  int? orderId;
  String? date;
  String? orderType;
  bool? quickOrder;
  String? invNo;
  String? orderNo;
  String? custName;
  String? address;
  String? contact;
  dynamic paymentState;
  String? amount;
  String? paymentStatus;

  OrderDataResult(
      {this.orderId,
        this.date,
        this.orderType,
        this.quickOrder,
        this.invNo,
        this.orderNo,
        this.custName,
        this.address,
        this.contact,
        this.paymentState,
        this.amount,
        this.paymentStatus});

  OrderDataResult.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    date = json['date'];
    orderType = json['order_type'];
    quickOrder = json['quick_order'];
    invNo = json['inv_no'];
    orderNo = json['order_no'];
    custName = json['cust_name'];
    address = json['address'];
    contact = json['contact'].toString();
    paymentState = json['payment_state'];
    amount = json['amount'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['date'] = date;
    data['order_type'] = orderType;
    data['quick_order'] = quickOrder;
    data['inv_no'] = invNo;
    data['order_no'] = orderNo;
    data['cust_name'] = custName;
    data['address'] = address;
    data['contact'] = contact;
    data['payment_state'] = paymentState;
    data['amount'] = amount;
    data['payment_status'] = paymentStatus;
    return data;
  }
}
