// Mocks generated by Mockito 5.4.4 from annotations
// in weather_app/test/unit_test_cases/search_city/domain/search_city_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:weather_app/core/result_state_template.dart' as _i2;
import 'package:weather_app/features/search_city/data/models/search_city_request_dm.dart'
    as _i5;
import 'package:weather_app/features/search_city/domain/repositories/search_city_repo.dart'
    as _i3;

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

class _FakeResultState_0<T> extends _i1.SmartFake
    implements _i2.ResultState<T> {
  _FakeResultState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchCityRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchCityRepo extends _i1.Mock implements _i3.SearchCityRepo {
  MockSearchCityRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ResultState<dynamic>> searchCity(
          _i5.SearchCityRequestDm? requestDm) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchCity,
          [requestDm],
        ),
        returnValue: _i4.Future<_i2.ResultState<dynamic>>.value(
            _FakeResultState_0<dynamic>(
          this,
          Invocation.method(
            #searchCity,
            [requestDm],
          ),
        )),
      ) as _i4.Future<_i2.ResultState<dynamic>>);
}
