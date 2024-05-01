class GeminiDBModel{
  int? id,isQ;
  String? text,date,time;

  GeminiDBModel({this.id, this.text, this.date, this.time,this.isQ});
  factory GeminiDBModel.mapToModel(Map m1)
  {
    return GeminiDBModel(id: m1["id"],date: m1["date"],text: m1["textMsg"],time: m1["time"],isQ: m1["isQ"]);
  }
}