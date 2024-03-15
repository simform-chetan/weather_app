// Mocks generated by Mockito 5.4.4 from annotations
// in weather_app/test/unit_test_cases/current_weather/data/current_weather_repo_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:hive/hive.dart' as _i2;
import 'package:http/http.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:weather_app/core/api_helper.dart' as _i3;
import 'package:weather_app/core/db_helper.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDuration_0 extends _i1.SmartFake implements Duration {
  _FakeDuration_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBox_1<E> extends _i1.SmartFake implements _i2.Box<E> {
  _FakeBox_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [APIHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockAPIHelper extends _i1.Mock implements _i3.APIHelper {
  MockAPIHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  Duration get timeout => (super.noSuchMethod(
        Invocation.getter(#timeout),
        returnValue: _FakeDuration_0(
          this,
          Invocation.getter(#timeout),
        ),
      ) as Duration);

  @override
  _i5.Future<Map<String, dynamic>> get(
    String? endUrl, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [endUrl],
          {
            #headers: headers,
            #queryParameters: queryParameters,
          },
        ),
        returnValue:
            _i5.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i5.Future<Map<String, dynamic>>);

  @override
  _i5.Future<Map<String, dynamic>> post(
    String? endPoint, {
    Map<dynamic, dynamic>? body,
    Map<String, String>? queryParameters,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [endPoint],
          {
            #body: body,
            #queryParameters: queryParameters,
          },
        ),
        returnValue:
            _i5.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i5.Future<Map<String, dynamic>>);

  @override
  Map<String, dynamic> validateAndParseResponse(_i6.Response? response) =>
      (super.noSuchMethod(
        Invocation.method(
          #validateAndParseResponse,
          [response],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
}

/// A class which mocks [DbHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDbHelper<T> extends _i1.Mock implements _i7.DbHelper<T> {
  MockDbHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get name => (super.noSuchMethod(
        Invocation.getter(#name),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#name),
        ),
      ) as String);

  @override
  _i2.Box<T> get database => (super.noSuchMethod(
        Invocation.getter(#database),
        returnValue: _FakeBox_1<T>(
          this,
          Invocation.getter(#database),
        ),
      ) as _i2.Box<T>);

  @override
  set database(_i2.Box<T>? _database) => super.noSuchMethod(
        Invocation.setter(
          #database,
          _database,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> initializeBox() => (super.noSuchMethod(
        Invocation.method(
          #initializeBox,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> write({
    required String? key,
    required T? data,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #write,
          [],
          {
            #key: key,
            #data: data,
          },
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<dynamic> read({
    required String? key,
    T? defaultData,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [],
          {
            #key: key,
            #defaultData: defaultData,
          },
        ),
        returnValue: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);

  @override
  _i5.Future<void> delete({required String? key}) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {#key: key},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> reset() => (super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  _i5.Future<void> dispose() => (super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}