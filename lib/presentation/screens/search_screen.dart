import 'package:flutter/material.dart';
import 'package:notes_app/business/providers/search_provider.dart';
import 'package:notes_app/presentation/widgets/custom_elevated_button.dart';
import 'package:notes_app/presentation/widgets/custom_list_card.dart';
import 'package:notes_app/presentation/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final searchTitleController = TextEditingController();
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Busqueda",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  hint: "Titulo",
                  controller: searchTitleController,
                ),
                const SizedBox(width: 10),
                CustomElevatedButton(
                  text: "Buscar",
                  onPressed: () {
                    searchProvider.makeSearch(searchTitleController.text);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: searchProvider.listOfNotes.length,
                itemBuilder: (context, index) {
                  final currentNote = searchProvider.listOfNotes[index];
                  return CustomListCard(
                    title: currentNote.title,
                    subtitle: currentNote.content,
                    date: currentNote.lastEdited,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
