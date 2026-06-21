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
import 'Features/add_customer/data/datasource/customar_ds_impl.dart' as _i63;
import 'Features/add_customer/data/datasource/customer_ds.dart' as _i1057;
import 'Features/add_customer/data/repo/customer_repo_impl.dart' as _i72;
import 'Features/add_customer/domain/repo/customar_repo.dart' as _i646;
import 'Features/add_customer/domain/usecase/customar_use_case.dart' as _i638;
import 'Features/add_customer/presentation/bloc/customer_bloc.dart' as _i241;
import 'Features/AddTransaction/data/datasource/transaction_ds.dart' as _i964;
import 'Features/AddTransaction/data/datasource/transaction_ds_impl.dart'
    as _i495;
import 'Features/AddTransaction/data/repo/transaction_repo_impl.dart' as _i637;
import 'Features/AddTransaction/domain/repo/transaction_repo.dart' as _i13;
import 'Features/AddTransaction/domain/usecase/transaction_use_case.dart'
    as _i933;
import 'Features/AddTransaction/presentation/bloc/transaction_bloc.dart'
    as _i476;
import 'Features/Auth/data/dataSource/auth_ds.dart' as _i998;
import 'Features/Auth/data/dataSource/auth_ds_impl.dart' as _i233;
import 'Features/Auth/data/repo/auth_repo_impl.dart' as _i883;
import 'Features/Auth/domin/repo/auth_repo.dart' as _i559;
import 'Features/Auth/domin/usecase/login_use_case.dart' as _i48;
import 'Features/Auth/domin/usecase/register_use_case.dart' as _i111;
import 'Features/Auth/presentation/bloc/auth_bloc.dart' as _i11;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i795.ApiManager>(() => _i795.ApiManager());
    gh.factory<_i964.TransactionDs>(
      () => _i495.TransactionDsImpl(gh<_i795.ApiManager>()),
    );
    gh.factory<_i1057.CustomerDs>(
      () => _i63.CustomerDsImpl(gh<_i795.ApiManager>()),
    );
    gh.factory<_i13.TransactionRepo>(
      () => _i637.TransactionRepoImpl(gh<_i964.TransactionDs>()),
    );
    gh.factory<_i998.AuthDs>(() => _i233.AuthDsImpl(gh<_i795.ApiManager>()));
    gh.factory<_i646.CustomerRepo>(
      () => _i72.CustomerRepoImpl(gh<_i1057.CustomerDs>()),
    );
    gh.factory<_i559.AuthRepo>(() => _i883.AuthRepoImpl(gh<_i998.AuthDs>()));
    gh.factory<_i933.GetTransactionsUseCase>(
      () => _i933.GetTransactionsUseCase(gh<_i13.TransactionRepo>()),
    );
    gh.factory<_i933.AddTransactionUseCase>(
      () => _i933.AddTransactionUseCase(gh<_i13.TransactionRepo>()),
    );
    gh.factory<_i933.DeleteTransactionUseCase>(
      () => _i933.DeleteTransactionUseCase(gh<_i13.TransactionRepo>()),
    );
    gh.factory<_i638.GetCustomersUseCase>(
      () => _i638.GetCustomersUseCase(gh<_i646.CustomerRepo>()),
    );
    gh.factory<_i638.CreateCustomerUseCase>(
      () => _i638.CreateCustomerUseCase(gh<_i646.CustomerRepo>()),
    );
    gh.factory<_i638.DeleteCustomerUseCase>(
      () => _i638.DeleteCustomerUseCase(gh<_i646.CustomerRepo>()),
    );
    gh.factory<_i48.LoginUseCase>(
      () => _i48.LoginUseCase(gh<_i559.AuthRepo>()),
    );
    gh.factory<_i111.RegisterUseCase>(
      () => _i111.RegisterUseCase(gh<_i559.AuthRepo>()),
    );
    gh.factory<_i11.AuthBloc>(
      () => _i11.AuthBloc(gh<_i48.LoginUseCase>(), gh<_i111.RegisterUseCase>()),
    );
    gh.factory<_i476.TransactionBloc>(
      () => _i476.TransactionBloc(
        gh<_i933.GetTransactionsUseCase>(),
        gh<_i933.AddTransactionUseCase>(),
        gh<_i933.DeleteTransactionUseCase>(),
      ),
    );
    gh.factory<_i241.CustomersBloc>(
      () => _i241.CustomersBloc(
        gh<_i638.GetCustomersUseCase>(),
        gh<_i638.CreateCustomerUseCase>(),
        gh<_i638.DeleteCustomerUseCase>(),
      ),
    );
    return this;
  }
}
