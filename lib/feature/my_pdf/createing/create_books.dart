// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

FilePickerResult? _pdfFile;
int pages = 0;
bool isLoding=false;
TextEditingController _aboutController = TextEditingController();
TextEditingController _Part2controller = TextEditingController();

class ScreenCreatebooks extends StatefulWidget {
  const ScreenCreatebooks({super.key});

  @override
  State<ScreenCreatebooks> createState() => _ScreenCreatebooksState();
}

class _ScreenCreatebooksState extends State<ScreenCreatebooks> {
  List<String> ListText=["","","","","","","","","","","","","","","","","","","","","","","",];
  FlutterTts tts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    if (isLoding) {
      return const Center(child: CupertinoActivityIndicator(radius: 15,));
    } else {
      return Stack(
        children: [
          Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                 Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
               const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
            ])
            // backgroundBlendMode: BlendMode.multiply,
            ),
            child: Scaffold(
            appBar: AppBar(backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: Colors.black,),),
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Column(
                  children: [
                    const BookCart(),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Book Name"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _aboutController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "About",
                      ),
                      maxLines: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _pdfFile =
                            await FilePicker.platform.pickFiles(type: FileType.any,);
                        await getToText();
                        setState(() {});
                      },
                      
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: 300,
                        height: 150,
                        color: Colors.blue,
                        child: const Center(
                          child: Text("Put Pdf"),
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        ListText[0] =value;
                      },
                      controller: _Part2controller,
                      decoration: InputDecoration(
                        
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Part 1",
                      ),
                      maxLines: 20,
                    ),
            
                    if (pages > 1)
                      Column(
                        children: List.generate(
                          pages,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                ListText[index+1]=value;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Part ${index + 2}",
                              ),
                              maxLines: 20,
                            ),
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          if (pages < 20) {
                            pages = pages + 1;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text(
                                    "Anly 20 part please relase a second part in tha book tnks")));
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: 200,
                        height: 100,
                        color: Colors.blue,
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        await recordAudio(ListText);
                        log("gg");
                      },
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          width: 200,
                          height: 50,
                          color: Colors.blue,
                          child: const Center(
                            child: Text("Uploade"),
                          ),
                        ),
                    ),
                  ],
                )
              ],
            ),
                ),
          ),
        ],
      );
    }
  }

  Future<void> recordAudio(List<String> list)async
  {
    await tts.setLanguage("en-US");
    await tts.setPitch(0.5);
    for (var i = 0; i < list.length; i++) {
      if(list[i].isNotEmpty)
      {
        final s = await tts.synthesizeToFile(list[i], "Book Name - Part ${i+1}.mp3");
        // await tts.awaitSynthCompletion(true);
        log("d");
      }
    }
    final data =await Hive.openBox("your-books");
    data.put("ebooks", {
      "name":"Book Name",
      "maxPart":3
    });

    setState(() {
      
    });

    for (var i = 0; i < list.length; i++) {
      // await tts.synthesizeToFile(list[i], "Book Name - Part ${i+1}.mp3");
      // save data
    }

    return;
  }


  Future<List<int>> _readDocumentData(String name) async {
  final Uint8List data =await  _pdfFile!.xFiles.first.readAsBytes();
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<String> getToText() async {
    if(_pdfFile==null)return "Error ---";
    List<int> byths = await _readDocumentData("ss");
    log(byths.toString());
    PdfDocument document =
        PdfDocument(inputBytes: byths);

//Create a new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

//Extract all the text from the document.
    String text = extractor.extractText();
    
    // final text = await data.text;
    log(text);
    setState(() {
      pages=0;
      _Part2controller.text=text;
    });
    return text;
  }
}

class BookCart extends StatelessWidget {
  const BookCart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          // onTap: () => Navigator.of(context).push(MaterialPageRoute(
          // builder: (context) => const ScreenPlay(
          // eBook: ["heeee njan annne a", "ddddddddddd", "mmmmmmmmmm"]))),
          child: Container(
            width: size.width * 0.30,
            height: size.width * 0.46,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://m.media-amazon.com/images/I/71eoUH2EngL._AC_UF1000,1000_QL80_.jpg"),
                    fit: BoxFit.cover)),
          ),
        ),
      ],
    );
  }
}
