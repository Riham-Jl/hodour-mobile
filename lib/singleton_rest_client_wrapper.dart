import 'package:dio/dio.dart';
import 'package:hodor/core/app_state.dart';
import '../rest_client.dart';

import 'core/constants/global_constants.dart';

class SingletonRestClient {
  late RestClient restClient;

  static SingletonRestClient? _instance;

  static SingletonRestClient get instance {
    return _instance ??= SingletonRestClient._(RestClient(createDio()));
  }

  SingletonRestClient._(this.restClient);

  static Dio createDio({String? token}) {
    var dio = Dio();
    dio.options.headers["Accept"] = "application/json";
    // providing app version and platform in headers

      dio.options.headers["App-Version"] = AppState.appVersion;

   dio.options.headers["App-Platform"] = AppState.appPlatform;
   dio.interceptors.add(HeaderInterceptor());
    dio.interceptors.add(LogInterceptor(
        request: true, requestBody: true, responseBody: true, error: true));

    // dio.interceptors.add(InterceptorsWrapper(
    //   onError: (e, handler) {
    //     if (e.type == DioErrorType.response ){
    //       print("invalid credentials 11");
    //       handler.resolve(e.response);
    //     }
    //   },
    // )
    // ) ;

    dio.options.followRedirects = false;
    dio.options.contentType = "application/json";
    dio.options.validateStatus = (status) {
      if (token != null) {
        return status == 200;
      }
      return [200, 401].contains(status);
    };
    if (token != null) dio.options.headers["Authorization"] = 'Bearer $token';
    return dio;
  }
}

class HeaderInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final headers = response.headers;
    // Access individual header values
    AppState.appVersionStatus = headers.value('App-Version');
    super.onResponse(response, handler);
  }
}
