import 'package:flutter/material.dart';

import '../../../../../core/entitles/main_entities.dart';
import '../book_card.dart';

class CategoryForMobile extends StatelessWidget {
  const CategoryForMobile({
    super.key,
    required this.content,
    required this.title,
  });
  final List<MainDataEntities> content;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        LimitedBox(
          maxHeight: size.width * 0.48,
          maxWidth: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                content.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: BookCart(
                        book: content[index],
                      ),
                    )),
          ),
        ),
      ],
    );
  }
}
