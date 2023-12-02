part of '../core.dart';

enum ServiceModelStatus {
  invalid,
  valid,
  loading,
}

@immutable
abstract class ServiceModel extends Model with RepositoryModel {
  const ServiceModel();

  ServiceModelSettings settings() => ServiceModelSettings();

  Future<ServiceModel> load();

  void send() => Repository().sendModel(this);
}

class ServiceModelSettings {}
