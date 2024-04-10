import 'package:flutter/material.dart';

import '../../page/book_create_page/create_books.dart';
import 'account_loading_widgets.dart';

class AccountPageLoading extends StatelessWidget {
  const AccountPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Account"),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        children: const[
          AccountCategoryForLoading(title: "Public"),
          AccountCategoryForLoading(title: "Private"),
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
  }
}