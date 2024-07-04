import 'package:flutter/material.dart';
import 'package:koneksi_api/models/book_model.dart';
import 'package:koneksi_api/repositories/book_repository.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final BookRepository bookRepository = BookRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Book'),
      ),
      body: Form(
        key: form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == '') return 'Title cannot be empty';
                  return null;
                },
                decoration: const InputDecoration(
                    label: Text('Title'), hintText: 'Enter Book Title Here...'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: authorController,
                validator: (value) {
                  if (value == '') return 'Author cannot be empty';
                  return null;
                },
                decoration: const InputDecoration(
                    label: Text('Author'),
                    hintText: 'Enter Author Name Here...'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () => postBooks(),
          child: const Text('Submit'),
        ),
      ),
    );
  }

  Future postBooks() async {
    if (!form.currentState!.validate()) return;
    OverlayLoadingProgress.start(context);
    BookModel book = BookModel(
      title: titleController.text,
      author: authorController.text,
    );

    final response = await bookRepository.storeBook(book);
    OverlayLoadingProgress.stop();
    response.fold((result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Create ${result.title} successfully!'),
      ));

      Navigator.pop(context, result);
    }, (result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result.message ?? ''),
      ));
    });
  }
}
