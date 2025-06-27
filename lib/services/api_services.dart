import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:poketest/controller/list_controller.dart';
import 'package:poketest/model/user_model.dart';

class ApiServices extends GetConnect{
  final Dio _dio = Dio();

  Future<List<dynamic>> getUser() async{
    try {
      final response = await _dio.get('https://api.pokemontcg.io/v2/cards?page=1&pageSize=20');

      if (response.statusCode != 200) {    // if not successful
        throw Exception('Failed to load data !..');
      }

      final results = response.data['data'];

      final users = results.map((result) => Data.fromJson(result)).toList(); //create User List

      Get.find<ListController>().onDataReceived(users);

      return users;

    } catch (e) {
      throw Exception('Failed to load data !..');
    }
  }

}