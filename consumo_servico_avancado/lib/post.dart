// ignore_for_file: prefer_final_fields, unnecessary_getters_setters

class Post {
  int _userId;
  int _id;
  String _title;
  String _body;

  Post(
    this._userId,
    this._id,
    this._title,
    this._body,
  );

  Map toJson() {
    return {"userId": _userId, "id": _id, "title": _title, "body": _body};
  }

  String get body => _body;
  String get title => _title;
  int get userId => _userId;
  int get id => _id;

  set body(String value) {
    _body = value;
  }

  set title(String value) {
    _title = value;
  }

  set userId(int value) {
    _userId = value;
  }

  set id(int value) {
    _id = value;
  }
}
