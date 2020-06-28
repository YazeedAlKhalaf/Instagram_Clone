// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:instagram_clone/src/app/services/authentication_service.dart';
import 'package:instagram_clone/src/app/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:instagram_clone/src/app/services/firestore_service.dart';
import 'package:instagram_clone/src/app/services/storage_service.dart';
import 'package:instagram_clone/src/app/utils/utils.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<FirestoreService>(() => FirestoreService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  g.registerLazySingleton<StorageService>(() => StorageService());
  g.registerLazySingleton<Utils>(() => Utils());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
