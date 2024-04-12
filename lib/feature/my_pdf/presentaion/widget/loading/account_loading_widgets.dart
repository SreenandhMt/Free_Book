import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AccountCategoryForLoading extends StatelessWidget {
  const AccountCategoryForLoading({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 1000) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.black54,
            highlightColor: Colors.black38,
            direction: ShimmerDirection.ltr,
            period: const Duration(seconds: 2),
            child: LimitedBox(
              maxHeight: (size.width / 2) * 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    5, (index) => const BookCartLoadingForAccountPage()),
              ),
            ),
          )
        ],
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
          children: List.generate(
              12,
              (index) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: BookCartLoadingForAccountPage(),
                  )),
        ),
      ],
    );
  }
}

class BookCartLoadingForAccountPage extends StatelessWidget {
  const BookCartLoadingForAccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 600) {
      return Shimmer.fromColors(
        baseColor: Colors.black54,
        highlightColor: Colors.black38,
        direction: ShimmerDirection.ltr,
        period: const Duration(seconds: 2),
        child: Container(
          margin: const EdgeInsets.all(4),
          width: size.width * 0.31,
          height: size.width * 0.43,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    } else {
      return Shimmer.fromColors(
        baseColor: Colors.black54,
        highlightColor: Colors.black38,
        direction: ShimmerDirection.ltr,
        period: const Duration(seconds: 2),
        child: Container(
          width: 200,
          height: 290,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      );
    }
  }
}
