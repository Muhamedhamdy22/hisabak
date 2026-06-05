import 'package:hisabak/Features/Auth/data/dataSource/auth_ds.dart';
import 'package:hisabak/Features/Auth/data/models/LoginResponse.dart';
import 'package:hisabak/core/Api/api_manager.dart';
import 'package:hisabak/core/Api/end_point.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AuthDs)
class AuthDsImpl implements AuthDs{
  ApiManager apiManager;
  AuthDsImpl(this.apiManager);
  @override
  Future<LoginResponse> login(String email, String password) async{
    try{
     var response=await apiManager.post(endpoint: EndPoint.login , data: {
        "email": email,
        "password": password
      });
      return LoginResponse.fromJson(response.data);
    }catch(e){
      rethrow ;
    }
  }
}