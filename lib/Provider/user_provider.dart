import 'package:calc/Utils/api_urls.dart';
import 'package:context_holder/context_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Model/user_model.dart';
import '../Utils/api_base.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    callUserDataApi(ContextHolder.currentContext);
  }
  UserModel userData = UserModel();

  Future<UserModel> callUserDataApi(context) async {
    try {
      var response = await ApiBase().getApiCall(APIConfig.users, context);
      UserModel userResponse = UserModel.fromJson(response);
      if (userResponse.total != null || userResponse.total != 0) {
        userData = userResponse;
        notifyListeners();
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
      return userResponse;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
