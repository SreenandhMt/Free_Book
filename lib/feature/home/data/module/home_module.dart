import 'package:ebooks_free/feature/home/domain/entities/home_entities.dart';

class HomeDataModule extends HomeDataEntities{
  const HomeDataModule({
    List<int>? haveAudio, List<String>? text, String? pdfUrl, List<String>? audioUrl, List<String>? partName, String? bookName, String? bookImageUrl, String? bookAbout, String? oid, String? id,final String? category
  }) : super(haveAudio, text, pdfUrl, audioUrl, partName,category, bookName, bookImageUrl, bookAbout, oid, id);
  
  factory HomeDataModule.formJson(Map<String,dynamic> map){
    return HomeDataModule(
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