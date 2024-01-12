import 'package:flutter/material.dart';
import 'package:hive_note/pages/detail_page.dart';
import 'package:hive_note/services/hive_service.dart';
import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  static const id = "/home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Note> list = [];

  void loadNotes() async {
    list = await DBService.loadNotes();
    setState(() {});
  }


  void _openDetail()async {
    var result = await Navigator.pushNamed(context, DetailPage.id);
    if(result != null && result == true){
      loadNotes();
    }
  }

  Future<void> _openDetailWithNote(Note note)async {
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
      note: note,
    )));
    if(result != null && result == true){
      loadNotes();
    }
  }

  @override
  void initState() {
    loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Note"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 20
        ),
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              _openDetailWithNote(list[index]);
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(child: Text(list[index].title, style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),)),
                  ),
                  Expanded(
                    child: Center(child: Text(list[index].content, style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),)),
                  ),
                  Expanded(
                    child: Center(child: Text(list[index].createTime.toString(), style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _openDetail();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
