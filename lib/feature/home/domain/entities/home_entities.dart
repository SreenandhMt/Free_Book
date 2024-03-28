import 'package:equatable/equatable.dart';

class HomeDataEntities extends Equatable {
  final List<int>? haveAudio;
  final List<String>? text;
  final String? pdfUrl;
  final List<String>? audioUrl;
  final List<String>? partName;
  final String? category;
  final String? bookName;
  final String? bookImageUrl;
  final String? bookAbout;
  final String? oid;
  final String? id;

  const HomeDataEntities(
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
