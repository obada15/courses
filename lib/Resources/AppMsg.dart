class AppMsg{
  int? code;
  dynamic data;

  AppMsg({this.code, this.data});

  @override
  String toString() {
    return 'AppMsg{code: $code, data:'+data.toString()+' }';
  }


}