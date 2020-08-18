import 'package:cielo_payment_link/src/model/PaymentLinkRequest.dart';

String codeErrorHelper(int code) {
  switch (code) {
    case 400:
      return "400 Bad Request";
      break;
    default:
      return code.toString();
      break;
  }
}

String shippingTypeHelper(ShippingType type) {
  switch (type) {
    case ShippingType.CORREIOS:
      return "Correios";
      break;
    case ShippingType.FIXEDAMOUNT:
      return "FixedAmount";
      break;
    case ShippingType.FREE:
      return "Free";
      break;
    case ShippingType.WITHOUTSHIPPINGPICKUP:
      return "WithoutShippingPickUp";
      break;
    case ShippingType.WITHOUTSHIPPING:
      return "WithoutShipping";
      break;
    default:
      return "Loggi";
      break;
  }
}

String typeProductHelper(TypeProduct type) {
  switch (type) {
    case TypeProduct.ASSET:
      return "Asset";
      break;
    case TypeProduct.DIGITAL:
      return "Digital";
      break;
    case TypeProduct.SERVICE:
      return "Service";
      break;
    case TypeProduct.PAYMENT:
      return "Payment";
      break;
    default:
      return "Recurrent";
      break;
  }
}

String recurrentIntervalHelper(RecurrentInterval interval) {
  if (interval != null) {
    switch (interval) {
      case RecurrentInterval.MONTHLY:
        return "Monthly";
        break;
      case RecurrentInterval.BIMONTHLY:
        return "Bimonthly";
        break;
      case RecurrentInterval.QUARTERLY:
        return "Quarterly";
        break;
      case RecurrentInterval.SEMIANNUAL:
        return "SemiAnnual";
        break;
      default:
        return "Annual";
        break;
    }
  } else {
    return null;
  }
}

dynamic zipCodeHelper(dynamic zipCode) {
  if (zipCode != null && zipCode.length == 8 && _isNumeric(zipCode)) {
    var value = zipCode.replaceAllMapped(
        RegExp(r".{5}"), (match) => "${match.group(0)}-");
    return value;
  } else {
    return zipCode;
  }
}

bool _isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
