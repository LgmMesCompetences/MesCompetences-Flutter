import 'dart:async';
import 'package:flutter_api/service/openlibrary.dart';

import 'package:flutter_api/modele/book.dart';
import 'bloc.dart';

class BookBloc extends Bloc {
  late Book? _book;

  //Stream Controller
  final _streamController = StreamController<Book?>();

  //Input
  Sink<Book?> get sink => _streamController.sink;

  //Output
  Stream<Book?> get stream => _streamController.stream;

  //Working logique
  fetchBook(String isbn) async {
    _book = await OpenLibrary().fetchBook(isbn);
    print(_book?.language);
    sink.add(_book);
  }

  Book? get book => _book;

  //Closing
  @override
  dispose() => _streamController.close();
}
