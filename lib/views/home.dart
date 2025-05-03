import 'package:flutter/material.dart';
import 'package:font_gallery/models/font_model.dart';
import 'package:font_gallery/views/font_search_delegate.dart';
import 'package:font_gallery/widgets/compare_button.dart';
import 'package:font_gallery/widgets/font_card.dart';
import 'package:font_gallery/widgets/theme_mode_toggle.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await showSearch(context: context, delegate: FontSearchDelegate());
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CompareButton(),
      body: ListView.separated(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        itemCount: fontList.length,
        itemBuilder: (context, index) => FontCard(fontModel: fontList[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
