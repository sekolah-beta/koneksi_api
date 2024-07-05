import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:koneksi_api/models/book_model.dart';
import 'package:koneksi_api/models/response_model.dart';

class BookRepository {
  final String _baseUrl = 'https://60fec25a2574110017078789.mockapi.io/api/v1';

  Future<Either<List<BookModel>, ResponseModel>> getBooks() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/books'));

      List<BookModel> books = List<BookModel>.from(
          json.decode(response.body).map((data) => BookModel.fromJson(data)));

      return Left(books);
    } catch (_) {
      return Right(ResponseModel(message: "Something went wrong"));
    }
  }

  Future<Either<BookModel, ResponseModel>> storeBook(BookModel book) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/books'), body: {
        'title': book.title,
        'author': book.author,
      });

      BookModel newBook = BookModel.fromJson(json.decode(response.body));

      return Left(newBook);
    } catch (_) {
      return Right(ResponseModel(message: "Something went wrong"));
    }
  }

  Future<Either<BookModel, ResponseModel>> updateBook(BookModel book) async {
    try {
      final response =
          await http.put(Uri.parse('$_baseUrl/books/${book.id}'), body: {
        'title': book.title,
        'author': book.author,
      });

      BookModel newBook = BookModel.fromJson(json.decode(response.body));

      return Left(newBook);
    } catch (_) {
      return Right(ResponseModel(message: "Something went wrong"));
    }
  }

  Future<Either<BookModel, ResponseModel>> deleteBook(String id) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/books/$id'));

      BookModel newBook = BookModel.fromJson(json.decode(response.body));

      return Left(newBook);
    } catch (_) {
      return Right(ResponseModel(message: "Something went wrong"));
    }
  }
}
