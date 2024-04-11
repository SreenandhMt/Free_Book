import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
    if (size.width <= 600) {
      return Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScreenPlay(
                      eBook: book,
                    ))),
            child: Container(
              width: size.width * 0.31,
              height: size.width * 0.43,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(5),
                // image: DecorationImage(
                //     image: NetworkImage(book.bookImageUrl ?? ""),
                //     fit: BoxFit.cover)
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: book.bookImageUrl ?? "",
                placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(
                  radius: 10,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ScreenPlay(
                      eBook: book,
                    ))),
            child: Container(
              width: 200,
              height: 290,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(5),
                // image: DecorationImage(
                //     image: NetworkImage(book.bookImageUrl ?? ""),
                //     fit: BoxFit.cover)
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: book.bookImageUrl ?? "",
                placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(
                  radius: 10,
                )),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ],
      );
    }
  }
}
