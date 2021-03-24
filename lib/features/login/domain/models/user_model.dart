import 'package:demo_videocalling/features/login/data/entities/user_entitie.dart';
import 'package:meta/meta.dart';

// Use this to get the data
class UserLocalModel extends UserLocal {
  
  const UserLocalModel(
      {@required String id, @required String token, @required String name})
      : super(
          id: id,
          token: token,
          name: name,
        );
  
  factory UserLocalModel.fromJson(Map<String, dynamic> json) {
    return UserLocalModel(
      id: json[UserLocal.fId],
      name: json[UserLocal.fName],
      token: json[UserLocal.fToken],
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      UserLocal.fId : id,
      UserLocal.fName : name,
      UserLocal.fToken : token,
    };
    return json;
  }
}
