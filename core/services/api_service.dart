import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:champ_app/core/service_injector/service_injector.dart';
import 'package:champ_app/core/services/store_service.dart';
import 'package:champ_app/shared/models/api_model.dart';
import 'package:champ_app/shared/models/login_success_model.dart';
import 'package:champ_app/shared/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class ApiService {
  const ApiService(this.storeService);

  final StoreService storeService;

  Future<Map<String, String>> httpHeaders(
      [Map<String, String>? customHeaders]) async {
    final Map<String, String> h = customHeaders ?? <String, String>{};

    if (h[HttpHeaders.contentTypeHeader] == null) {
      h[HttpHeaders.contentTypeHeader] = 'application/json; charset=UTF-8';
    }

    final LoginSuccessPayload auth = await si.authService!.getAuthData();

    if (auth != null && auth.token!.isNotEmpty) {
      h[HttpHeaders.authorizationHeader] = 'Bearer ${auth.token}';
    }

    return h;
  }

  dynamic _jsonEncodeDateHandler(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }

    return item;
  }

  String httpBody(dynamic body) {
    return jsonEncode(body, toEncodable: _jsonEncodeDateHandler);
  }

  String _toId(String text) {
    return text;
  }

  Future<ApiResponse<T>> postApiNoHeader<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final request = IOClient(ioc);

      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      // print('URL___ $uri');

      Map<String, String> headers = {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

      final http.Response res = await request
          .post(
            uri,
            headers: headers,
            body: httpBody(body),
          )
          .timeout(const Duration(seconds: 20));
      print('URL___ $uri');
      print('body___ ${httpBody(body)}');

      final dynamic data = json.decode(res.body);
      print('data___ $data');
      print('status: ' + res.statusCode.toString());

      /// Check if call is successful
      // if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
      //   apiResponse.data = transform(data);
      // } else {
      //   //apiResponse.error = true;
      //   apiResponse.data = transform(data);
      //   apiResponse.message =
      //       (data['message'] ?? 'Error encountered').toString();
      // }

      if (res.statusCode == 200 || res.statusCode == 201) {
        //hnadles already registered email
        if (data["success"] == true &&
            data["message"] != null &&
            data["message"].length > 0) {
          apiResponse.success = true;
          // print('LOGIN CHECK 0');

          String msg = "";
          if (data["message"] is List) {
            for (int i = 0; i < data["message"].length; i++) {
              msg += data["message"][i].toString() + "\n";
            }
          } else {
            msg = data["message"];
          }
          apiResponse.message = msg;
          apiResponse.data = transform(data);

          return apiResponse;
        } else if (data["success"] == true &&
            data["message"] == null &&
            data["data"] != null) {
          print('data2___ $data');
          apiResponse.success = true;
          if (data["data"] is String) {
            apiResponse.token = data["data"];
            apiResponse.data = transform(data);
          } else {
            apiResponse.data = transform(data["data"]);
          }
          apiResponse.message = (data['message'] ?? '').toString();

          return apiResponse;
        } else {
          apiResponse.success = false;
          apiResponse.message =
              (data['message'] ?? 'Error encountered').toString();
        }
        // print('LOGIN CHECK 1');

        // if (data['status'] != null && data['status'] == "unverified") {
        // print('LOGIN CHECK 2');

        // apiResponse.patient = transform(data['patient']);
        // print('LOGIN CHECK 2 aaa ${data['patient']}');
        // debugPrint('LOGIN CHECK 2 aaa ${json.encode(data['patient']['patient_medical_history'])}');

        // debugPrint('LOGIN CHECK 200 ${transform(data)}');
        // apiResponse.token = transform(data);
        // print('LOGIN CHECK 2 bbb');

        // apiResponse.status =
        //     (data['status'] ?? 'Error encountered').toString();
        // print('LOGIN CHECK 2 ccc');

        // apiResponse.userRole =
        //     (data['userRole'] ?? 'Error encountered').toString();
        // print('LOGIN CHECK 2 ddd');

        // } else {
        // print('LOGIN CHECK 3');

        // apiResponse.data = transform(data);
        // apiResponse.status =
        //     (data['status'] ?? 'Error encountered').toString();
        // apiResponse.userRole =
        //     (data['userRole'] ?? 'Error encountered').toString();
        // }
      } else {
        // print('LOGIN CHECK 4');

        apiResponse.success = false;
        if (data['data'] != null) {
          apiResponse.data = transform(data);
          apiResponse.message =
              (data['message'] ?? 'Error encountered').toString();
        }
        if (data['message'] != null) {
          apiResponse.message =
              (data['message'] ?? 'Error encountered').toString();
        }
      }
    } on TimeoutException {
      apiResponse.success = false;

      // debugPrint(e.toString());
      apiResponse.message =
          ('Network Error. The operation couldnt be completed. Check your internet settings')
              .toString();
    } catch (e) {
      apiResponse.success = false;
      print('fortune --' + e.toString());
      // debugPrint(e.toString());
      apiResponse.message = ('Error encountered').toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> postApiAdd<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body["data"] as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      // print("before anything");

      // Map<String, String> headers = {
      //   HttpHeaders.acceptHeader: 'application/json',
      //   HttpHeaders.contentTypeHeader: 'application/json',
      // };

      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final request = IOClient(ioc);

      final Map<String, String> headers = await httpHeaders();
      debugPrint("headers $headers");

      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      print("before resss");

      final http.Response res = await request
          .post(
            uri,
            headers: headers,
            body: httpBody(body),
          )
          .timeout(const Duration(seconds: 60));
      print('URL___ $uri');
      debugPrint('body___ ${httpBody(body)}');

      final dynamic data = json.decode(res.body);

      print("xxxxx: " + res.statusCode.toString());
      print("cccnnnvv: " + res.body.toString());

      /// Check if call is successful
      // if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
      //   apiResponse.data = transform(data);
      // } else {
      //   //apiResponse.error = true;
      //   apiResponse.data = transform(data);
      //   apiResponse.message =
      //       (data['message'] ?? 'Error encountered').toString();
      // }
      if (data["data"] != null && data['success'] == true) {
        apiResponse.success = true;
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();

        apiResponse.data = transform(data);
      } else {
        apiResponse.success = false;
        apiResponse.data = null;
        if (data['errors'] != null) {
          String errorMsg = "";
          for (int i = 0; i < data.length; i++) {
            errorMsg += data[i].toString() + "\n";
          }
          apiResponse.message = errorMsg;
        } else {
          apiResponse.message =
              (data['message'] ?? 'Error encountered').toString();
        }
      }
    } on TimeoutException {
      apiResponse.success = false;
      // debugPrint(e.toString());
      apiResponse.message =
          ("Network Error. The operation couldn't be completed. Check your internet settings")
              .toString();
    } catch (e) {
      apiResponse.success = false;
      print('gggg' + e.toString());
      // debugPrint(e.toString());
      apiResponse.message = ('Error encountered').toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> patchApi<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body["data"] as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      // print("before anything");

      // Map<String, String> headers = {
      //   HttpHeaders.acceptHeader: 'application/json',
      //   HttpHeaders.contentTypeHeader: 'application/json',
      // };
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final request = IOClient(ioc);

      final Map<String, String> headers = await httpHeaders();
      debugPrint("headers $headers");

      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      print("before resss");

      final http.Response res = await request
          .patch(
            uri,
            headers: headers,
            body: httpBody(body),
          )
          .timeout(const Duration(seconds: 60));
      print('URL___ $uri');
      debugPrint('body___ ${httpBody(body)}');

      final dynamic data = json.decode(res.body);

      print("xxxxx: " + res.statusCode.toString());
      print("cccnnnvv: " + res.body.toString());

      /// Check if call is successful
      // if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
      //   apiResponse.data = transform(data);
      // } else {
      //   //apiResponse.error = true;
      //   apiResponse.data = transform(data);
      //   apiResponse.message =
      //       (data['message'] ?? 'Error encountered').toString();
      // }
      if (data["data"] != null && data['success'] == true) {
        apiResponse.success = true;
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();

        apiResponse.data = transform(data);
      } else {
        apiResponse.success = false;
        apiResponse.data = null;
        if (data['errors'] != null) {
          String errorMsg = "";
          for (int i = 0; i < data.length; i++) {
            errorMsg += data[i].toString() + "\n";
          }
          apiResponse.message = errorMsg;
        } else {
          apiResponse.message =
              (data['message'] ?? 'Error encountered').toString();
        }
      }
    } on TimeoutException {
      apiResponse.success = false;
      // debugPrint(e.toString());
      apiResponse.message =
          ("Network Error. The operation couldn't be completed. Check your internet settings")
              .toString();
    } catch (e) {
      apiResponse.success = false;
      print('gggg' + e.toString());
      // debugPrint(e.toString());
      apiResponse.message = ('Error encountered').toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> postApi<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final request = IOClient(ioc);

    try {
      final Map<String, String> headers = await httpHeaders(customHeaders);
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      final http.Response res = await request.post(
        uri,
        headers: headers,
        body: httpBody(body),
      );
      print('URL___ $uri');
      // print('body___ ${httpBody(body)}');

      // print(uri);
      // print(headers);
      // print(body);
      // print("res body : ${res.toString()}");

      final dynamic data = json.decode(res.body);
      // print('ResponesData---- $data');
      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.success = true;
        apiResponse.data = transform(data);
      } else {
        apiResponse.success = false;
        // apiResponse.data = transform(data);
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } catch (e) {
      debugPrint(e.toString());
      apiResponse.success = false;
      apiResponse.message = ('Error encountered').toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> postApiThree<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? customHeaders,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https("tmoni-staging-server.herokuapp.com",
              "api/resolve-account-name", params)
          : Uri.http("tmoni-staging-server.herokuapp.com",
              "api/resolve-account-name", params);

      print("URI__ $url");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "test126",
      };
      print("Header for Get3__ $headers");
      final http.Response res = await http
          .post(
            uri,
            headers: headers,
            body: httpBody(body),
          )
          .timeout(const Duration(seconds: 30));
      // print('URL___ $uri');
      // print('body___ ${httpBody(body)}');

      // print(uri);
      // print(headers);
      // print(body);
      // print("res body : ${res.toString()}");

      final dynamic data = json.decode(res.body);
      // print('ResponesData---- $data');
      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.success = true;
        apiResponse.data = transform(data);
      } else {
        apiResponse.success = false;
        // apiResponse.data = transform(data);
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } catch (e) {
      debugPrint(e.toString());
      apiResponse.success = false;
      apiResponse.message = ('Error encountered').toString();
    }

    return apiResponse;
  }

  Stream<ApiResponse<T>> getApiStoreData<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? params,
  }) {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, String>{};

    final Uri uri = AppConfig.apiProtocol.startsWith('https')
        ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
        : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

    return storeService
        .getApiData(
          id: _toId(uri.toString()),
          uri: uri,
          headers: httpHeaders(),
          transform: (dynamic data, [String? errMsg]) {
            final ApiResponse<T> res = ApiResponse<T>();
            // print('URL___$uri');
            // print('res---$res');
            if (errMsg != null) {
              res.success = false;
              res.message = errMsg;
            } else {
              res.data = transform!(data);
            }

            return res;
          },
        )
        .map((ApiResponse<T> event) => event);
  }

  Future<ApiResponse<T>> getApi<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, String>{};

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final request = IOClient(ioc);

      final Map<String, String> headers = await httpHeaders();
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      print("URI__ $uri");
      print("Header for Get__ $headers");

      final http.Response res = await request
          .get(
            uri,
            headers: headers,
          )
          .timeout(const Duration(seconds: 30));

      print("RES ${res.statusCode}");
      print('get body' + res.body);
      final dynamic data = json.decode(res.body);
      print("data $data");

      /// This is applicable when server sends unique error codes.
      // if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
      //   apiResponse.data = transform(data);
      // } else {
      //   // print('Api error at $uri and $data');
      //
      //   apiResponse.error = true;
      //   apiResponse.message =
      //       (data['message'] ?? 'Error encountered').toString();
      // }

      if ((data != null && data['success'] == true)) {
        apiResponse.success = true;
        apiResponse.message = (data['message'] ?? 'Succesful').toString();
        apiResponse.data = transform(data);
      } else {
        apiResponse.success = false;
        apiResponse.data = transform(data);
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } on TimeoutException catch (e) {
      apiResponse.success = false;
      debugPrint(e.toString());
      apiResponse.message =
          ('Network Error. The operation couldnt be completed. Check your internet settings')
              .toString();
    } catch (e) {
      apiResponse.success = false;
      apiResponse.message =
          ('Network Error. The operation couldnt be completed.').toString();
      debugPrint(e.toString());
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> getApiThree<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, String>{};

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      // final ioc = HttpClient();
      // ioc.badCertificateCallback =
      //     (X509Certificate cert, String host, int port) => true;
      // final request = IOClient(ioc);

      // final Map<String, String> headers = await httpHeaders();
      // final Uri uri = AppConfig.apiProtocol.startsWith('https')
      //     ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
      //     : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(
              "tmoni-staging-server.herokuapp.com", "api/bank-list", params)
          : Uri.http(
              "tmoni-staging-server.herokuapp.com", "api/bank-list", params);

      print("URI__ $url");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "test126",
      };
      print("Header for Get3__ $headers");
      final http.Response res = await http
          .get(
            uri,
            headers: headers,
          )
          .timeout(const Duration(seconds: 30));

      print("RES ${res.statusCode}");
      print('get body' + res.body);
      final dynamic data = json.decode(res.body);
      print("data $data");

      /// This is applicable when server sends unique error codes.
      // if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
      //   apiResponse.data = transform(data);
      // } else {
      //   // print('Api error at $uri and $data');
      //
      //   apiResponse.error = true;
      //   apiResponse.message =
      //       (data['message'] ?? 'Error encountered').toString();
      // }

      if ((data != null && data['success'] == true)) {
        apiResponse.success = true;
        apiResponse.message = (data['message'] ?? 'Succesful').toString();
        apiResponse.data = transform(data);
      } else {
        apiResponse.success = false;
        apiResponse.data = transform(data);
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } on TimeoutException catch (e) {
      apiResponse.success = false;
      debugPrint(e.toString());
      apiResponse.message =
          ('Network Error. The operation couldnt be completed. Check your internet settings')
              .toString();
    } catch (e) {
      apiResponse.success = false;
      apiResponse.message =
          ('Network Error. The operation couldnt be completed.').toString();
      debugPrint(e.toString());
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> putApiDynamic<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, dynamic>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Map<String, String> headers = await httpHeaders();
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      final http.Response res = await http.put(
        uri,
        headers: headers,
        body: httpBody(body),
      );

      final dynamic data = json.decode(res.body);

      // print(uri);
      // print(headers);

      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
      } else {
        // print('data--$data');
        apiResponse.success = false;
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } catch (e) {
      debugPrint(e.toString());

      apiResponse.success = false;
      apiResponse.message = (e).toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> putApi<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final request = IOClient(ioc);

      final Map<String, String> headers = await httpHeaders();
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      debugPrint("URI__ $url");
      final http.Response res = await request.put(
        uri,
        headers: headers,
        body: httpBody(body),
      );
      debugPrint("RES ${res.statusCode}");
      debugPrint('put body' + res.body);

      final dynamic data = json.decode(res.body);

      print('ResponesData123---- $data');
      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
        apiResponse.success = true;
        // apiResponse.hasErrors = false;
        apiResponse.message = (data['message'] ?? ' Successful!').toString();
      } else {
        // print("error=============" + data["errors"][r"$.timeSheetId"][0]);
        apiResponse.success = false;
        apiResponse.data = transform(data);
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } catch (e) {
      debugPrint(e.toString());

      apiResponse.success = false;
      apiResponse.message = (e).toString();
    }

    return apiResponse;
  }

  // Future<ApiResponse<T>> putApi<T>(
  //   String url,
  //   dynamic body, {
  //   T Function(dynamic)? transform,
  //   bool skipStatusCheck = false,
  //   Map<String, String>? params,
  // }) async {
  //   transform ??= (dynamic r) => r.body as T;
  //
  //   final ApiResponse<T> apiResponse = ApiResponse<T>();
  //
  //   try {
  //     final Map<String, String> headers = await httpHeaders();
  //     final Uri uri = AppConfig.apiProtocol.startsWith('https')
  //         ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
  //         : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);
  //
  //     final http.Response res = await http.put(
  //       uri,
  //       headers: headers,
  //       body: httpBody(body),
  //     );
  //
  //     final dynamic data = json.decode(res.body);
  //
  //     // print(uri);
  //     // print(headers);
  //
  //     if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
  //       apiResponse.data = transform(data);
  //     } else {
  //       // print('data--$data');
  //       apiResponse.success = false;
  //       apiResponse.message =
  //           (data['message'] ?? 'Error encountered').toString();
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //
  //     apiResponse.success = false;
  //     apiResponse.message = (e ?? 'Error encountered').toString();
  //   }
  //
  //   return apiResponse;
  // }

  Future<ApiResponse<T>> putApiError<T>(
    String url,
    dynamic body, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      final Map<String, String> headers = await httpHeaders();
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);
      final http.Response res = await http.put(
        uri,
        headers: headers,
        body: httpBody(body),
      );
      final dynamic data = json.decode(res.body);
      // print(headers);
      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
      } else {
        // print('data--$data');

        apiResponse.data = transform(data);
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } catch (e) {
      debugPrint(e.toString());
      // print('expction -- ${e.toString()}');
      apiResponse.success = false;
      apiResponse.message = (e).toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> deleteApi<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, String>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, String>{};

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Map<String, String> headers = await httpHeaders();
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      final http.Response res = await http.delete(
        uri,
        headers: headers,
      );

      final dynamic data = json.decode(res.body);

      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
        apiResponse.success = true;
        apiResponse.message =
            (data['message'] ?? 'Product remove from cart successfully')
                .toString();
      } else {
        // print('Api error at $uri and $data');

        apiResponse.success = false;
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } catch (e) {
      debugPrint(e.toString());

      apiResponse.success = false;
      apiResponse.message = (e).toString();
    }

    return apiResponse;
  }

  Future<ApiResponse<T>> getApiDynamic<T>(
    String url, {
    T Function(dynamic)? transform,
    bool skipStatusCheck = false,
    Map<String, dynamic>? params,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, dynamic>{};

    final ApiResponse<T> apiResponse = ApiResponse<T>();

    try {
      final Map<String, String> headers = await httpHeaders();
      final Uri uri = AppConfig.apiProtocol.startsWith('https')
          ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
          : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);

      final http.Response res = await http.get(
        uri,
        headers: headers,
      );
      // print('URLsss____$uri');
      // print('Token____${headers.values}');
      final dynamic data = json.decode(res.body);

      if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
        apiResponse.data = transform(data);
      } else {
        // print('Api error at $uri and $data');

        apiResponse.success = false;
        apiResponse.message =
            (data['message'] ?? 'Error encountered').toString();
      }
    } catch (e) {
      debugPrint(e.toString());

      apiResponse.success = false;
      apiResponse.message = (e).toString();
    }

    return apiResponse;
  }

  // Future<ApiResponse<T>> postApiAdd<T>(
  //     String url,
  //     dynamic body, {
  //       T Function(dynamic)? transform,
  //       bool skipStatusCheck = false,
  //       Map<String, String>? customHeaders,
  //       Map<String, String>? params,
  //     }) async {
  //   transform ??= (dynamic r) => r.body as T;
  //
  //   final ApiResponse<T> apiResponse = ApiResponse<T>();
  //
  //   try {
  //     final Map<String, String> headers = await httpHeaders(customHeaders);
  //     final Uri uri = AppConfig.apiProtocol.startsWith('https')
  //         ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
  //         : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);
  //
  //     final http.Response res = await http.post(
  //       uri,
  //       headers: headers,
  //       body: httpBody(body),
  //     );
  //     // print('URL___ $uri');
  //     // print('body___ ${httpBody(body)}');
  //
  //     final dynamic data = json.decode(res.body);
  //     // print('ResponesData---- $data');
  //     if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
  //       apiResponse.data = transform(data);
  //     } else {
  //       //apiResponse.error = true;
  //       apiResponse.data = transform(data);
  //       apiResponse.message =
  //           (data['message'] ?? 'Error encountered').toString();
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     apiResponse.success = false;
  //     apiResponse.message = (e ?? 'Error encountered').toString();
  //   }
  //
  //   return apiResponse;
  // }
  //
  // Future<ApiResponse<T>> postApi<T>(
  //     String url,
  //     dynamic body, {
  //       T Function(dynamic) transform,
  //       bool skipStatusCheck = false,
  //       Map<String, String> customHeaders,
  //       Map<String, String> params,
  //     }) async {
  //   transform ??= (dynamic r) => r.body as T;
  //
  //   final ApiResponse<T> apiResponse = ApiResponse<T>();
  //
  //   try {
  //     final Map<String, String> headers = await httpHeaders(customHeaders);
  //     final Uri uri = AppConfig.apiProtocol.startsWith('https')
  //         ? Uri.https(AppConfig.apiDomain, AppConfig.apiPath(url), params)
  //         : Uri.http(AppConfig.apiDomain, AppConfig.apiPath(url), params);
  //
  //     final http.Response res = await http.post(
  //       uri,
  //       headers: headers,
  //       body: httpBody(body),
  //     );
  //     // print('URL___ $uri');
  //     // print('body___ ${httpBody(body)}');
  //
  //     final dynamic data = json.decode(res.body);
  //     // print('ResponesData----data');
  //     if (skipStatusCheck || res.statusCode == 200 || res.statusCode == 201) {
  //       apiResponse.data = transform(data);
  //     } else {
  //       apiResponse.success = false;
  //       // apiResponse.data = transform(data);
  //       apiResponse.message =
  //           (data['message'] ?? 'Error encountered').toString();
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     apiResponse.success = false;
  //     apiResponse.message = (e ?? 'Error encountered').toString();
  //   }
  //
  //   return apiResponse;
  // }
}
