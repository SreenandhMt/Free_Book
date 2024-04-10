import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/entitles/main_entities.dart';
import '../book_card.dart';

class CategoryForDesktop extends StatelessWidget {
  const CategoryForDesktop({
    super.key,
    required this.content,
    required this.title,
  });
  final List<MainDataEntities> content;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 10, bottom: 6),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Wrap(
          // scrollDirection: Axis.horizontal,
          children: List.generate(
              content.length,
              (index) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: BookCart(
                      book: content[index],
                    ),
                  )),
        )
      ],
    );
  }
}
