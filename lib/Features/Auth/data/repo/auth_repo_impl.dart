import 'package:hisabak/Features/Auth/data/dataSource/auth_ds.dart';
import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/Features/Auth/domin/repo/auth_repo.dart';
import 'package:hisabak/core/Api/error_handling.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo{
  AuthDs authDs;
  AuthRepoImpl(this.authDs);
  @override
  Future<LoginResponse> login(String email, String password) async{
   try{
    var response =await authDs.login(email, password);
    return response;
   }catch (e){
     throw AuthFailedException("UserName or Password is incorrect");
   }
  }
}