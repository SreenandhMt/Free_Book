
import 'dart:developer';

import 'package:ebooks_free/core/theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '/core/module/main_module.dart';
import '/feature/my_pdf/presentaion/provider/account_provider.dart';

FilePickerResult? _pdfFile,image;
int pages = 1;
bool isLoding = false;
TextEditingController _aboutController = TextEditingController();
TextEditingController _bookNameController = TextEditingController();
List<String> listText = [""];

List<String> partName = [];


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
                gradient: theme
                // backgroundBlendMode: BlendMode.multiply,
                ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Column(
                      children: [
                        GestureDetector(onTap: ()async{
                          image = await FilePicker.platform.pickFiles(type: FileType.image);
                        },child: const BookCart()),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _bookNameController,
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
                            // await getToText();
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
                  onTap: (value) async{
                  //   context.read<AccountProvider>().createBook(MainDataModule(audioUrl: [],bookAbout: _aboutController.text,bookImageUrl: _Part2controller.text,bookName: _bookNameController.text,category: "classics",haveAudio: const[1,0],partName: ["Saul of Tarsus","The Trial","The Letter","Ginger Cake & Tea","City of 333 Saints","George of Inverness"],pdfUrl: _Part3controller.text,text: ListText,), await _pdfFile!.xFiles.first.readAsBytes());
                  // Navigator.of(context).pop();
                    if(_bookNameController.text.isNotEmpty&&image!=null&&_aboutController.text.isNotEmpty)
                    {
                      Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TextEditer(bookName: _bookNameController.text,bookAbout: _aboutController.text,pdf: _pdfFile!,)));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill all data")));
                    }
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
    });
    return text;
  }
}

class TextEditer extends StatefulWidget {
  const TextEditer({
    super.key,
    required this.bookName,
    required this.bookAbout,
    required this.pdf,
  });
  final String bookName;
  final String bookAbout;
  final FilePickerResult pdf;

  @override
  State<TextEditer> createState() => _TextEditerState();
}

class _TextEditerState extends State<TextEditer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
                gradient: theme
                // backgroundBlendMode: BlendMode.multiply,
                ),
          child: Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onChanged: (value) {
                        listText[0] = value;
                    },
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
                            listText[index + 1] = value;
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
                    if (pages < 40) {
                      pages = pages + 1;
                      listText.add("");
                      setState(() {});
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Anly 40 part please relase a second part in tha book tnks")));
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
                    for (var text in listText) {
                      if (text.isNotEmpty) {
                        localListText.add(text);
                      }
                    }
                    if (localListText.isNotEmpty && localListText.length >= 3) {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  AudioDocument(bookAbout: widget.bookAbout,bookName: widget.bookName,pdf: widget.pdf,text: localListText,)));
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
          ),
        ),
      ],
    );
  }
}


List<String> urls = [];
bool loding=false;

class AudioDocument extends StatefulWidget {
  const AudioDocument({
    super.key,
    required this.bookName,
    required this.bookAbout,
    required this.pdf,
    required this.text,
  });
  final String bookName;
  final String bookAbout;
  final FilePickerResult pdf;
  final List<String> text;

  @override
  State<AudioDocument> createState() => _AudioDocumentState();
}

class _AudioDocumentState extends State<AudioDocument> {
  int indexs=1;
  @override
  Widget build(BuildContext context) {
    
    List<String> localListText = [];
    for (var text in listText) {
      if (text.isNotEmpty) {
        localListText.add(text);
      }
    }
    return Container(
      decoration: BoxDecoration(
                gradient: theme
                // backgroundBlendMode: BlendMode.multiply,
                ),
      child: Scaffold(
        appBar: AppBar(title: const Text("you can skip this"),),
        body: !loding? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(indexs, (index) => Padding(
            padding: const EdgeInsets.all(17),
            child: GestureDetector(
              onTap: () async{
                loding=true;
                setState(() {});
                final data = (await FilePicker.platform.pickFiles(type: FileType.audio))!;
                await FirebaseStorage.instance.ref().child("s/${data.xFiles.first.name}").putData(await data.xFiles.first.readAsBytes());
                final localurl = await FirebaseStorage.instance.ref().child("s/${data.xFiles.first.name}").getDownloadURL();
                urls.add(localurl);
                loding=false;
                if(indexs<=localListText.length)
                {
                  indexs=indexs+1;
                }
                
                setState((){});
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.audio_file),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Part ${index+1} Audio"),
                  ],
                ),
            ),
          )),
        ):const CupertinoActivityIndicator(radius: 10,),
        bottomNavigationBar: BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            onTap: (value) async{
              if (value == 0) {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>  TextEditer(bookAbout: widget.bookAbout,bookName: widget.bookName,pdf: widget.pdf,)));
              } else if (value == 1) {
                List<String> localListText = [];
                for (var text in listText) {
                  if (text.isNotEmpty) {
                    localListText.add(text);
                  }
                }
              for (var i=0;i<=localListText.length;i++) {
                partName.add("");
                
              }
              Navigator.of(context).pop();
              Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PartName(text: localListText,bookAbout: widget.bookAbout,bookName: widget.bookName,pdf: widget.pdf,url: urls,)));
              }
            },
            currentIndex: 1,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back_ios_rounded), label: "Back"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_file), label: "Next"),
            ]),
      ),
    );
  }
}

