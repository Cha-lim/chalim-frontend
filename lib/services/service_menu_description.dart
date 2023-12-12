import 'package:chalim/models/menu_description.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServiceMenuDescription {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: dotenv.env['MENU_DESCRIPTION_SERVICE_URL']!,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(minutes: 2),
    persistentConnection: true,
  ));

  static Future<MenuDescription> getMenuDescription(
    String menuName,
    String language,
  ) async {
    try {
      Response response = await dio.request(
        '/menu/$menuName/$language',
        options: Options(method: 'GET'),
      );

      print('real Uri: ${response.realUri}');

      if (response.statusCode == 200) {
        final MenuDescription menuDescription =
            MenuDescription.fromJson(response.data);

        return menuDescription;
      } else {
        print("Error during file upload: ${response.statusCode}");
        return MenuDescription(
          description: '',
          history: '',
          ingredients: '',
        );
      }
    } catch (e) {
      print("Error during file upload: $e");
      return MenuDescription(
        description: '',
        history: '',
        ingredients: '',
      );
    }
  }
}
