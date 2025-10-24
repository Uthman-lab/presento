// Flutter & Dart
export 'package:flutter/material.dart';
export 'package:flutter/foundation.dart' hide kIsWasm;

// State Management
export 'package:flutter_bloc/flutter_bloc.dart';

// Routing
export 'package:go_router/go_router.dart';

// Dependency Injection
export 'package:get_it/get_it.dart';

// Firebase
export 'package:firebase_auth/firebase_auth.dart' hide User;
export 'package:cloud_firestore/cloud_firestore.dart' hide kIsWasm, Order;
export 'package:firebase_core/firebase_core.dart';

// Storage & Network
export 'package:shared_preferences/shared_preferences.dart';
export 'package:connectivity_plus/connectivity_plus.dart';

// Functional Programming
export 'package:dartz/dartz.dart' hide State, Order;
export 'package:equatable/equatable.dart';

// Additional imports
export 'dart:convert';
export 'package:intl/intl.dart' hide TextDirection;
