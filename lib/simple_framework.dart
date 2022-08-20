library simple_framework;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:simple_framework/simple_framework.dart';

export 'package:model_generator_annotation/model_generator_annotation.dart';
export 'package:simple_framework/src/core/models/entity.dart';
export 'package:simple_framework/src/core/models/model.dart';
export 'package:simple_framework/src/core/models/service_model.dart';
export 'package:simple_framework/src/core/models/view_model.dart';
export 'package:simple_framework/src/core/repository.dart';
export 'package:simple_framework/src/core/ui/stateless_screen.dart';
export 'package:simple_framework/src/testing/common_test_methods.dart';
export 'package:simple_framework/src/testing/general_helpers.dart';
export 'package:simple_framework/src/testing/mockable.dart';
export 'package:simple_framework/src/testing/mocks/repository_mock.dart';
export 'package:simple_framework/src/testing/test_groups/bloc_test_group.dart';
export 'package:simple_framework/src/testing/test_groups/builder_test.dart';
export 'package:simple_framework/src/testing/test_groups/screen_test_group.dart';
export 'package:simple_framework/src/testing/test_groups/standard_test_group.dart';
export 'package:simple_framework/src/testing/widget_tester_extensions.dart';

part 'src/core/bloc.dart';

part 'src/core/ui/screen.dart';
