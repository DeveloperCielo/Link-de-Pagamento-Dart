import 'package:cielo_payment_link/src/PaymentLinkEnvironment.dart';
import 'package:cielo_payment_link/src/model/PaymentLinkRequest.dart';
import 'package:cielo_payment_link/src/model/PaymentLinkResponse.dart';
import 'package:cielo_payment_link/src/network/PaymentLinkClient.dart';
import 'package:dio/dio.dart';

class PaymentLink {
  String clientId;
  String clientSecret;
  PaymentLinkEnvironment environment;

  PaymentLink({this.clientId, this.clientSecret, this.environment});

  Future<PaymentLinkResponse> create({PaymentLinkRequest request}) {
    Dio dio = Dio();
    PaymentLinkClient paymentLinkClient = PaymentLinkClient();

    return paymentLinkClient.getLink(
        dio: dio,
        clientId: clientId,
        clientSecret: clientSecret,
        environment: environment,
        request: request);
  }
}
