import 'package:cielo_oauth/cielo_oauth.dart';
import 'package:cielo_payment_link/src/PaymentLinkEnvironment.dart';
import 'package:cielo_payment_link/src/extension/Helper.dart';
import 'package:cielo_payment_link/src/model/ErrorResponse.dart';
import 'package:cielo_payment_link/src/model/PaymentLinkError.dart';
import 'package:cielo_payment_link/src/model/PaymentLinkRequest.dart';
import 'package:cielo_payment_link/src/model/PaymentLinkResponse.dart';
import 'package:dio/dio.dart';

class PaymentLinkClient {
  Future<PaymentLinkResponse> getLink(
      {Dio dio,
      String clientId,
      String clientSecret,
      PaymentLinkEnvironment environment,
      PaymentLinkRequest request}) async {
    try {
      final OAuth oauth = OAuth(
          clientId: clientId,
          clientSecret: clientSecret,
          environment: environment == PaymentLinkEnvironment.PRODUCTION
              ? Environment.PRODUCTION
              : Environment.SANDBOX);

      AccessTokenResult responseOAuth = await oauth.getToken();

      _containsErrorOAuth(responseOAuth);

      dio.options
        ..baseUrl = _baseUrl(environment)
        ..headers['content-type'] = 'application/json'
        ..headers['authorization'] =
            'Bearer ${responseOAuth.accessTokenResponse.accessToken}';

      final Map<String, dynamic> body = {
        'Type': typeProductHelper(request.type),
        'name': request.name,
        'description': request.description,
        'price': request.price,
        'weight': request.weight,
        'ExpirationDate': request.expirationDate,
        'maxNumberOfInstallments': request.maxNumberOfInstallments,
        'quantity': request.quantity,
        'Sku': request.sku,
        'shipping': {
          'type': shippingTypeHelper(request.shipping?.type),
          'name': request.shipping?.name,
          'price': request.shipping?.price,
          'originZipCode': request.shipping?.originZipcode,
          'PickupData': {
            'PickupDelay': 0,
            'Street': request.shipping?.pickupData?.street,
            'Number': request.shipping?.pickupData?.number,
            'District': request.shipping?.pickupData?.district,
            'City': request.shipping?.pickupData?.city,
            'State': request.shipping?.pickupData?.state,
            'ZipCode': zipCodeHelper(request.shipping?.pickupData?.zipCode),
            'Complement': request.shipping?.pickupData?.complement,
            'StreetType': " ",
            'ContactPhone': request.shipping?.pickupData?.contactPhone,
            'DeliveryInstructions':
                request.shipping?.pickupData?.deliveryInstructions
          },
          'Package': {
            'Weight': request.shipping?.package?.weight,
            'Dimension': {
              'Length': request.shipping?.package?.dimension?.length,
              'Height': request.shipping?.package?.dimension?.height,
              'Width': request.shipping?.package?.dimension?.width
            }
          }
        },
        'recurrent': {
          'interval': recurrentIntervalHelper(request.recurrent?.interval),
          'endDate': request.recurrent?.endDate
        },
        'SoftDescriptor': request.softDescriptor
      };

      var response = await dio.post('v1/products', data: body);

      return PaymentLinkResponse.fromJson(response.data);
    } on DioError catch (e) {
      _getErrorPaymentLink(e);
    }
    return null;
  }
}

String _baseUrl(PaymentLinkEnvironment environment) {
  return environment == PaymentLinkEnvironment.PRODUCTION
      ? 'https://cieloecommerce.cielo.com.br/api/public/'
      : 'https://meucheckoutsandbox.braspag.com.br/api/public/';
}

dynamic _containsErrorOAuth(AccessTokenResult responseOAuth) {
  if (responseOAuth.errorResponse != null) {
    throw ErrorResponse(
        code: codeErrorHelper(responseOAuth.statusCode),
        message: responseOAuth.errorResponse.errorDescription);
  }
}

ErrorResponse _getErrorPaymentLink(DioError e) {
  PaymentLinkError paymentLinkError =
      PaymentLinkError.fromJson(e.response.data[0]);

  var message = '${e.response.statusCode} ${e.response.statusMessage}';

  throw ErrorResponse(
      code: message,
      message: '${paymentLinkError.field} ${paymentLinkError.message}');
}
