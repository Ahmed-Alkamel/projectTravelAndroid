import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projecttravel/app/Helper/shard_prefernces.dart';

import '../Helper/shard_prefernces.dart';
import '../models/basic/customer.dart';
import '../repository/auth_repository.dart';

class AuthUserService extends GetxService {
  GetStorage box = GetStorage();
  AuthUserRepository authUserRepository = AuthUserRepository();
  User? user;

  Future<AuthUserService> init() async {
    if (await isLogin()) {
      user = User.fromJson(box.read('user'));
    }
    return this;
  }

  Future<bool> isLogin() async {
    if (box.read('user') != null) {
      return true;
    } else {
      return false;
    }
  }

  Future logout() async {
    await box.remove('user');
    await ShardHelpar.shard.remove(User.idShardPref);
    user = null;
  }

  Future loginUser(User user) async {
    await box.write('user', user.toJson());
    this.user = user;
    await ShardHelpar.shard.setInt(User.idShardPref, user.idCus!);
    // print(this.user.toString());
  }

  Future refresh() async {
    if (await isLogin()) {
      User? userUpdate = await authUserRepository.refresh(user!.idCus!);
      if (userUpdate != null) {
        await loginUser(userUpdate);
      }
    }
  }
}
