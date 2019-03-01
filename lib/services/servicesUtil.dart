import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
Future getHomePageContent() async{
  try {
     Response response;
  var dio = new Dio();
    dio.options.contentType=ContentType.parse("application/x-www-form-urlencoded");
  var formData = {'lon':'115.02932','lat':'35.76189'};
  response=await dio.post(servicePath['HomePath'],data: formData);
  if(response.statusCode==200){
    return response.data;
  }else{
    throw Exception("首页接口出错");
  }
  } catch ( e) {
    return print("ERROR:================>${e}");
  }
}