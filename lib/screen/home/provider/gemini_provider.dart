import 'package:flutter/cupertino.dart';
import 'package:google_gemini/utils/helpers/api_helper.dart';

import '../model/gemini_model.dart';

class GeminiProvider with ChangeNotifier{
  GeminiModel? geminiModel=GeminiModel();
  String text="Who is PM of INDIA?";
  List<String> qnaList=[];
  APIHelper apiHelper=APIHelper();
  void postAPICall()
  async {
    if(await apiHelper.apiCall(text)!=null)
      {
        geminiModel=(await apiHelper.apiCall(text));
        qnaList.add(geminiModel!.candidatesModelList![0].contentModel!.parts![0].text!);
      }
    else{
      geminiModel=GeminiModel();
      qnaList.add("Something went wrong");
    }
    notifyListeners();
  }
  void getQ(String q)
  {
    text=q;
    qnaList.add(q);
    geminiModel=null;
    notifyListeners();
  }
}