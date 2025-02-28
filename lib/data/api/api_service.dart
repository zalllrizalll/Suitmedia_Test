import 'package:http/http.dart' as http;
import 'package:suitmedia_test/data/model/user_response.dart';
import 'package:suitmedia_test/static/base_url.dart';

class ApiService {
  Future<UserResponse> getListUsers(int page, int perPage) async {
    final response = await http.get(
      Uri.parse('${BaseUrl.urlServer}/api/users?page=$page&per_page=$perPage'),
    );

    if (response.statusCode == 200) {
      return userResponseFromJson(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
