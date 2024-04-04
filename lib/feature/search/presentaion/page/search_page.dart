import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/entitles/main_entities.dart';
import '../../../play_screen/play_page.dart';
import '../provider/search_data_provider.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SearchProvider>().getSearchQuary("");
    // final size = MediaQuery.of(context).size;
    return Consumer<SearchProvider>(
      builder: (context,state,_) {
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
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  toolbarHeight: 100,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: CupertinoSearchTextField(
                    onChanged: (value) => context.read<SearchProvider>().getSearchQuary(value),
                    padding: const EdgeInsets.all(13),
                    autocorrect: true,
                    itemColor: Colors.white,
                    style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),
                  ),
                ),
                body:
                state.searchQuary!=null?
                 ListView(
                  children: [
                    Wrap(
                      children: List.generate(state.searchQuary!.length, (index) => SearchPageCart(book: state.searchQuary![index],)),
                    ),
                  ],
                ):const SizedBox(),
              ),
            ),
          ],
        );
      }
    );
  }
}

class SearchPageCart extends StatelessWidget {
  const SearchPageCart({
    super.key,
    required this.book,
  });
  final MainDataEntities book;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width<=600)
    {
      return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ScreenPlay(eBook: book,))),
          child: Container(
            margin: const EdgeInsets.all(8),
            width: size.width * 0.31,
            height: size.width * 0.43,
            decoration: BoxDecoration(
              color: Colors.black26,
                borderRadius: BorderRadius.circular(5),
                image:DecorationImage(
                    image: NetworkImage(book.bookImageUrl??""),
                    fit: BoxFit.cover)
                    ),
          ),
        ),
      ],
    );
    }else{
      return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenPlay(eBook: book,))),
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 200,
            height: 290,
            decoration: BoxDecoration(
              color: Colors.black26,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: NetworkImage(book.bookImageUrl??""),
                    fit: BoxFit.cover)
                    ),
          ),
        ),
      ],
    );
    }
  }
}
