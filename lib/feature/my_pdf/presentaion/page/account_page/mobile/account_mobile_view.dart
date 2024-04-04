import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account_provider.dart';
import '../../book_create_page/create_books.dart';
import '../my_pdf.dart';

class AccountMobileView extends StatelessWidget {
  const AccountMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                    LimitedBox(
                      maxHeight: (size.width / 2) * 1.2,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(state.publicBooks!.length, (index) => ProfilePageCart(data: state.publicBooks![index],)),
                      ),
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
                    LimitedBox(
                      maxHeight: (size.width / 2) * 1.2,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(state.privateBooks!.length, (index) => ProfilePageCart(data: state.privateBooks![index],)),
                      ),
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
                    LimitedBox(
                      maxHeight: (size.width / 2) * 1.2,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children:
                            List.generate(state.favoriteBooks!.length, (index) => ProfilePageCart(data: state.favoriteBooks![index])),
                      ),
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