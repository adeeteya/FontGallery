import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/widgets/font_card.dart';
import 'package:font_gallery/widgets/theme_mode_toggle.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showSearch(context: context, delegate: FontSearchDelegate());
          },
          icon: const Icon(Icons.search),
        ),
        title: const Text("Font Gallery"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 0),
        ),
        actions: const [ThemeModeToggle()],
      ),
      body: ListView.separated(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: fontList.length,
        itemBuilder: (context, index) => FontCard(
          fontModel: fontList[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}

class FontSearchDelegate extends SearchDelegate {
  final List<String> emptySearchResultEmojis = [
    "(^_^)b",
    "\\(^Д^)/",
    "(˚Δ˚)b",
    "(^-^*)",
    "(·_·)",
    "(>_<)",
    "(·.·)",
    "\\(o_o)/",
    "(≥o≤)",
    "(='X'=)",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return (query.isEmpty)
        ? null
        : [
            IconButton(
              onPressed: () {
                query = "";
              },
              icon: const Icon(Icons.clear),
            ),
          ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List resultsList = fontList
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (resultsList.isEmpty) {
      int randomEmptyResultIndex = Random().nextInt(10);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emptySearchResultEmojis[randomEmptyResultIndex],
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 20),
            const Text(
              "Can't find any fonts.",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                query = "";
                showSuggestions(context);
              },
              child: const Text("Clear your filters and try again"),
            ),
          ],
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: resultsList.length,
        itemBuilder: (context, index) => FontCard(
          fontModel: resultsList[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return const PreferredSize(
      preferredSize: Size.fromHeight(2),
      child: Divider(height: 0),
    );
  }
}
