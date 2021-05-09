import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pictiknew/Common/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppClass.dart';
import 'ClassList.dart';

Dio dio = new Dio();

class AppServices {
  static Future<DataClass> AccessToken(String username, String password) async {
    String url =
        "https://origin.opicxo.com/token?username=$username&password=$password";
    print("Get Login with otp  URL: " + url);
    try {
      final response = await dio.get(url,
          options: Options(
            method: 'POST',
            responseType: ResponseType.plain,
          ));
      if (response.statusCode == 200) {
        DataClass dataClass = new DataClass(message: 'No Data', value: "1");
        final jsonResponse = json.decode(response.data);
        // dataClass.message = jsonResponse['message'];
        // dataClass.value = jsonResponse['status'].toString();
        // dataClass.statusCode = jsonResponse['responseCode'].toString();
        dataClass.access_token = jsonResponse['access_token'].toString();
        // dataClass.otp = jsonResponse['otp'].toString();
        print("Login with otp Responce: ${jsonResponse}");
        return dataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("Login Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<DataClass> LoginApp(
      String email, String password, String token) async {
    String url =
        "https://origin.opicxo.com/api/v1/login?email=$email&password=$password";
    print("Get login opicxo   URL: " + url);
    try {
      print("11");
      final response = await dio.post(url,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      print("22");
      print("${response.toString()}");
      if (response.statusCode == 200) {
        print("33");
        print("${response.data}");
        DataClass dataClass = new DataClass(message: 'No Data', value: null);
        final jsonResponse = response.data;
        print("${jsonResponse.toString()}");
        print("list Responce: ${jsonResponse}");
        List list = [];
        list = [
          {
            "first_name": jsonResponse['login_response']["first_name"],
            "last_name": jsonResponse['login_response']["last_name"],
            "user_name": jsonResponse['login_response']["user_name"],
            "email": jsonResponse['login_response']["email"],
            "customer_token": jsonResponse['login_response']["customer_token"],
          }
        ];

        dataClass.login_response = list;
        print("opicxo login Responce: ${jsonResponse}");
        return dataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("logout Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<List> getStudioList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int custId = int.parse(prefs.getString(Session.opicxoCustomerId));
    String url = 'http://pictick.itfuturz.com/api/homeapi/' +
        'GetStudioList?Opicxo_CustomerId=$custId';
    print("GetStudioList URL: " + url);
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        List list = [];
        print("GetStudioList Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["IsSuccess"] == true &&
            memberDataClass["Data"].length > 0) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception("something went wrong");
      }
    } catch (e) {
      print("GetStudioList Erorr : " + e.toString());
      throw Exception("something went wrong");
    }
  }

  static Future<DataClass> AboutUs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int studioId = int.parse(prefs.getString(Session.opicxoStudioId));
    String url =
        "https://origin.opicxo.com/api/v1/studios/${studioId}/description";
    print("Get about opicxo   URL: " + url);
    try {
      print("11");
      final response = await dio.get(url,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      print("22");
      print("${response.toString()}");
      if (response.statusCode == 200) {
        print("33");
        print("${response.data}");
        DataClass dataClass = new DataClass(message: 'No Data', value: null);
        final jsonResponse = response.data;
        print("${jsonResponse.toString()}");
        print("list Responce: ${jsonResponse}");
        List list = [];
        list = [
          {
            "description": jsonResponse['studio']["description"],
          }
        ];

        dataClass.studio = list;
        print("opicxo about Responce: ${jsonResponse}");
        return dataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("about Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<DataClass> StudioDetail(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int studioId = int.parse(prefs.getString(Session.opicxoStudioId));
    String url = "https://origin.opicxo.com/api/v1/studios/${studioId}/detail";
    print("Get about opicxo   URL: " + url);
    try {
      print("11");
      final response = await dio.get(url,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      print("22");
      print("${response.toString()}");
      if (response.statusCode == 200) {
        print("33");
        print("${response.data}");
        DataClass dataClass = new DataClass(message: 'No Data', value: null);
        final jsonResponse = response.data;
        print("${jsonResponse.toString()}");
        print("list Responce: ${jsonResponse}");
        List list = [];
        list = [
          {
            "studio_detail": jsonResponse["studio_detail"],
          }
        ];

        dataClass.studioDetail = list;
        print("opicxo about Responce: ${list}");

        return dataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("about Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<DataClass> SliderBanner(String token, int StudioId) async {
    String url =
        "https://origin.opicxo.com/api/v1/studios/${StudioId}/sliderbanner";
    print("Get studio banners opicxo   URL: " + url);
    try {
      print("11");
      final response = await dio.get(url,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      print("22");
      print("${response.toString()}");
      if (response.statusCode == 200) {
        print("33");
        print("${response.data}");
        DataClass dataClass = new DataClass(message: 'No Data', value: null);
        final jsonResponse = response.data;
        dataClass.message = jsonResponse['message'];
        print("${jsonResponse.toString()}");
        print("list Responce: ${jsonResponse}");
        // List list = [];
        // list = jsonResponse['studio_slider_banner'][0]["picture_urls"];

        dataClass.studioBanner = jsonResponse['studio_slider_banner'];
        print(
            "opicxo studio banners Responce: ${jsonResponse['studio_slider_banner']}");
        return dataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("studio banners Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }

  static Future<SaveDataClass> CurrentStudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int opicxoCustId = int.parse(prefs.getString(Session.opicxoCustomerId));

    String url =
        "http://pictick.itfuturz.com/api/homeapi/GetCurrentStudio?Opicxo_CustomerId=${opicxoCustId}";
    print("AddCustomer url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: "0");
        print("AddCustomer Response: " + response.data.toString());
        var memberDataClass = response.data;
        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error AddGuestList");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error AddCustomer ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> sendSms(body, String token) async {
    print(body.toString());
    String url = "https://origin.opicxo.com/api/v1/sms";
    print("sendSms url : " + url);
    try {
      final response = await dio.post(url,
          data: body,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: "0");
        print("sendSms Response: " + response.data.toString());
        var memberDataClass = response.data;
        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error sendSms");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error sendSms ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> updateStudio(
      String oCusId, String oStudId) async {
    int opicxoCustId = int.parse(oCusId);
    int opicxoStudId = int.parse(oStudId);

    String url =
        "http://pictick.itfuturz.com/api/homeapi/UpdateCurrentStudio?Opicxo_CustomerId=${opicxoCustId}&Opicxo_StudioBLId=$opicxoStudId";

    print("UpdateCurrentStudio url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: "0");
        print("UpdateCurrentStudio Response: " + response.data.toString());
        var memberDataClass = response.data;
        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error UpdateCurrentStudio");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error UpdateCurrentStudio ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<SaveDataClass> finalizeSelection(String galleryIdd) async {
    int galleryId = int.parse(galleryIdd);

    String url =
        "http://pictick.itfuturz.com/api/HomeAPI/UpdateSelectionComplete?galleryId=$galleryId";

    print("UpdateSelectionComplete url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        SaveDataClass saveData =
            new SaveDataClass(Message: 'No Data', IsSuccess: false, Data: "0");
        print("UpdateSelectionComplete Response: " + response.data.toString());
        var memberDataClass = response.data;
        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.Data = memberDataClass["Data"].toString();

        return saveData;
      } else {
        print("Error UpdateSelectionComplete");
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Error UpdateSelectionComplete ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<DataClass> OpicxoPortfolio(String token, int StudioId) async {
    String url =
        "https://origin.opicxo.com/api/v1/studios/${StudioId}/portfolio";
    print("Get studio portfolio opicxo   URL: " + url);
    try {
      print("11");
      final response = await dio.get(url,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));
      print("22");
      print("${response.toString()}");
      if (response.statusCode == 200) {
        print("33");
        print("${response.data}");
        DataClass dataClass = new DataClass(message: 'No Data', value: null);
        final jsonResponse = response.data;
        dataClass.message = jsonResponse['message'];
        print("${jsonResponse.toString()}");
        print("list Responce: ${jsonResponse}");
        // List list = [];
        // list = jsonResponse['studio_slider_banner'][0]["picture_urls"];

        dataClass.studioPortfolio = jsonResponse['studio_portfolios'];
        print(
            "opicxo studio portfolio Responce: ${jsonResponse['studio_portfolios']}");
        return dataClass;
      } else {
        throw Exception("Something went Wrong");
      }
    } catch (e) {
      print("studio portfolio Error : " + e.toString());
      throw Exception("Something went wrong");
    }
  }
}
