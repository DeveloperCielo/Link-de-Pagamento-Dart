import 'package:cielo_payment_link/payment_link.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<PaymentLinkResponse>(
              initialData: PaymentLinkResponse(shortUrl: ""),
              future: getLink(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      ErrorResponse errors = snapshot.error;
                      print("--------------------------------------");
                      print('Status => ${errors.code}');
                      print("Message => ${errors.message}");
                      print("--------------------------------------");
                      return Container();
                    } else {
                      debugPrint(snapshot.data.shortUrl);
                      return Column(
                        children: <Widget>[
                          Text("Link: ${snapshot.data.shortUrl}"),
                        ],
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<PaymentLinkResponse> getLink() async {
  //TODO PLACE YOUR CREDENTIALS HERE
  final paymentLink = PaymentLink(
    clientId: "your client id",
    clientSecret: "your client secret",
    environment: PaymentLinkEnvironment.SANDBOX,
  );

  //Example request
  var request = PaymentLinkRequest(
    name: 'your product name',
    type: TypeProduct.ASSET,
    price: '200000',
    description: 'description of your product',
    maxNumberOfInstallments: '6',
    expirationDate: '2025-01-01',
    quantity: 2,
    recurrent: Recurrent(),
    shipping: ShippingProduct(
        type: ShippingType.CORREIOS,
        name: 'delivery name',
        price: '10000',
        originZipcode: '06018953'),
  );

  //Example request with Loggi
//  var request = PaymentLinkRequest(
//    name: "Nome do Produto",
//    type: TypeProduct.ASSET,
//    price: "10000",
//    shipping: ShippingProduct(
//      type: ShippingType.LOGGI,
//      pickupData: PickupDataProduct(
//          street: "Praça da Sé",
//          number: "1000",
//          district: "Sé",
//          city: "São Paulo",
//          state: "SP",
//          zipCode: "01001001",
//          complement: "Loja One 12B",
//          contactPhone: "1197432549",
//          deliveryInstructions: "delivery instructions"),
//      package: PackageProduct(
//        weight: 200,
//        dimension: DimensionProduct(
//          length: 20,
//          height: 20,
//          width: 20,
//        ),
//      ),
//    ),
//  );

  return await paymentLink.create(request: request);
}
