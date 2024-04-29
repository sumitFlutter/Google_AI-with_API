import 'package:flutter/cupertino.dart';
import 'package:google_gemini/screen/model/gemini_model.dart';
import 'package:google_gemini/utils/helpers/api_helper.dart';

class GeminiProvider with ChangeNotifier{
  GeminiModel? geminiModel;
  String text="Who is PM of INDIA?";
  APIHelper apiHelper=APIHelper();
  void postAPICall(String q)
  async {
    text=q;
    if(await apiHelper.apiCall(text)!=null)
      {
        GeminiModel g2=(await apiHelper.apiCall(text))!;
        geminiModel=g2;
      }
    else{
      geminiModel=GeminiModel();
    }
    notifyListeners();
  }
}