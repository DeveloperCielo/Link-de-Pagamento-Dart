# Link de Pagamentos

O SDK permite ao lojista criar links de pagamentos. Seu principal objetivo é permitir que lojas possam criar links, através do seu próprio aplicativo e compartilhar com seus clientes, sem a necessidade de acessar o Backoffice. O SDK foi feito em dart, podendo assim ser ultilizado na linguagem Flutter.

## Principais recursos

* [x] Autenticação no oAuth
* [x] Criação do link de pagamento
  * [x] De todos os tipos de produtos
  * [x] Com todos os tipos de entrega (incluindo entrega ultilizando Loggi)
  * [x] Com recorrência
  
# Modo de Uso 

 ## Instalação
- Será necessário adicionar a seguinte dependência ao `pubspec.yaml` do seu app:

```yaml
    dependencies:
      cielo_payment_link: ^1.0.2
```

 ## Utilização
- Para iniciar com o SDK será necessário importar o pacote abaixo:

```dart
import 'package:cielo_payment_link/payment_link.dart';
```

Será necessário informar *Client Id*, *Client Secret* e o *Ambiente*:

Instancie `PaymentLink` como exemplo abaixo:

```dart
var paymentLink = PaymentLink(
        clientId: 'your client id',
        clientSecret: 'your client secret',
        environment: PaymentLinkEnvironment.SANDBOX);
```



***PaymentLink:**

| Parâmetro                | Descrição                                                | Tipo                    | Obrigatório |
| :------------------------| :------------------------------------------------------- | :---------------------- | :---------- |
| ClientID     |  Identificador chave fornecido pela CIELO.                           | String                  | SIM         |
| ClientSecret | Chave que valida o ClientID. Fornecida pela Cielo junto ao ClientID. | String                  | SIM         |
| Environment  | Ambiente de Desenvolvimento.                                         | PaymentLinkEnvironment  |NÃO. Caso não seja informado o SDK ultilizará **SANDBOX**.|

- Logo ápos instanciar o *PaymentLink*, instancie `PaymentLinkRequest` como exemplo abaixo:

```dart
  var request = PaymentLinkRequest(
      name: 'your product name',
      type: TypeProduct.ASSET,
      price: '200000',
      description: 'description of your product',
      maxNumberOfInstallments: '10',
      expirationDate: '2025-01-01',
      quantity: 2,
      shipping: ShippingProduct(
          type: ShippingType.CORREIOS,
          name: 'delivery name',
          price: '10000',
          originZipcode: '06018953'));
```



***PaymentLinkRequest:**

| Parâmetro                | Descrição                                                                 | Tipo            | Obrigatório |
| :------------------------| :------------------------------------------------------------------------ | :-------------: | :---------: |
| Name                     |  Nome do produto.                                                         | String          | SIM         |
| Type                     | Tipo de produto qual a venda será realizada através do link de pagamento. | TypeProduct     |  SIM        |
| Price                    | Valor do produto em centavos.                                             | String          | SIM         |
| Description              | Descrição do produto que será exibida na tela de Checkout.                | String          | NÃO. Obrigatório apenas se showDescription for true. |
| MaxNumberOfInstallments  | Número máximo de parcelas que o comprador pode selecionar na tela de Checkout. Se não informado será utilizada as configurações da loja no Checkout Cielo.                                                                                        | String          |  NÃO        |
| ExpirationDate           | Data de expiração do link. Caso uma data seja informada, o link se torna indisponível na data informada. Se nenhuma data for informada, o link não expira. Obs: YYYY-MM-DD.                                                                           | String          | NÃO         |  
| Quantity                 | Quantidade de produtos.                                                   | int             | NÃO         |
| ShowDescription          | Exibir ou não descrição do produto no Checkout Cielo.                     | bool            | NÃO         |
| Weight                   | Peso do produto em gramas.                                                | int             | NÃO         |
| Shipping                 | Nó contendo informações de entrega do produto.                            | ShippingProduct | SIM         |
| Recurrent                | Nó contendo informações caso o tipo do produto for Recorrência.           | Recurrent       | NÃO. Obrigatório apenas para cobrança do tipo recorrência. |



***ShippingProduct:** 

| Parâmetro       | Descrição                                                                     | Tipo    | Obrigatório                                               |
| :---------------| :---------------------------------------------------------------------------- | :-----: | :-------------------------------------------------------: |
| Type            | Tipo de entrega do produto.                                                   | ShippingType  | SIM                                                 |
| Name            | Nome do frete.                                                                | String  |  NÃO. Obrigatório para frete tipo “FixedAmount”.          |
| Price           | O valor do frete.                                                             | String  | NÃO. Obrigatório para frete tipo “FixedAmount”.           |
| OriginZipcode   | Cep de origem da encomenda.                                     | String  | NÃO. Obrigatório para frete tipo “Correios”. Deve conter apenas números.|
| PickUpData      | Nó contendo endereço de retirada do produto caso o tipo de entrega for Loggi. | PickUpDataProduct  |  NÃO. Obrigatório para frete do tipo Loggi.    |
| Package         | Nó contendo informações do pacote, caso o tipo de entrega for Loggi.          | PackageProduct  | NÃO. Obrigatório para frete do tipo Loggi.        |  



