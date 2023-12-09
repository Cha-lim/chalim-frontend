import 'package:dio/dio.dart';

class ExchangeRate {
  static final Dio dio = Dio(BaseOptions(
    baseUrl:
        'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/krw',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  static Future<num> getExchangeRate({
    required String to,
    required String amount,
  }) async {
    try {
      Response response = await dio.request(
        '/$to.json',
        options: Options(method: 'GET'),
      );
      print(response.realUri);
      print(response.data);

      final exchangedPrice = num.parse(amount) * response.data[to];
      return exchangedPrice;
    } catch (e) {
      print(e);
    }
    return 0;
  }
}
