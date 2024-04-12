import 'package:ebooks_free/core/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/search_data_provider.dart';
import '../widget/search_book_cart.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  @override
  void initState() {
    super.initState();
    context.read<SearchProvider>().getSearchQuary("");
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Consumer<SearchProvider>(builder: (context, state, _) {
      if (state.searchQuary == null) return const SearchLoadingPage();
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), gradient: theme
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
                  onChanged: (value) =>
                      context.read<SearchProvider>().getSearchQuary(value),
                  padding: const EdgeInsets.all(13),
                  autocorrect: true,
                  itemColor: Colors.white,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ),
              body: state.searchQuary != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListView(
                        children: [
                          Wrap(
                            children: List.generate(
                                state.searchQuary!.length,
                                (index) => SearchPageCard(
                                      book: state.searchQuary![index],
                                    )),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      );
    });
  }
}

class SearchLoadingPage extends StatelessWidget {
  const SearchLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), gradient: theme
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
            onChanged: (value) =>
                context.read<SearchProvider>().getSearchQuary(value),
            padding: const EdgeInsets.all(13),
            autocorrect: true,
            itemColor: Colors.white,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
        body: Shimmer.fromColors(
          baseColor: Colors.black54,
          highlightColor: Colors.black38,
          direction: ShimmerDirection.ltr,
          period: const Duration(seconds: 2),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ListView(
              children: [
                Wrap(
                  children: List.generate(
                      10, (index) => const SearchPageCardLoading()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
