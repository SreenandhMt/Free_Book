import '../entitles/main_entities.dart';

class MainDataModule extends MainDataEntities{
  const MainDataModule({
    List<int>? haveAudio, List<String>? text, String? pdfUrl, List<String>? audioUrl, List<String>? partName, String? bookName, String? bookImageUrl, String? bookAbout, String? oid, String? id,final String? category
  }) : super(haveAudio, text, pdfUrl, audioUrl, partName,category, bookName, bookImageUrl, bookAbout, oid, id);
  
  factory MainDataModule.formJson(Map<String,dynamic> map){
    return MainDataModule(
      audioUrl: map["audioUrl"],
      text: map["text"],
      haveAudio: map['haveAudio'],
      partName: map['partName'],
      bookAbout: map["bookAbout"],
      bookImageUrl: map["bookurl"],
      bookName: map["bookName"],
      category: map["category"],
      id: map["id"],
      oid: map['oid'],
      pdfUrl: map["pdfUrl"],
    );
  }
  

}