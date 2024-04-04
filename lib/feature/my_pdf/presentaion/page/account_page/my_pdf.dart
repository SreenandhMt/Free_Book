import 'package:ebooks_free/feature/my_pdf/presentaion/page/account_page/desktop/account_desktop_view.dart';
import 'package:ebooks_free/feature/my_pdf/presentaion/page/account_page/mobile/account_mobile_view.dart';
import 'package:ebooks_free/feature/my_pdf/presentaion/page/account_page/tablet/account_tablet_view.dart';
import 'package:ebooks_free/feature/play_screen/play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:ebooks_free/core/entitles/main_entities.dart';
import 'package:ebooks_free/feature/my_pdf/presentaion/provider/account_provider.dart';


class MyPdfToAudioPage extends StatefulWidget {
  const MyPdfToAudioPage({super.key});

  @override
  State<MyPdfToAudioPage> createState() => _MyPdfToAudioPageState();
}

class _MyPdfToAudioPageState extends State<MyPdfToAudioPage> {
  final HiveInterface hive = Hive;
  FlutterTts tts = FlutterTts();
  List<String> text = ["emty", "Ss"];
  int? startpoint, endpoint;
  String ctext = "";

  @override
  void initState() {
    
      context.read<AccountProvider>().getAllData();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width<=600)
    {
      return const AccountMobileView();
    }
    else if(size.width<=1200)
    {
      return const AccountTabletView();
    }else{
      return const AccountDesktopView();
    }
    
  }

  @override
  void dispose() {
    tts.stop();
    super.dispose();
  }
}

class ProfilePageCart extends StatelessWidget {
  const ProfilePageCart({
    super.key,
    required this.data,
  });
  final MainDataEntities data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ScreenPlay(eBook: data))),
          child: Container(
            
            margin: EdgeInsets.all((size.width / 2) * 0.03),
            height: (size.width / 2) * 1,
            width: (size.width / 2) * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black26,
                image: DecorationImage(image: NetworkImage(data.bookImageUrl??""),fit: BoxFit.cover)),
          ),
        )
      ],
    );
  }
}
