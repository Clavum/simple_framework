import 'package:flutter/material.dart';
import 'package:simple_framework/simple_framework.dart';

enum ServiceModelStatus {
  invalid,
  valid,
  loading,
}

@immutable
abstract class ServiceModel extends RepositoryModel {
  ServiceModelSettings settings() => ServiceModelSettings();

  Future<ServiceModel> load();

  void send() => Repository().sendModel(this);
}

class ServiceModelSettings {}
