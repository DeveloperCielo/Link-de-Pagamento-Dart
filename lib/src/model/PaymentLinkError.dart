class PaymentLinkError {
  String field;
  String message;

  PaymentLinkError({this.field, this.message});

  PaymentLinkError.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field'] = this.field;
    data['message'] = this.message;
    return data;
  }
}
