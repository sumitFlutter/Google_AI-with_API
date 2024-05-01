import 'package:flutter/cupertino.dart';
import 'package:google_gemini/screen/home/model/db_model.dart';
import 'package:google_gemini/utils/helpers/api_helper.dart';
import 'package:google_gemini/utils/helpers/db_helper.dart';

import '../model/gemini_model.dart';

class GeminiProvider with ChangeNotifier{
  GeminiModel? geminiModel=GeminiModel();
  String text="Who is PM of INDIA?";
  List<GeminiDBModel> qnaList=[];
  APIHelper apiHelper=APIHelper();
  void postAPICall()
  async {
    if(await apiHelper.apiCall(text)!=null)
      {
        geminiModel=(await apiHelper.apiCall(text));
        DBHelper.dbHelper.insertMsg(GeminiDBModel(text:geminiModel!.candidatesModelList![0].contentModel!.parts![0].text!,time: "${DateTime.now().hour}:${DateTime.now().minute}",date: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",isQ: 1));
        qnaList=await DBHelper.dbHelper.readMsg();
      }
    else{
      geminiModel=GeminiModel();
      DBHelper.dbHelper.insertMsg(GeminiDBModel(text: "SomeThing Went Wrong",time: "${DateTime.now().hour}:${DateTime.now().minute}",date: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",isQ: 1));
      qnaList=await DBHelper.dbHelper.readMsg();
    }
    notifyListeners();
  }
  Future<void> getQ(String q)
  async {
    text=q;
    geminiModel=null;
    DBHelper.dbHelper.insertMsg(GeminiDBModel(time: "${DateTime.now().hour}:${DateTime.now().minute}",text: q,date: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",isQ: 0));
    qnaList=await DBHelper.dbHelper.readMsg();
    notifyListeners();
  }
  Future<void> readList()
  async {
    qnaList=await DBHelper.dbHelper.readMsg();
    notifyListeners();
  }
}