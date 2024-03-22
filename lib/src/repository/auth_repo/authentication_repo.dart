import 'package:getx_project/src/constants/constants.dart';
import 'package:getx_project/src/network/base_network.dart';

class AuthRepo extends BaseNetworkService {
  @override
  String requestUrl() {
    return ConstantAPI.loginRequest;
  }

  @override
  responseType(json) {
    return json;
  }
}
