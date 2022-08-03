
import 'dart:convert';
import 'dart:io';
import 'package:Courses/Models/GeneralRespones.dart';
import 'package:Courses/Models/LessonModel.dart';
import 'package:Courses/Models/QuizModel.dart';
import 'package:Courses/Models/SubjectModel.dart';
import 'package:Courses/Models/User.dart';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../DataStore.dart';
import 'API.dart';
import 'AppMsg.dart';

enum ReqType{
  GET,POST,DIO,DELETE
}
class ApiProvider{

  Map<String, String> getHeader({var isAuth = true}){
    return {
      "Accept": "application/json",
      "Authorization": (dataStore.user == null || !isAuth) ? '' :"Bearer "+ (dataStore?.user?.data?.api_token?? "")
    };
  }
  Map<String, String> getSignUpHeader(){
    return {
      "Accept": "application/json",
    };
  }
  void apiTacking( {url,method,response,status, dynamic body, Map<String, String> ?header , Map<String, dynamic> ?queryParameters}){
    print("---------------api tracking start---------------");
    print('url:  $url');
    print('method:  $method');
    print('headers: ${json.encode(header)}');
    print("params: ${json.encode(queryParameters)}");
    print('body:  ${json.encode(body)}');
    print('response:  $response');
    print('status:  $status');
    print("---------------api tracking end-----------------");
  }

  Future<dynamic> _loadData(ReqType type,String url, {dynamic body,FormData ?formData,Map<String,String> ?customHeader,Map<String, dynamic> ?queryParameters,bool withMessage = false }) async {

    if(body == null) body = <String,String>{};
    if(url.contains("signup")||url.contains("login"))
      {
        customHeader = getSignUpHeader();
      }else{
      if (customHeader == null) customHeader = getHeader();
    }

    var response;
    try {
      if(type == ReqType.GET )
        response = await _getRequest(url, header: customHeader,queryParameters: queryParameters);
      else if (type == ReqType.DELETE)
        response = await _deleteRequest(url, header: customHeader,queryParameters: queryParameters);
      else if (type == ReqType.POST)
        response = await _postRequest(url, body, header: customHeader,queryParameters: queryParameters);
      else {
        response = await _dioRequest(url, body, formData: formData,
            header: customHeader,
            queryParameters: queryParameters);
      }
        print("(handler) response _loadData AppMsg error handler herer error${response} ");
    }
    catch(e){
      apiTacking(url: url,method: type,body: e.toString(),header: customHeader,queryParameters: queryParameters);
      print("(un-handler) catch e _loadData AppMsg error handler herer error${e.toString()} ");

      throw AppMsg(code: -1 , data: e.toString());
    }

    var responseBody;
    if(type == ReqType.DIO)
    {
      responseBody = json.decode(response.data);
    }
    else {
      responseBody = json.decode(response.body);
    }
    apiTacking(url: url,method: type,body: body,response: responseBody,header: customHeader,queryParameters: queryParameters,status: response.statusCode);

      if(response.statusCode >=200 && response.statusCode <500){
      if(response.statusCode == 401) {
        throw AppMsg(code: 401 , data: responseBody["message"] ?? "notAuth");
      }else{
        return responseBody;
      }
    }
    /*else if(response.statusCode == 401)
    {
      throw AppMsg(code: 401 , data: responseBody["message"] ?? "notAuth");
    }*/
    var genBloc = GeneralModel.fromJson(responseBody);

    if (genBloc is GeneralModel){
      print("(handler x) _loadData AppMsg error handler herer ${genBloc.toJson().toString()} ");

      if(genBloc.code == -401) {
        throw AppMsg(code: 401, data: "notAuth");
      }else{

        if (genBloc.message != null){
          var res = "";
          if(genBloc.errors != null){
            genBloc.errors.forEach((k,v){  // add .data here
              var subRes = "";
              if (genBloc.errors[k] is List<dynamic>){
                for (int i=0;i<(genBloc.errors[k] as List<dynamic>).length;i++){
                  subRes += genBloc.errors[k][i];
                  print(genBloc.errors[k][i]);
                }
              }else{
                subRes += "${genBloc.errors[k]} \n";
              }
              res += subRes;
              res += "\n";
            });
            throw AppMsg(code: response.statusCode, data: "${"wrong"} \n\n $res");

          }else{
            throw AppMsg(code: response.statusCode, data: genBloc.message);
          }
        }else if (genBloc.data != null){
          throw AppMsg(code: response.statusCode, data: genBloc.data);
        }else if(genBloc.errors != null){
          throw AppMsg(code: response.statusCode, data: genBloc.errors);
        }else{
          throw AppMsg(code: response.statusCode, data: genBloc.toString());
        }
      }
    }else{
      print("(handler xxx) _loadData AppMsg error handler herer ${responseBody.toString()} ");
      throw AppMsg(
          data: responseBody.toString(),
          code: response.statusCode
      );
    }

  }

  _getRequest(String url, {Map<String, String> ?header , Map<String, dynamic> ?queryParameters}) async {
    if (header == null)
      header = getHeader();
    var uri = Uri.parse(url);
    if(queryParameters != null)
    {
      uri= uri.replace(queryParameters: queryParameters);
    }
    final response = await http.get(uri, headers: header).timeout(Duration(seconds: 30),onTimeout: (){
      throw AppMsg(
          code: -2,
          data: "timeOut"
      );
    }).catchError((error){
      throw AppMsg(
          code: -1,
          data: error
      );
    });

    apiTacking(url: uri.toString(),method: "GET",response: response.body,header: header,queryParameters: queryParameters);

    return response;
  }