class PartName extends StatefulWidget {
  const PartName({
    super.key,
    required this.bookName,
    required this.bookAbout,
    required this.pdf,
    required this.text,
    required this.url,
  });
  final String bookName;
  final String bookAbout;
  final FilePickerResult pdf;
  final List<String> text;
  final List<String> url;

  @override
  State<PartName> createState() => _PartNameState();
}

class _PartNameState extends State<PartName> {
  String _selectedLocation="general";
  List<String> locations =["classics","motivational","comady","story","horror","general","history"];
  String initValue = "public";
  List<String> pos = ["public","private"];
  int part=1;
  @override
  Widget build(BuildContext context) {
    if (isLoding) {
      return const Center(
          child: CupertinoActivityIndicator(
        radius: 15,
      ));
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: List.generate(widget.text.length, (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(onChanged: (value) => partName[index+1]=value,
              decoration: InputDecoration(hintText: "Enter a Part name ${index+1}",border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
            )),
          ),
          DropdownButton(
            value: _selectedLocation,
            onChanged: (newValue) {
              setState(() {
                _selectedLocation = newValue!;
              });
            },
            items: locations.map((String location) {
              return DropdownMenuItem<String>(
                value: location  ,
                child: Text(location),
              );
            }).toList(),
          ),
          const SizedBox(height: 20,),
          DropdownButton(
            value: initValue,
            onChanged: (newValue) {
              setState(() {
                initValue = newValue!;
              });
            },
            items: pos.map((String location) {
              return DropdownMenuItem<String>(
                value: location  ,
                child: Text(location),
              );
            }).toList(),
          )
          // IconButton(onPressed: (){if(widget.text.length<=part){setState((){part=part+1;});}log(partName.toString());}, icon: const Icon(Icons.add))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            onTap: (value) async{
              if (value == 0) {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AudioDocument(bookAbout: widget.bookAbout,bookName: widget.bookName,pdf: widget.pdf,text: widget.text,)));
              } else if (value == 1) {
                
                if(_pdfFile!=null)
                {
                  loding=true;
                  setState(() {});
                  final data = await _pdfFile!.xFiles.first.readAsBytes();
                  await FirebaseStorage.instance.ref().child("s/${_pdfFile!.xFiles.first.name}").putData(data);
                  final url = await FirebaseStorage.instance.ref().child("s/${_pdfFile!.xFiles.first.name}").getDownloadURL();
                  final imageData = await image!.xFiles.first.readAsBytes();
                  await FirebaseStorage.instance.ref().child("s/${image!.xFiles.first.name}").putData(imageData);
                  final imageurl = await FirebaseStorage.instance.ref().child("s/${image!.xFiles.first.name}").getDownloadURL();
                  List<String> localPartName=[];
                  for (var row in partName) {
                    if(row.isNotEmpty)
                    {
                      localPartName.add(row);
                    }
                  }
                  loding=false;
                  setState(() {});
                  if(initValue=="pubilc")
                  {
                    context.read<AccountProvider>().createBook(MainDataModule(audioUrl: widget.url,bookAbout: widget.bookAbout,bookImageUrl: imageurl,bookName: widget.bookName,category: _selectedLocation,haveAudio: const[1,0],partName: localPartName,pdfUrl: url,text: widget.text,), await _pdfFile!.xFiles.first.readAsBytes());
                  }
                  else{
                    context.read<AccountProvider>().createPrivateBook(MainDataModule(audioUrl: widget.url,bookAbout: widget.bookAbout,bookImageUrl: imageurl,bookName: widget.bookName,category: _selectedLocation,haveAudio: const[1,0],partName: localPartName,pdfUrl: url,text: widget.text,), await _pdfFile!.xFiles.first.readAsBytes());

                  }
                  
                  Navigator.of(context).pop();
                }
                
              }
            },
            currentIndex: 1,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.arrow_back_ios_rounded), label: "Back"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_file), label: "Next"),
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
                color: Colors.black26),
          ),
        ),
      ],
    );
  }
}
