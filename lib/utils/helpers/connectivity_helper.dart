import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper{
  Future<bool> checkConnectivity()
  async {
    bool isOnline=true;
    ConnectivityResult result=await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.none)
      {
        isOnline=false;
      }
    else{
      isOnline=true;
    }
    Connectivity().onConnectivityChanged.listen((event) {
      if(event==ConnectivityResult.none)
      {
        isOnline=false;
      }
      else{
        isOnline=true;
      }
    });
    return isOnline;
  }
}