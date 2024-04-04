
import 'package:ebooks_free/feature/my_pdf/presentaion/page/book_create_page/create_books.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ebooks_free/feature/home/presentaion/provider/home_provider.dart';

import 'desktop/home_desktop_view.dart';
import 'mobile/home_mobile_view.dart';
import 'tablet/home_tablet_view.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    context.read<HomeDataProvider>().init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    return Consumer<HomeDataProvider>(builder: (context,provider,_)
    {
    if(provider.isLoding) return const Center(child: CupertinoActivityIndicator(),);

    if(size.width<=600)
    {
      return MobileHomeScreen(provider: provider,);
    }
    if(size.width<=900)
    {
      return TabHomeScreen(provider: provider,);
    }
    else
    {
      return PcHomeScreen(provider: provider,);
    }
    }
    );
  }
}
