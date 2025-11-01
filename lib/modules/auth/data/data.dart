import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:presento/imports.dart';
import 'package:presento/modules/institution/institution.dart'
    show InstitutionRole, InstitutionRoleModel;
import '../../../core/utils/helper_functions.dart';
import '../domain/domain.dart';

part 'datasources/auth_local_data_source.dart';
part 'datasources/auth_remote_data_source.dart';
part 'models/user_model.dart';
part 'repositories/auth_repository_impl.dart';
