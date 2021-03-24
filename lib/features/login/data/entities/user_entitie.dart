import 'package:meta/meta.dart';

/// The user to handle the data
class UserLocal {
  const UserLocal({
    @required this.name,
    @required this.id,
    @required this.token,
  });

  final String id, name, token;
  
  static final fName = 'fName';
  static final fId = 'fId';
  static final fToken = 'fToken';
}
