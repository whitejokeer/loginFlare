import 'dart:convert';

class User {

  ///This are the variables been passing by the json_structure that
  ///matter for the app logic.
  String name, picture, profile;
  int id;
  List<dynamic> lids;

  ///This helps to transform the json into a user Map structure for
  ///a fast construction.
  User.map(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        picture = parsedJson['picture'],
        profile = parsedJson['profile'],
        lids = parsedJson['lids'];

  ///Transform the user fields in a map, this is used to pass user info
  ///to the database.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "picture": picture,
      "profile": profile,
      "lids": jsonEncode(lids),
    };
  }

  ///Allow to pass the information of the user from the database to the
  ///User class.
  User.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        picture = parsedJson['picture'],
        profile = parsedJson['profile'],
        lids = jsonDecode(parsedJson['lids']);
}
