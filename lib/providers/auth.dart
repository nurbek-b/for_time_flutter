import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/storage.dart';


String mainUrl = 'https://agrimatico-backend.ml/';


class Auth with ChangeNotifier{

  String _access;
  String _refresh;
  String _userId;
  String _name;
  String _phone;
  String password;
  bool isEditing = false;

  Auth(){
    this.refresh();
  }

  Future<void> setIdToken(access, id, phoneNumber) async{
    var storage = Storage().secureStorage;
    _access = access;
    _userId = id;
    _phone = phone;
    await storage.write(key: "access", value: _access);
    final userInfo = await getUserInfo();
    await storage.write(key: "name", value: userInfo["name"]);
    _name = userInfo["name"];
  }

  void refresh() async {
    var storage = Storage().secureStorage;
    storage.read(key: "access").then((value) => this._access = value);
    Storage().secureStorage.read(key: "name").then((value) => this._name = value);
    Storage().secureStorage.read(key: "phone").then((value) => this._phone = value);
  }

  void saveName(){
    if(isEditing){
      setOrEditName(_name);
      isEditing = false;
    }
  }

  bool get isAuth{
    return _access != null;
  }

  String get access{
    if(_access == null){
      refresh();
      return _access;
    }
    return _access;
  }

  String get name{
    return _name ?? "";
  }

  set name(newValue){
    _name = newValue;
//    setOrEditName(newValue);
  }

  String  get phone{
    return phone;
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Ошибка"),
    content: Text("Пользователь с таким номером уже существует."),
    actions: [
        FlatButton(
          child: Text("Далее"),
          onPressed: () { },),
    ],
  );


  Future register({String phone, String password, String passwordConfirm})async{
    var storage = Storage().secureStorage;
    final authUrl = "${mainUrl}api/v1/accounts/register/";
    try {
      final res = await http.post(
        authUrl,
        body: jsonEncode({
          "phone": phone,
          "password": password,
          "password_confirmation": passwordConfirm}),
        headers: { "Content-Type": "application/json; charset=UTF-8"},
      );
      final responseData = jsonDecode(res.body);
      print("RESPONSE FROM AUTH $responseData");
      await storage.write(key: "phone", value: phone);
      await storage.write(key: "password", value: password);
      await storage.write(key: "passwordConfirm", value: passwordConfirm);
      await storage.write(key: "access", value: responseData['access']);
      await storage.write(key: "refresh", value: responseData['refresh']);
      await storage.write(key: "userType", value: responseData['user_type']);
      return responseData;
    }catch (error){
      throw error;
    }
  }



  Future logIn({String phone, String password, String userType})async{
    var storage = Storage().secureStorage;
    final authUrl = "${mainUrl}api/v1/accounts/login/";
    print("DATA PHONE $phone");
    print("DATA PASSWORD $password");
    print("DATA USERTYPE $userType");
    try {
      final res = await http.post(
        authUrl,
        body: jsonEncode({
          "phone": phone,
          "password": password,
          "user_type": userType}),
        headers: { "Content-Type": "application/json; charset=UTF-8"},
      );
      await storage.write(key: "phone", value: phone);
      await storage.write(key: "password", value: password);
      await storage.write(key: "userType", value: userType);
      return res;
    }catch (error){
      throw error;
    }
  }



  Future setOTP({String otpNum, String phone})async{
    var storage = Storage().secureStorage;
    final otpUrl = "${mainUrl}api/v1/accounts/verify_phone/";
    try{
      final res = await http.post(
          otpUrl,
          body: jsonEncode({
            "phone": phone,
            "code": otpNum}),
          headers: { "Content-Type": "application/json; charset=UTF-8"},
      );
      final responseData = jsonDecode(res.body);
      print("RESPONSE OF OTP $responseData");
      print("REASPONSE CODE ${res.statusCode}");
      await storage.write(key: 'refresh', value: responseData['refresh']);
      await storage.write(key: 'access', value: responseData['access']);
      return res;
    }catch(error){
      throw error;
    }
  }

  void logout(){
    Storage().secureStorage.deleteAll();
    _access = null;
    _name = null;
    _phone = null;
    _refresh = null;
    _userId = null;
    password = null;
  }

  Future getUserInfo() async {
    const authUrl = "https://demo-arbuz.herokuapp.com/api/v1/profile";
    final access = await Storage().secureStorage.read(key: "access");
    try {
      final res = await http.get(
        authUrl,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Token $access"
        },
      );
      final responseData = jsonDecode(res.body);
      return responseData;
    }catch (error){
      throw error;
    }
  }

  Future setOrEditName(String newName) async{
    const authUrl = "https://demo-arbuz.herokuapp.com/api/v1/profile/";
    try {
      final res = await http.patch(
        authUrl,
        body: jsonEncode({"name": newName}),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Token $_access"
        },
      );
      final responseData = jsonDecode(res.body);
      await Storage().secureStorage.write(key: "name", value: newName);
//      if (res.statusCode == 400) {
//        throw HttpException(responseData['name']);
//      }
      print(responseData);
      return responseData;
    }catch (error){
      throw error;
    }
  }

}