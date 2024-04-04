import 'package:equatable/equatable.dart';

class MainDataEntities extends Equatable {
  final List<dynamic>? haveAudio;
  final List<dynamic>? text;
  final String? pdfUrl;
  final List<dynamic>? audioUrl;
  final List<dynamic>? partName;
  final String? category;
  final String? bookName;
  final String? bookImageUrl;
  final String? bookAbout;
  final String? oid;
  final String? id;

  const MainDataEntities(
    this.haveAudio,
    this.text,
    this.pdfUrl,
    this.audioUrl,
    this.partName,
    this.category,
    this.bookName,
    this.bookImageUrl,
    this.bookAbout,
    this.oid,
    this.id,
  );
  
  @override
  List<Object?> get props {
    return [
      haveAudio,
      text,
      pdfUrl,
      audioUrl,
      category,
      partName,
      bookName,
      bookImageUrl,
      bookAbout,
      oid,
      id,
    ];
  }



}
