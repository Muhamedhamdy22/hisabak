// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/Api/api_manager.dart' as _i795;
import 'Features/Auth/data/dataSource/auth_ds.dart' as _i998;
import 'Features/Auth/data/dataSource/auth_ds_impl.dart' as _i233;
import 'Features/Auth/data/repo/auth_repo_impl.dart' as _i883;
import 'Features/Auth/domin/repo/auth_repo.dart' as _i559;
import 'Features/Auth/domin/usecase/login_use_case.dart' as _i48;
import 'Features/Auth/presentation/bloc/auth_bloc.dart' as _i11;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i795.ApiManager>(() => _i795.ApiManager());
    gh.factory<_i998.AuthDs>(() => _i233.AuthDsImpl(gh<_i795.ApiManager>()));
    gh.factory<_i559.AuthRepo>(() => _i883.AuthRepoImpl(gh<_i998.AuthDs>()));
    gh.factory<_i48.LoginUseCase>(
      () => _i48.LoginUseCase(gh<_i559.AuthRepo>()),
    );
    gh.factory<_i11.AuthBloc>(() => _i11.AuthBloc(gh<_i48.LoginUseCase>()));
    return this;
  }
}
