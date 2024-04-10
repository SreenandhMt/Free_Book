import 'package:flutter/material.dart';

import '../../../../core/entitles/main_entities.dart';
import '../../../play_screen/presentation/page/play_page.dart';

class BookCart extends StatelessWidget {
  const BookCart({
    super.key,
    required this.book,
  });
  final MainDataEntities book;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width<=600)
    {
      return MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ScreenPlay(eBook: book,))),
          child: Container(
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
      );
    }else{
      return MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScreenPlay(eBook: book,))),
          child: Container(
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
      );
    }
  }
}

class BookCartForLoading extends StatelessWidget {
  const BookCartForLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width<=600)
    {
      return Container(
        width: size.width * 0.31,
        height: size.width * 0.43,
        decoration: BoxDecoration(
          color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
            
                ),
      );
    }else{
      return Container(
        width: 200,
        height: 290,
        decoration: BoxDecoration(
          color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
            
                ),
      );
    }
  }
}