import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../database/database_user.dart';

///For a better understanding see the json_structure.txt field.
class RestDataRequest {
  login(
      String username, String password, BuildContext context) async {
    Dio dio = new Dio();
    dio.options.baseUrl = "PUT YOUR URL IN HERE";
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    FormData formData = new FormData.from({
      "email": username,
      "password": password,
    });

    Response response = await dio.post(
      ///Change the /info for your authentication path
      "/info",
      data: formData,
      options: new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded")),
    );

    ///IF YOUR RESPONSE COME IN HTML USE THIS
    var dataMap = json.decode(response.data);
    ///IF YOUR RESPONSE COME IN JSON USE THIS
    ///var dataMap = response.data;

    ///Change the if validation according to the json structure you're retrieving
    if (dataMap['success'] == true &&
        dataMap['data']['user']['id'] != null) {
      Map<String, dynamic> data = dataMap['data']['user'];
      print(data);
      final user = User.map(data);
      var db = new DatabaseHelper();
      await db.saveUser(user);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Text("Usuario o contraseña no validos"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }
}
