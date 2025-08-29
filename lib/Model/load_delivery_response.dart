class LoadDeliveryResponse {
  String? jsonrpc;
  dynamic id;
  Result? result;

  LoadDeliveryResponse({this.jsonrpc, this.id, this.result});

  LoadDeliveryResponse.fromJson(Map<String, dynamic> json) {
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
  List<LoadResult>? result;

  Result({this.status, this.message, this.result});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <LoadResult>[];
      json['result'].forEach((v) {
        result!.add(LoadResult.fromJson(v));
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

class LoadResult {
  int? orderId;
  String? date;
  String? orderType;
  bool? quickOrder;
  String? invoiceNo;
  String? laundryOrderNo;
  int? laundryOrderId;
  String? custName;
  String? address;
  String? contact;
  String? paymentStatus;
  String? amount;
  bool isSelected=false;

  LoadResult(
      {this.orderId,
        this.date,
        this.orderType,
        this.quickOrder,
        this.invoiceNo,
        this.laundryOrderNo,
        this.laundryOrderId,
        this.custName,
        this.address,
        this.contact,
        this.paymentStatus,
        this.amount});

  LoadResult.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    date = json['date'];
    orderType = json['order_type'];
    quickOrder = json['quick_order'];
    invoiceNo = json['Invoice No'];
    laundryOrderNo = json['laundry_order_no'];
    laundryOrderId = json['laundry_order_id'];
    custName = json['cust_name'];
    address = json['address'];
    contact = json['contact'].toString();
    paymentStatus = json['payment_status'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['date'] = date;
    data['order_type'] = orderType;
    data['quick_order'] = quickOrder;
    data['Invoice No'] = invoiceNo;
    data['laundry_order_no'] = laundryOrderNo;
    data['laundry_order_id'] = laundryOrderId;
    data['cust_name'] = custName;
    data['address'] = address;
    data['contact'] = contact;
    data['payment_status'] = paymentStatus;
    data['amount'] = amount;
    return data;
  }
}