***Recurrent:**

| Parâmetro       | Descrição                                              | Tipo               | Obrigatório                              |
| :-------------- | :----------------------------------------------------- | :----------------: | :--------------------------------------: |
| Interval        | Intervalo de cobrança da recorrência.                  | RecurrentInterval  | NÃO. Obrigatório no caso de recorrência. |
| EndDate         | Data final de cobrança da recorrência. Obs: YYYY-MM-DD.| String             |  NÃO                                     |


- Após instanciar o *PaymentLink* e *PaymentLinkRequest* podemos efetuar a chamada do SDK, para receber um `PaymentLinkResponse`: 

```dart
  PaymentLinkResponse response = await paymentLink.create(request: request);
  return response;
```

## Ultilização com Loggi

- Caso a entrega for do tipo **Loggi** a instancia de `PaymentLinkRequest`, deverá conter informações de dados da coleta e do pacote que será entregue (`PickupDataProduct` e `PackageProduct`) assim como no exemplo abaixo:

```dart
  var request = PaymentLinkRequest(
    name: 'your product name',
    type: TypeProduct.ASSET,
    price: '200000',
    description: 'description of your product',
    maxNumberOfInstallments: '10',
    expirationDate: '2025-01-01',
    quantity: 2,
    shipping: ShippingProduct(
      type: ShippingType.LOGGI,
      pickupData: PickupDataProduct(
          street: 'Praça da Sé',
          number: '123',
          district: 'Sé',
          city: 'São Paulo',
          state: 'SP',
          zipCode: '01001001',
          complement: 'Loja One 12B',
          contactPhone: '1198765543',
          deliveryInstructions: 'delivery instructions'),
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
```



***PickupDataProduct:**

| Parâmetro                | Descrição                                  | Tipo    | Obrigatório |
| :------------------------| :----------------------------------------- | :-----: | :---------: |
| Street                   |  Endereço de retirada do produto.          | String  | SIM         |
| Number                   |Número do endereço  de retirada do produto. | String  |  SIM        |
| District                 | Bairro do endereço  de retirada do produto.| String  | SIM         |
| City                     | Cidade do endereço de retirada do produto. | String  | SIM         |
| State                    | Estado de endereço de retirada do produto. | String  |  SIM        |
| ZipCode                  | CEP de endereço de retirada do produto.    | String  | SIM         |  
| Complement               |    Complemento do endereço de retirada.    | String  | SIM         |
| ContactPhone             |    Telefone de contato.                    | String  | SIM         |
| DeliveryInstructions     |    Instruções de entrega.                  | String  |  SIM        |



***PackageProduct:**

| Parâmetro  | Descrição                                               | Tipo              | Obrigatório |
| :----------| :------------------------------------------------------ | :---------------: | :---------: |
| Weight     |  Campo para informar o peso do pacote (dado em gramas). | int               | SIM         |
| Dimension  | Dimensão do pacote.                                     | DimensionProduct  | SIM         |



***DimensionProduct:**

| Parâmetro   | Descrição                                                         | Tipo | Obrigatório |
| :---------- | :---------------------------------------------------------------- | :--: | :---------: |
| Length      | Campo para informar o comprimento do pacote (dado em centimetros).| int  | SIM         |    
| Height      | Campo para informar altura do pacote (dado em centimetros).       | int  | SIM         |
| Width       | Campo para informar a largura do pacote (dado em centimetros).    | int  | SIM         | 

- Após instanciar o *PaymentLink* e *PaymentLinkRequest* podemos efetuar a chamada do SDK, para receber um `PaymentLinkResponse`: 

```dart
  PaymentLinkResponse response = await paymentLink.create(request: request);
  return response;
```

- Caso ocorrá algum erro, temos o `ErrorResponse`.
No exemplo abaixo foi capturado usando um FutureBuilder ou StreamBuilder:

```dart
...
if (snapshot.hasError) {
                      ErrorResponse errors = snapshot.error;
                      print('--------------------------------------');
                      print('Status Code => ${errors.code}');
                      print('Message => ${errors.message}');
                      print('--------------------------------------');
                      return Container();
                    }
...
```

* **OBS: O SDK permite o lojista fazer a criação do link de pagamento, podendo ser usado o serviço Loggi. A parte de solicitação de motoboy e acompanhamento do delivery, deverá ser feito a partir do Backoffice.** 

## Manual

Para mais informações sobre a integração com a API de Link de Pagamentos, vide o manual em: [Link de Pagamento](https://developercielo.github.io/manual/linkdepagamentos5)