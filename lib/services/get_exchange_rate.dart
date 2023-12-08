import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ExchangeRate {
  static const String _baseUrl =
      'https://www.koreaexim.go.kr/site/program/financial/exchangeJSON';

  static final Dio dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  static Future<Map<String, dynamic>> getExchangeRate() async {
    try {
      Response response = await dio.request(
        '',
        queryParameters: {
          'authkey': dotenv.env['EXCHANGE_RATE_API_KEY'],
          'data': 'AP01',
        },
        options: Options(method: 'GET'),
      );
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }
}
