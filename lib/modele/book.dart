class Book {
  late String isbn;
  late String title;
  late String? language;

  Book.fromJSON(Map json) {
    isbn = json['isbn_13'][0];
    title = json['title'];
    language = json['language'];
  }
}