  _deleteRequest(String url, {Map<String, String> ?header , Map<String, dynamic> ?queryParameters}) async {
    if (header == null)
      header = getHeader();
    var uri = Uri.parse(url);
    if(queryParameters != null)
    {
      uri= uri.replace(queryParameters: queryParameters);
    }
    final response = await http.delete(uri, headers: header).timeout(Duration(seconds: 30),onTimeout: (){
      throw AppMsg(
          code: -2,
          data: "timeOut"
      );
    }).catchError((error){
      throw AppMsg(
          code: -1,
          data: error
      );
    });

    apiTacking(url: uri.toString(),method: "GET",response: response.body,header: header,queryParameters: queryParameters);

    return response;
  }

  _postRequest(String url, Map<String, dynamic> body, {Map<String, String> ?header , Map<String, dynamic> ?queryParameters}) async {
    print("xxxx6");

    if (header == null)
      header = getHeader();

    var uri = Uri.parse(url);
    if(queryParameters != null)
    {
      uri= uri.replace(queryParameters: queryParameters);
    }

    final response =
    await http.post(uri, headers: header, body: jsonEncode(body)).timeout(Duration(seconds: 15),onTimeout: (){ // handle Timeout
      apiTacking(url: url.toString(),method: "POST",body: body,header: header,queryParameters: queryParameters);
      throw "timeOut";
    }).catchError((error){ //any error

      apiTacking(url: url.toString(),method: "POST",body: body,header: header,queryParameters: queryParameters);
      throw error;
    });
    apiTacking(url: url.toString(),method: "POST",body: body,response: response.body,header: header,queryParameters: queryParameters,status: response.statusCode);
    return response;
  }

  _dioRequest(String url, Map<String, dynamic> body, {FormData ?formData,Map<String, String> ?header , Map<String, dynamic> ?queryParameters})async{
    Dio dio = Dio();
    if (header == null)
      header = getHeader();

    try{
      FormData _formData = formData == null ? FormData.fromMap(body) : formData;
      print("HHHHHHHhhh");
      print(FormData.fromMap(body).toString());
      final response = await dio.post(url ,data: _formData , options:Options(
          headers: header ,responseType: ResponseType.plain ),queryParameters: queryParameters );
      apiTacking(url: url,method: "DIO",body: "${_formData.files} ${response.data} \n ${response.extra}",header: header,queryParameters: queryParameters);

      return response;
    }
    on DioError catch(error){

      apiTacking(url: url,method: "DIO",body: " ${error.response} \n ${error.type} \n ${error.error} \n ${error.response}",header: header,queryParameters: queryParameters);

      if(error.response!=null)
        return error.response;

      else {
        if(error.type == DioErrorType.connectTimeout || error.type == DioErrorType.sendTimeout || error.type == DioErrorType.receiveTimeout)
          throw AppMsg(
              code: -2,
              data: error.error
          );

        throw AppMsg(
            code: -1,
            data: error.error
        );
      }
    }

  }

  Future<UserModel> signUp(User user) async {

    var url = API.signUp;
    FormData formData = await user.toJson();
    var response = await _loadData(ReqType.DIO, url,formData: formData);
    return UserModel.fromJson(response);
  }
  Future<UserModel> login(String phone , String password) async{

    Map<String,String> body = {
      "mobile_number": phone,
      "password": password,
    };
    var response = await _loadData(ReqType.DIO,API.login, body: body);
    return UserModel.fromJson(response);
  }
  Future<SubjectModel> getSubjects() async {
    var url = API.subjects;
    var response = await _loadData(ReqType.GET, url,);
    return SubjectModel.fromJson(response);
  }
  Future<LessonModel> getLessonsByID(String id) async {
    var url = API.lessons.replaceAll("ID", id);
    var response = await _loadData(ReqType.GET, url,);
    return LessonModel.fromJson(response);
  }
  Future<CourseModel> getCoursesByID(String id) async {
    var url = API.courses.replaceAll("ID", id);
    var response = await _loadData(ReqType.GET, url,);
    return CourseModel.fromJson(response);
  }
  Future<QuizModel> getQuizzes() async {
    var url = API.quizzes;
    var response = await _loadData(ReqType.GET, url,);
    return QuizModel.fromJson(response);
  }
  Future<QuestionModel> getQuestions(String id) async {
    var url = API.questions.replaceAll("ID", id);
    var response = await _loadData(ReqType.GET, url,);
    return QuestionModel.fromJson(response);
  }

  Future<GeneralModel> quizResult(QuizResultModel quizResultModel) async{

    var response = await _loadData(ReqType.POST,API.quizeResult, body: quizResultModel.toJson());
    return GeneralModel.fromJson(response);
  }
  Future<MyQuizModel> getMyQuizzes() async {
    var url = API.myQuizzes;
    var response = await _loadData(ReqType.GET, url,);
    return MyQuizModel.fromJson(response);
  }
  Future<CourseModel> getMyCourses() async {
    var url = API.myCourses;
    var response = await _loadData(ReqType.GET, url,);
    return CourseModel.fromJson(response);
  }
  Future<GeneralModel> InsertCode(String code) async{

    Map<String,dynamic> body = {
      "code": code,
    };
    var response = await _loadData(ReqType.DIO,API.insertCode, body: body);
    return GeneralModel.fromJson(response);
  }


}

ApiProvider apiProvider = ApiProvider();