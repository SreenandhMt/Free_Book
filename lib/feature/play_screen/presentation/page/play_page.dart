import 'package:ebooks_free/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

import 'package:ebooks_free/core/miniplayer_config.dart';

import '../../../../core/entitles/main_entities.dart';

// final MiniplayerProvider _provider = MiniplayerProvider();
int maxLines = 11;

class ScreenPlay extends StatefulWidget {
  const ScreenPlay({
    super.key,
    required this.eBook,
  });
  final MainDataEntities eBook;

  @override
  State<ScreenPlay> createState() => _ScreenPlayState();
}

class _ScreenPlayState extends State<ScreenPlay> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 600) {
      return Container(
        decoration: BoxDecoration(
          gradient: theme
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                // name and image
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        width: size.width * 1.2,
                        height: size.width * 1.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.eBook.bookImageUrl ?? ""),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Book Name",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                // about
                Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.only(
                      left: 17, right: 17, top: 17, bottom: 9),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "About",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Column(
                        children: [
                          Text(
                            widget.eBook.bookAbout ?? "",
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            maxLines: maxLines,
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            if (maxLines == 20) {
                              maxLines = 11;
                            } else {
                              maxLines = 20;
                            }
                            setState(() {});
                          },
                          child: Text(
                            maxLines == 11 ? "Show More.." : "Show Less",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ))
                    ],
                  ),
                ),
                // parts
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: List.generate(
                      widget.eBook.text!.length,
                      (index) => GestureDetector(
                            onTap: () {
                              if (widget.eBook.audioUrl == null ||
                                  widget.eBook.audioUrl!.isEmpty) {
                                context
                                    .read<MiniplayerProvider>()
                                    .addMiniPlayer(
                                        bookUrl:
                                            widget.eBook.bookImageUrl ?? "",
                                        bookname: widget.eBook.bookName!,
                                        partName:
                                            widget.eBook.partName![index] ?? "",
                                        pdfUrl: widget.eBook.pdfUrl ?? "",
                                        text: widget.eBook.text![index] ?? "",
                                        audioUrl: null,
                                        isPlayingL: true);
                              } else {
                                context
                                    .read<MiniplayerProvider>()
                                    .addMiniPlayer(
                                        bookUrl:
                                            widget.eBook.bookImageUrl ?? "",
                                        bookname: widget.eBook.bookName!,
                                        partName:
                                            widget.eBook.partName![index] ?? "",
                                        pdfUrl: widget.eBook.pdfUrl ?? "",
                                        text: widget.eBook.text![index] ?? "",
                                        audioUrl: widget.eBook.audioUrl![index],
                                        isPlayingL: true);
                              }
                              context
                                  .read<MiniplayerProvider>()
                                  .miniPlayerController
                                  .animateToHeight(state: PanelState.MAX);
                              Navigator.of(context)
                                  .pop(); //push(MaterialPageRoute(builder: (context)=>const ScreenPlayPart()));
                            },
                            child: Container(
                              margin: const EdgeInsets.all(3.0),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: CircleAvatar(
                                              radius: 19,
                                              backgroundColor: Colors.black38,
                                              child: Center(
                                                child: Text(index.toString()),
                                              ))),
                                      const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 70, top: 1),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Part name",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Book Name",
                                                  softWrap: true,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider()
                                ],
                              ),
                            ),
                          )),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return DesktopPartPage(eBook: widget.eBook);
    }
  }
}

class DesktopPartPage extends StatefulWidget {
  const DesktopPartPage({super.key, required this.eBook});
  final MainDataEntities eBook;

  @override
  State<DesktopPartPage> createState() => _DesktopPartPageState();
}

class _DesktopPartPageState extends State<DesktopPartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    width: 300,
                    height: 440,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:
                                NetworkImage(widget.eBook.bookImageUrl ?? ""),
                            fit: BoxFit.fill)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          widget.eBook.bookName!,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w700),
                        ),
                        // about
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.only(
                              left: 17, right: 17, top: 17, bottom: 9),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "About",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              Column(
                                children: [
                                  Text(
                                    widget.eBook.bookAbout ?? "",
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                    maxLines: maxLines,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (maxLines == 20) {
                                      maxLines = 11;
                                    } else {
                                      maxLines = 20;
                                    }
                                    setState(() {});
                                  },
                                  child: Text(
                                    maxLines == 11
                                        ? "Show More.."
                                        : "Show Less",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple),
                                  ))
                            ],
                          ),
                        ),
                        // parts
                        Column(
                          children: List.generate(
                              widget.eBook.text!.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      if (widget.eBook.audioUrl == null ||
                                          widget.eBook.audioUrl!.isEmpty) {
                                        context
                                            .read<MiniplayerProvider>()
                                            .addMiniPlayer(
                                                bookUrl: widget
                                                        .eBook.bookImageUrl ??
                                                    "",
                                                bookname:
                                                    widget.eBook.bookName!,
                                                partName: widget.eBook
                                                        .partName![index] ??
                                                    "",
                                                pdfUrl:
                                                    widget.eBook.pdfUrl ?? "",
                                                text: widget
                                                        .eBook.text![index] ??
                                                    "",
                                                audioUrl: null,
                                                isPlayingL: true);
                                      } else {
                                        context
                                            .read<MiniplayerProvider>()
                                            .addMiniPlayer(
                                                bookUrl: widget
                                                        .eBook.bookImageUrl ??
                                                    "",
                                                bookname:
                                                    widget.eBook.bookName!,
                                                partName: widget.eBook
                                                        .partName![index] ??
                                                    "",
                                                pdfUrl:
                                                    widget.eBook.pdfUrl ?? "",
                                                text: widget
                                                        .eBook.text![index] ??
                                                    "",
                                                audioUrl: widget
                                                    .eBook.audioUrl![index],
                                                isPlayingL: true);
                                      }
                                      // context.read<MiniplayerProvider>().miniPlayerController.animateToHeight(state: PanelState.MAX);
                                      Navigator.of(context)
                                          .pop(); //push(MaterialPageRoute(builder: (context)=>const ScreenPlayPart()));
                                    },
                                    child: MouseRegion(
                                      cursor: MaterialStateMouseCursor.clickable,
                                      child: Container(
                                        margin: const EdgeInsets.all(3.0),
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: CircleAvatar(
                                                        radius: 19,
                                                        backgroundColor:
                                                            Colors.black38,
                                                        child: Center(
                                                          child: Text(
                                                              "${index+1}"),
                                                        ))),
                                                Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 70, top: 1),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            widget.eBook.partName![index],
                                                            softWrap: true,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            widget.eBook.bookName!,
                                                            softWrap: true,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            // name and image
          ],
        ),
      ),
    );
  }
}
