import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExchangeRate {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.env['EXCHANGE_RATE_SERVICE_URL']!,
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
