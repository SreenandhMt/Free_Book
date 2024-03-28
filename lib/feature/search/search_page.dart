import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              scrolledUnderElevation: 0,
              toolbarHeight: 100,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const CupertinoSearchTextField(
                padding: EdgeInsets.all(13),
                autocorrect: true,
                itemColor: Colors.white,
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),
              ),
            ),
            body: ListView(
              children: [
                Wrap(
                  children: List.generate(10, (index) => SearchPageCart()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchPageCart extends StatelessWidget {
  const SearchPageCart({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all((size.width/2)*0.03),
          height: (size.width/2)*1,
          width: (size.width/2)*0.6,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black26),
        )
      ],
    );
  }
}