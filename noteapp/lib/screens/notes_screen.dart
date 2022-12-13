import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteapp/screens/about.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/screens/edit_note_screen.dart';
import 'package:noteapp/screens/notes_detail_screen.dart';
import 'package:noteapp/sqllite_database/db.dart';
import 'package:noteapp/widgets/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  TextEditingController controller = TextEditingController();
  // List<CategoryModel> categoriesList = <CategoryModel>[];
  List<Note> notes = <Note>[];
  bool _isLoading = false;

  @override
  void initState() {
    // categoriesList = getCategories();
    super.initState();
    refreshNotes();
  }

  @override
  // close instance
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  // to refresh and read all notes
  Future refreshNotes() async {
    setState(() => _isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:false, // imp for removing pre-defined back arrow in appBar
          centerTitle: false,
          title: const Text(
            'My Notes',
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          actions: [
            // ClipRRect(
            //     borderRadius: BorderRadius.circular(5),
            //     child: Image.asset(
            //       "assets/images/1.png",
            //       fit: BoxFit.cover,
            //     )),
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.settings,
            //       color: Colors.black87,
            //     )
            // ),
            IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const Info()));
                },
                icon: const Icon(
                  Icons.info,
                  color: Colors.black87,
                )
            ),
            const SizedBox(width: 25),
            const SizedBox(height: 50),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              width: double.infinity,
              height: 60,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade800,
                    ),
                    hintText: 'Search anything',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
                onChanged: searchTitle,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            /* Column(children: [
            //   Container(
            //       padding: const EdgeInsets.symmetric(horizontal: 10),
            //       child: Column(children: [
            //         // Categories
            //         Container(
            //             height: 40,
            //             child: ListView.builder(
            //                 shrinkWrap: true,
            //                 scrollDirection: Axis.horizontal,
            //                 itemCount: categoriesList.length,
            //                 itemBuilder: ((context, index) {
            //                   return CategoryTile(
            //                     categoryName:
            //                         categoriesList[index].categoryName,
            //                   );
            //                 })))
            //       ]))
             ]),*/
                // Container(
                //   padding: EdgeInsets.only(right: 250.0),
                //   child: Text(
                //     "Light Mode..",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 15.0,
                //       color: Colors.black87,
                //     ),),
                //
                // ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : notes.isEmpty
                        ? const Text(
                            'no notes :(',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 24),
                          )
                        : buildNotes(),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endFloat, // use floatingActionButton for uninterrupted listview since it doesn't cause out of pixels error
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal.shade700,
          child: const Icon(FontAwesomeIcons.plus),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditNoteScreen()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(), // enable for both-ways scrolling
      itemCount: notes.length,
      itemBuilder: ((context, index) {
        final note = notes[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotesDetailScreen(noteId: note.id!),
            ));
            refreshNotes();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoteCard(note: note, index: index),
          ),
        );
      }));

  void searchTitle(String query) {
    var suggestions = notes.where((note) {
      final noteTitle = note.title.toLowerCase();
      final input = query.toLowerCase();
      return noteTitle.contains(input);
    }).toList();
    setState(() => notes = suggestions);
  }
}