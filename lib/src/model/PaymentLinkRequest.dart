class PaymentLinkRequest {
  TypeProduct type;
  String name;
  String description;
  bool showDescription;
  String price;
  int weight;
  ShippingProduct shipping;
  Recurrent recurrent;
  String sku;
  String softDescriptor;
  String expirationDate;
  String maxNumberOfInstallments;
  int quantity;

  PaymentLinkRequest(
      {this.type,
      this.name,
      this.description,
      this.showDescription,
      this.price,
      this.weight,
      this.shipping,
      this.recurrent,
      this.sku,
      this.softDescriptor,
      this.expirationDate,
      this.maxNumberOfInstallments,
      this.quantity});

  PaymentLinkRequest.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    name = json['Name'];
    description = json['Description'];
    showDescription = json['ShowDescription'];
    price = json['Price'];
    weight = json['Weight'];
    shipping = json['Shipping'] != null
        ? new ShippingProduct.fromJson(json['Shipping'])
        : null;
    recurrent = json['Recurrent'] != null
        ? new Recurrent.fromJson(json['Recurrent'])
        : null;
    sku = json['Sku'];
    softDescriptor = json['SoftDescriptor'];
    expirationDate = json['ExpirationDate'];
    maxNumberOfInstallments = json['MaxNumberOfInstallments'];
    quantity = json['Quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['ShowDescription'] = this.showDescription;
    data['Price'] = this.price;
    data['Weight'] = this.weight;
    if (this.shipping != null) {
      data['Shipping'] = this.shipping.toJson();
    }
    if (this.recurrent != null) {
      data['Recurrent'] = this.recurrent.toJson();
    }
    data['Sku'] = this.sku;
    data['SoftDescriptor'] = this.softDescriptor;
    data['ExpirationDate'] = this.expirationDate;
    data['MaxNumberOfInstallments'] = this.maxNumberOfInstallments;
    data['Quantity'] = this.quantity;
    return data;
  }
}

class ShippingProduct {
  ShippingType type;
  String name;
  String price;
  String originZipcode;
  PickupDataProduct pickupData;
  PackageProduct package;

  ShippingProduct(
      {this.type,
      this.name,
      this.price,
      this.originZipcode,
      this.pickupData,
      this.package});

  ShippingProduct.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    name = json['Name'];
    price = json['Price'];
    originZipcode = json['OriginZipcode'];
    pickupData = json['PickupData'];
    package = json['Package'] != null
        ? new PackageProduct.fromJson(json['Package'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Name'] = this.name;
    data['Price'] = this.price;
    data['OriginZipcode'] = this.originZipcode;
    if (this.pickupData != null) {
      data['PickupData'] = this.pickupData.toJson();
    }
    if (this.package != null) {
      data['Package'] = this.package.toJson();
    }
    return data;
  }
}

class PickupDataProduct {
  String street;
  String number;
  String district;
  String city;
  String state;
  String zipCode;
  String complement;
  String contactPhone;
  String deliveryInstructions;

  PickupDataProduct(
      {this.street,
      this.number,
      this.district,
      this.city,
      this.state,
      this.zipCode,
      this.complement,
      this.contactPhone,
      this.deliveryInstructions});

  PickupDataProduct.fromJson(Map<String, dynamic> json) {
    street = json['Street'];
    number = json['Number'];
    district = json['District'];
    city = json['City'];
    state = json['State'];
    zipCode = json['ZipCode'];
    complement = json['Complement'];
    contactPhone = json['ContactPhone'];
    deliveryInstructions = json['DeliveryInstructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Street'] = this.street;
    data['Number'] = this.number;
    data['District'] = this.district;
    data['City'] = this.city;
    data['State'] = this.state;
    data['ZipCode'] = this.zipCode;
    data['Complement'] = this.complement;
    data['ContactPhone'] = this.contactPhone;
    data['DeliveryInstructions'] = this.deliveryInstructions;
    return data;
  }
}

class PackageProduct {
  int weight;
  DimensionProduct dimension;

  PackageProduct({this.weight, this.dimension});

  PackageProduct.fromJson(Map<String, dynamic> json) {
    weight = json['Weight'];
    dimension = json['Dimension'] != null
        ? new DimensionProduct.fromJson(json['Dimension'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Weight'] = this.weight;
    if (this.dimension != null) {
      data['Dimension'] = this.dimension.toJson();
    }
    return data;
  }
}

class DimensionProduct {
  int length;
  int height;
  int width;

  DimensionProduct({this.length, this.height, this.width});

  DimensionProduct.fromJson(Map<String, dynamic> json) {
    length = json['Length'];
    height = json['Height'];
    width = json['Width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Length'] = this.length;
    data['Height'] = this.height;
    data['Width'] = this.width;
    return data;
  }
}

class Recurrent {
  RecurrentInterval interval;
  String endDate;

  Recurrent({this.interval, this.endDate});

  Recurrent.fromJson(Map<String, dynamic> json) {
    interval = json['Interval'];
    endDate = json['EndDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Interval'] = this.interval;
    data['EndDate'] = this.endDate;
    return data;
  }
}

enum TypeProduct { ASSET, DIGITAL, SERVICE, PAYMENT, RECURRING_PAYMENT }

enum ShippingType {
  CORREIOS,
  FIXEDAMOUNT,
  FREE,
  WITHOUTSHIPPINGPICKUP,
  WITHOUTSHIPPING,
  LOGGI
}

enum RecurrentInterval { MONTHLY, BIMONTHLY, QUARTERLY, SEMIANNUAL, ANNUAL }
