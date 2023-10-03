import 'package:get/get.dart';

import '../data/api/laravel_api.dart';
import '../models/basic/chat.dart';

class ChatRepository {
  LaravelApi? _laravelApi;
  ChatRepository() {
    _laravelApi = Get.find<LaravelApi>();
  }
  Future<List<Chat>> all(idChat) async {
    return await _laravelApi!.getAllChat(idChat);
  }

  Future<Chat?> sendMessage(int idChat, String containt) async {
    return await _laravelApi!.sendChatToServer(idChat, containt);
  }

  Future<bool> veifyClint(int id) async {
    return await _laravelApi!.verifyMessageServer(id);
  }
}
