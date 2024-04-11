import 'package:ebooks_free/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/account_provider.dart';
import '../../../widget/account_category.dart';
import '../../../widget/loading/account_loading_screen.dart';
import '../../book_create_page/create_books.dart';

class AccountTabletView extends StatelessWidget {
  const AccountTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: theme
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
                    if(state.publicBooks!=null)
                      AccountCategory(content: state.publicBooks!, title: "Public"),
                    
                    if(state.privateBooks!=null)
                    AccountCategory(content: state.publicBooks!, title: "Private")
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