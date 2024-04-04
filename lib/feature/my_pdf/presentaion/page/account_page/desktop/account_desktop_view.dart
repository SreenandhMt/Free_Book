import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/entitles/main_entities.dart';
import '../../../../../play_screen/play_page.dart';
import '../../../provider/account_provider.dart';
import '../../book_create_page/create_books.dart';

class AccountDesktopView extends StatelessWidget {
  const AccountDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                const Color.fromARGB(255, 38, 26, 59).withOpacity(0.8),
                const Color.fromARGB(255, 27, 48, 66).withOpacity(0.8),
              ])
              // backgroundBlendMode: BlendMode.multiply,
              ),
          child: Consumer<AccountProvider>(
            builder: (context, state,_) {
              return Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: const Text("Account"),
                  backgroundColor: Colors.transparent,
                  scrolledUnderElevation: 0,
                ),
                body: ListView(
                  children: [
                    state.publicBooks!=null?
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Publice",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ):const SizedBox(),
                    state.publicBooks!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:
                          List.generate(state.publicBooks!.length, (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookCart(book: state.publicBooks![index],),
                          )),
                    ):const SizedBox(),
                    state.privateBooks!=null?
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Private",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ):const SizedBox(),
                    state.privateBooks!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:
                          List.generate(state.privateBooks!.length, (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookCart(book: state.privateBooks![index],),
                          )),
                    ):const SizedBox(),
                    state.favoriteBooks!=null?
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Favarate",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ):const SizedBox(),
                    state.favoriteBooks!=null?
                    Wrap(
                      // scrollDirection: Axis.horizontal,
                      children:
                          List.generate(state.favoriteBooks!.length, (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BookCart(book: state.favoriteBooks![index]),
                          )),
                    ):const SizedBox(),
                  ],
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(bottom: 55, left: 10),
                  child: FloatingActionButton(
                    
                    backgroundColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenCreatebooks()));
                    },
                    child: const Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

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
      return Column(
      children: [
        GestureDetector(
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
      ],
    );
    }else{
      return Column(
      children: [
        GestureDetector(
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
      ],
    );
    }
  }
}