class Book {
  final String writer;
  final String title;
  // final String summary;
  final String audioFile;

  Book({
    required this.writer,
    required this.title,
    // required this.summary,
    required this.audioFile,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      writer: json['writer'] as String,
      title: json['title'] as String,
      // summary: json['summary'] as String,
      audioFile: json['audioFile'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'writer': writer,
      'title': title,
      // 'summary': summary,
      'audioFile': audioFile,
    };
  }
}
