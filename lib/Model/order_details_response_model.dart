class OrderDetailsResponseModel {
  String? jsonrpc;
  dynamic id;
  OrderDetailResult? result;

  OrderDetailsResponseModel({this.jsonrpc, this.id, this.result});

  OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
    json['result'] != null ? OrderDetailResult.fromJson(json['result']) : null;
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

class OrderDetailResult {
  String? orderId;
  String? orderType;
  bool? quickOrder;
  String? orderNo;
  String? custName;
  String? time;
  String? address;
  List<LineItems>? lineItems;
  int? orderTotal;
  dynamic paymentState;

  OrderDetailResult(
      {this.orderId,
        this.orderType,
        this.quickOrder,
        this.orderNo,
        this.custName,
        this.time,
        this.address,
        this.lineItems,
        this.orderTotal,
        this.paymentState});

  OrderDetailResult.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderType = json['order_type'];
    quickOrder = json['quick_order'];
    orderNo = json['order_no'];
    custName = json['cust_name'];
    time = json['time'];
    address = json['address'].toString();
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
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
    data['order_no'] = orderNo;
    data['cust_name'] = custName;
    data['time'] = time;
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
  int? qty;

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
