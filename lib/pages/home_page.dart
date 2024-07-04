import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koneksi_api/models/book_model.dart';
import 'package:koneksi_api/pages/add_book_page.dart';
import 'package:koneksi_api/pages/edit_book_page.dart';
import 'package:koneksi_api/repositories/book_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final BookRepository bookRepository = BookRepository();
  List<BookModel> books = [];

  @override
  void initState() {
    // fetchBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              // fetchBooks();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (builder) {
              //   return EditBookPage(
              //     book: books[index],
              //   );
              // })).then((value) {
              //   if (value != null) {
              //     fetchBooks();
              //   }
              // });
            },
            title: Text(books[index].title ?? ''),
            subtitle: Text(books[index].author ?? ''),
            trailing: books[index].createdAt != null
                ? Text(DateFormat('dd MMMM yyyy')
                    .format(books[index].createdAt!)
                    .toString())
                : null,
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (builder) {
          //   return const AddBookPage();
          // })).then((value) {
          //   if (value != null) {
          //     fetchBooks();
          //   }
          // });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Future fetchBooks() async {
  //   if (mounted) {
  //     setState(() {
  //       books = [];
  //     });
  //   }

  //   final response = await bookRepository.getBooks();
  //   response.fold((result) {
  //     if (mounted) {
  //       setState(() {
  //         books = result;
  //       });
  //     }
  //   }, (result) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(result.message ?? ''),
  //     ));
  //   });
  // }
}
