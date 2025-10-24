library auth_data;

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:task_master_tot/imports.dart';
import 'package:task_master_tot/core/core.dart';
import '../domain/domain.dart';

part 'datasources/auth_local_data_source.dart';
part 'datasources/auth_remote_data_source.dart';
part 'models/institution_role_model.dart';
part 'models/user_model.dart';
part 'repositories/auth_repository_impl.dart';
