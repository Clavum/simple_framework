import 'core/models/entity_test.dart' as entity_test;
import 'core/models/service_model_test.dart' as service_model_test;
import 'core/ui/screen_ref_test.dart' as screen_ref_test;
import 'core/ui/screen_test.dart' as screen_test;
import 'testing/mock_class_provider_test.dart' as mock_class_provider_test;

void main() {
  coreTests();
  testingTests();
}

void coreTests() {
  // Models.
  entity_test.main();
  service_model_test.main();

  // UI.
  screen_ref_test.main();
  screen_test.main();
}

void testingTests() {
  mock_class_provider_test.main();
}
