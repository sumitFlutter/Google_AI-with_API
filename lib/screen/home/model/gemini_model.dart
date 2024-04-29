class GeminiModel
{
  String? finishReason;
  List<CandidatesModel>? candidatesModelList=[];
  GeminiModel({this.finishReason, this.candidatesModelList});
  factory GeminiModel.mapToModel(Map m1)
  {
    List l1=m1["candidates"];
    return GeminiModel(finishReason: m1["finishReason"],candidatesModelList: l1.map((e) => CandidatesModel.mapToModel(e)).toList());
  }
}
class CandidatesModel{
ContentModel? contentModel;
CandidatesModel({this.contentModel});
factory CandidatesModel.mapToModel(Map m1)
{
  return CandidatesModel(contentModel: ContentModel.mapToModel(m1["content"]));
}
}
class ContentModel{
String? role;
List<PartsModel>? parts=[];
ContentModel({this.role, this.parts});
factory ContentModel.mapToModel(Map m1)
{
 List l1= m1["parts"];
  return ContentModel(parts: l1.map((e) => PartsModel.mapToModel(e)).toList(),role: m1["role"]);
}
}
class PartsModel{
  String? text;
  PartsModel({this.text});
  factory PartsModel.mapToModel(Map m1)
  {
    return PartsModel(text: m1["text"]);
  }
}