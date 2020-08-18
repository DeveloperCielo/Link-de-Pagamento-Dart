class PaymentLinkResponse {
  String id;
  String type;
  String name;
  String description;
  bool showDescription;
  int price;
  int weight;
  Shipping shipping;
  String expirationDate;
  String createdDate;
  int maxNumberOfInstallments;
  String shortUrl;
  List<Links> links;

  PaymentLinkResponse(
      {this.id,
      this.type,
      this.name,
      this.description,
      this.showDescription,
      this.price,
      this.weight,
      this.shipping,
      this.expirationDate,
      this.createdDate,
      this.maxNumberOfInstallments,
      this.shortUrl,
      this.links});

  PaymentLinkResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    description = json['description'];
    showDescription = json['showDescription'];
    price = json['price'];
    weight = json['weight'];
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    expirationDate = json['expirationDate'];
    createdDate = json['createdDate'];
    maxNumberOfInstallments = json['maxNumberOfInstallments'];
    shortUrl = json['shortUrl'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['description'] = this.description;
    data['showDescription'] = this.showDescription;
    data['price'] = this.price;
    data['weight'] = this.weight;
    if (this.shipping != null) {
      data['shipping'] = this.shipping.toJson();
    }
    data['expirationDate'] = this.expirationDate;
    data['createdDate'] = this.createdDate;
    data['maxNumberOfInstallments'] = this.maxNumberOfInstallments;
    data['shortUrl'] = this.shortUrl;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipping {
  String type;
  Package package;
  PickupData pickupData;

  Shipping({this.type, this.package, this.pickupData});

  Shipping.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    package =
        json['package'] != null ? new Package.fromJson(json['package']) : null;
    pickupData = json['pickupData'] != null
        ? new PickupData.fromJson(json['pickupData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.package != null) {
      data['package'] = this.package.toJson();
    }
    if (this.pickupData != null) {
      data['pickupData'] = this.pickupData.toJson();
    }
    return data;
  }
}

class Package {
  int weight;
  Dimension dimension;

  Package({this.weight, this.dimension});

  Package.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    dimension = json['dimension'] != null
        ? new Dimension.fromJson(json['dimension'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weight'] = this.weight;
    if (this.dimension != null) {
      data['dimension'] = this.dimension.toJson();
    }
    return data;
  }
}

class Dimension {
  int length;
  int height;
  int width;

  Dimension({this.length, this.height, this.width});

  Dimension.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['height'] = this.height;
    data['width'] = this.width;
    return data;
  }
}

class PickupData {
  int pickupDelay;
  String streetType;
  String street;
  String number;
  String district;
  String city;
  String state;
  String zipCode;
  String complement;
  String contactPhone;
  String deliveryInstructions;

  PickupData(
      {this.pickupDelay,
      this.streetType,
      this.street,
      this.number,
      this.district,
      this.city,
      this.state,
      this.zipCode,
      this.complement,
      this.contactPhone,
      this.deliveryInstructions});

  PickupData.fromJson(Map<String, dynamic> json) {
    pickupDelay = json['pickupDelay'];
    streetType = json['streetType'];
    street = json['street'];
    number = json['number'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    complement = json['complement'];
    contactPhone = json['contactPhone'];
    deliveryInstructions = json['deliveryInstructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickupDelay'] = this.pickupDelay;
    data['streetType'] = this.streetType;
    data['street'] = this.street;
    data['number'] = this.number;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    data['complement'] = this.complement;
    data['contactPhone'] = this.contactPhone;
    data['deliveryInstructions'] = this.deliveryInstructions;
    return data;
  }
}

class Links {
  String method;
  String rel;
  String href;

  Links({this.method, this.rel, this.href});

  Links.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    rel = json['rel'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['rel'] = this.rel;
    data['href'] = this.href;
    return data;
  }
}
