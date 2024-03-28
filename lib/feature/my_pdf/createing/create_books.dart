// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:ebooks_free/feature/search/data/data_surces/search_data_surces.dart';

FilePickerResult? _pdfFile;
int pages = 1;
bool isLoding = false;
SearchScreenData _data = SearchScreenData();
TextEditingController _aboutController = TextEditingController();
TextEditingController _Part2controller = TextEditingController();
List<String> ListText = [
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
];

FlutterTts tts = FlutterTts();

class ScreenCreatebooks extends StatefulWidget {
  const ScreenCreatebooks({super.key});

  @override
  State<ScreenCreatebooks> createState() => _ScreenCreatebooksState();
}

class _ScreenCreatebooksState extends State<ScreenCreatebooks> {
  @override
  Widget build(BuildContext context) {
    if (isLoding) {
      return const Center(
          child: CupertinoActivityIndicator(
        radius: 15,
      ));
    } else {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  const Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
                  const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
                ])
                // backgroundBlendMode: BlendMode.multiply,
                ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
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
                            _pdfFile = await FilePicker.platform.pickFiles(
                              type: FileType.any,
                            );
                            await getToText();
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black26,
                            ),
                            width: double.infinity,
                            height: 70,
                            child: const Center(
                              child: Text("Put Pdf"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                  landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                  onTap: (value) {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TextEditer()));
                  },
                  currentIndex: 1,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.navigate_next), label: "Next"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.navigate_next), label: "Next"),
                  ]),
            ),
          ),
        ],
      );
    }
  }

  Future<List<int>> _readDocumentData(String name) async {
    final Uint8List data = await _pdfFile!.xFiles.first.readAsBytes();
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<String> getToText() async {
    if (_pdfFile == null) return "Error ---";
    List<int> byths = await _readDocumentData("ss");
    log(byths.toString());
    PdfDocument document = PdfDocument(inputBytes: byths);

//Create a new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

//Extract all the text from the document.
    String text = extractor.extractText();

    // final text = await data.text;
    log(text);
    setState(() {
      pages = 0;
      _Part2controller.text = text;
    });
    return text;
  }
}

class TextEditer extends StatefulWidget {
  const TextEditer({
    Key? key,
  }) : super(key: key);

  @override
  State<TextEditer> createState() => _TextEditerState();
}

class _TextEditerState extends State<TextEditer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                ListText[0] = value;
              },
              controller: _Part2controller,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Part 1",
              ),
              maxLines: 20,
            ),
          ),
          if (pages > 0)
            Column(
              children: List.generate(
                pages,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                      ListText[index + 1] = value;
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
              if (pages < 20) {
                pages = pages + 1;
                setState(() {});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "Anly 20 part please relase a second part in tha book tnks")));
              }
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black38,
              ),
              child: const Center(
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          onTap: (value) {
            if (value == 0) {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScreenCreatebooks()));
            } else {
              List<String> localListText = [];
              for (var text in ListText) {
                if (text.isNotEmpty) {
                  localListText.add(text);
                }
              }
              if (localListText.isNotEmpty && localListText.length >= 3) {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AudioDocument()));
              }
            }
          },
          currentIndex: 1,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back_ios_rounded), label: "Back"),
            BottomNavigationBarItem(
                icon: Icon(Icons.navigate_next), label: "Next"),
          ]),
    );
  }
}

class AudioDocument extends StatelessWidget {
  const AudioDocument({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> localListText = [];
              for (var text in ListText) {
                if (text.isNotEmpty) {
                  localListText.add(text);
                }
              }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(localListText.length, (index) => const Padding(
          padding: EdgeInsets.all(17),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.audio_file),
                SizedBox(
                  width: 10,
                ),
                Text("Audio"),
              ],
            ),
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          onTap: (value) {
            if (value == 0) {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TextEditer()));
            } else if (value == 1) {
              Navigator.of(context).pop();
            } else {
              List<String> localListText = [];
              for (var text in ListText) {
                if (text.isNotEmpty) {
                  localListText.add(text);
                }
              }
              log(localListText.toString());
            }
          },
          currentIndex: 1,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_back_ios_rounded), label: "Back"),
            BottomNavigationBarItem(
                icon: Icon(Icons.scatter_plot), label: "Skip"),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload_file), label: "Upload"),
          ]),
    );
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
