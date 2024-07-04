import 'package:flutter/material.dart';
import 'package:koneksi_api/models/book_model.dart';
import 'package:koneksi_api/repositories/book_repository.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class EditBookPage extends StatefulWidget {
  final BookModel book;
  const EditBookPage({super.key, required this.book});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  final BookRepository bookRepository = BookRepository();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  void initState() {
    titleController.text = widget.book.title ?? '';
    authorController.text = widget.book.author ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Update Book'),
        actions: [
          IconButton(
            onPressed: () => removeBooks(),
            icon: const Icon(Icons.delete),
          )
        ],
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
          onPressed: () => editBooks(),
          child: const Text('Submit'),
        ),
      ),
    );
  }

  Future editBooks() async {
    if (!form.currentState!.validate()) return;
    OverlayLoadingProgress.start(context);
    BookModel book = BookModel(
      id: widget.book.id,
      title: titleController.text,
      author: authorController.text,
    );

    final response = await bookRepository.updateBook(book);
    OverlayLoadingProgress.stop();
    response.fold((result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Update ${result.title} successfully!'),
      ));

      Navigator.pop(context, result);
    }, (result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result.message ?? ''),
      ));
    });
  }

  Future removeBooks() async {
    OverlayLoadingProgress.start(context);

    final response = await bookRepository.deleteBook(widget.book.id!);
    OverlayLoadingProgress.stop();
    response.fold((result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Delete ${result.title} successfully!'),
      ));

      Navigator.pop(context, result);
    }, (result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(result.message ?? ''),
      ));
    });
  }
}
