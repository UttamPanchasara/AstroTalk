import 'package:astro_talk/base/base_api_ds.dart';
import 'package:astro_talk/network/model/panchang_request.dart';

import '../../network/client/api_client.dart';
import '../../network/model/base_reponse.dart';
import '../../network/rest_constants.dart';
import 'entities/astrologer_data.dart';
import 'entities/location_data.dart';
import 'entities/panchang_data.dart';

class ApiDataRepository extends BaseApiDS {
  Future<BaseResponse> getDailyPanchang({
    required PanchangRequest request,
  }) async {
    var response = await callApi(ApiClient().dio().post(
          RestConstants.kPostDailyPanchang,
          data: request.toJson(),
        ));

    if (response.success ?? false) {
      response.data = PanchangData.fromJson(response.data);
    }

    return response;
  }

  Future<BaseResponse> getLocation({
    required String inputPlace,
  }) async {
    var data = {'inputPlace': inputPlace};

    var response = await callApi(ApiClient().dio().get(
          RestConstants.kGetLocation,
          queryParameters: data,
        ));

    if (response.success ?? false) {
      response.data = LocationData.fromJson(response.data);
    }

    return response;
  }

  Future<BaseResponse> getAstrologer() async {
    var response = await callApi(ApiClient().dio().get(
          RestConstants.kGetAstrologer,
        ));

    if (response.success ?? false) {
      response.data = AstrologerData.fromJson(response.data);
    }

    return response;
  }
}
