import 'package:flutter/material.dart';

import '../../../../core/entitles/main_entities.dart';
import '../../../home/presentaion/widget/book_card.dart';

class AccountCategory extends StatelessWidget {
  const AccountCategory({
    super.key,
    required this.content,
    required this.title,
  });
  final List<MainDataEntities> content;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 1000) {
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      );
      LimitedBox(
        maxHeight: (size.width / 2) * 1.2,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              content.length,
              (index) => BookCart(
                    book: content[index],
                  )),
        ),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        Wrap(
          // scrollDirection: Axis.horizontal,
          children: List.generate(
              content.length,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BookCart(
                      book: content[index],
                    ),
                  )),
        ),
      ],
    );
  }
}
