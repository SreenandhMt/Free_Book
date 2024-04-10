import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

class BookView extends StatefulWidget {
  const BookView({super.key,required this.url});
  final String url;

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  PdfControllerPinch? document;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init()async{
     document =  PdfControllerPinch(document:PdfDocument.openData(await InternetFile.get(widget.url)));
     setState(() {
       
     });
  }

  @override
  Widget build(BuildContext context) {
    if(document==null)
    {
      return const CupertinoActivityIndicator();
    }else{
      return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PdfViewPinch(
            scrollDirection: Axis.vertical,
            controller: document!),
          ),
        ],
      ),
    );
    }
  }
}