import 'dart:io';

class MyHttpOverrides extends HttpOverrides{

  HttpClient createHttpCliect(SecurityContext? context){
    return super.createHttpClient(context)..badCertificateCallback=(X509Certificate cert,String host,int port)=>true;
  }

}