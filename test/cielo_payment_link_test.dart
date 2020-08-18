import 'package:cielo_payment_link/payment_link.dart';
import 'package:test/test.dart';

main() {
  //TODO PLACE YOUR CREDENTIALS HERE
  var clientId = "your client id";
  var clientSecret = "your client secret";

  var paymentLink = PaymentLink(
      clientId: clientId,
      clientSecret: clientSecret,
      environment: PaymentLinkEnvironment.SANDBOX);

  var request = PaymentLinkRequest(
      name: 'Teste',
      type: TypeProduct.ASSET,
      description: 'Produto Teste',
      price: '10000',
      weight: 2000,
      expirationDate: '2037-06-19',
      sku: 'Sku Teste',
      maxNumberOfInstallments: '6',
      shipping: ShippingProduct(
        type: ShippingType.FREE,
        name: "Entrega Teste",
        price: '0',
      ),
      softDescriptor: 'Pedido123');

  //Example request with Loggi
  var requestLoggi = PaymentLinkRequest(
    name: "Nome do Produto",
    type: TypeProduct.ASSET,
    description: 'Descricao do Produto Teste Loggi',
    price: "10000",
    expirationDate: '2037-06-19',
    recurrent: Recurrent(interval: RecurrentInterval.MONTHLY),
    shipping: ShippingProduct(
      type: ShippingType.LOGGI,
      pickupData: PickupDataProduct(
          street: "Nome da Rua da Loja",
          number: "123",
          district: "Centro",
          city: "Osasco",
          state: "SP",
          zipCode: "09087-123",
          complement: "Loja One 12B",
          contactPhone: "1197432549",
          deliveryInstructions: "Instrucoes da entrega teste"),
      package: PackageProduct(
        weight: 200,
        dimension: DimensionProduct(
          length: 20,
          height: 20,
          width: 20,
        ),
      ),
    ),
  );

  group('Correct credentials', () {
    PaymentLinkResponse response;
    setUp(() async {
      response = await paymentLink.create(request: request);
    });

    test('return payment link response', () {
      expect(response, isA<PaymentLinkResponse>());
    });

    test('return shortUrl', () {
      expect(response.shortUrl, isNotNull);
    });
  });

  group('Correct credentials with Loggi delivery', () {
    PaymentLinkResponse response;
    setUp(() async {
      response = await paymentLink.create(request: requestLoggi);
    });

    test('return payment link response', () {
      expect(response, isA<PaymentLinkResponse>());
    });

    test('return shortUrl', () {
      expect(response.shortUrl, isNotNull);
    });
  });

  group('incorrect credentials', () {
    var paymentLinkIncorrectCredential =
        PaymentLink(clientId: '', clientSecret: '');

    test('return payment link response', () async {
      try {
        await paymentLinkIncorrectCredential.create(request: request);
      } on ErrorResponse catch (e) {
        expect(e.code, '400 Bad Request');
      }
    });

    test('Request empty', () async {
      try {
        await paymentLink.create(request: PaymentLinkRequest());
      } catch (e) {
        expect(e, isA<ErrorResponse>());
      }
    });
  });
}
