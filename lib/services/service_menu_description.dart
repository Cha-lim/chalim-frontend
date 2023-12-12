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
      print('menuName: $menuName, language: $language');
      Response response = await dio.request(
        '/menuInfo/details',
        queryParameters: {
          'menuName': menuName,
          'language': language,
        },
        options: Options(method: 'GET'),
      );

      print('real Uri: ${response.realUri}');

      if (response.statusCode == 200) {
        final MenuDescription menuDescription =
            MenuDescription.fromJson(response.data);

        print('menu description: ${menuDescription.description}}');
        print('menu history: ${menuDescription.history}}');
        print('menu ingredients: ${menuDescription.ingredients}}');

        return menuDescription;
      } else {
        print("Error during file upload: ${response.statusCode}");
        return MenuDescription(
          description: '',
          history: '',
          ingredients: '',
        );
      }

      // return MenuDescription(
      //   description: sanitizeString(
      //       "\"소곱창전골\" is a popular Korean dish that is perfect for those who enjoy spicy and hearty flavors. It is a type of hot pot that combines various ingredients such as beef tripe (곱창), intestines (생선), and vegetables in a rich and spicy broth."),
      //   history: sanitizeString(
      //       "This dish has a long history in Korean cuisine and is considered a favorite among meat lovers. It is believed to have originated in the Korean countryside, where ingredients like tripe and intestines were easily accessible and often used in cooking."),
      //   ingredients: sanitizeString(
      //       "The main ingredients of \"소곱창전골\" include beef tripe, intestines, various vegetables such as cabbage, mushrooms, and onions, and a spicy broth made from gochujang (Korean red chili paste) and other seasonings. It is also common to add tofu, rice cakes, and noodles for added texture and flavor."),
      // );
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
