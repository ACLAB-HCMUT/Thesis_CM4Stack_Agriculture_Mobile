import 'main_common.dart';
import 'firebase_options_staging.dart';

Future<void> main() async {
  await mainCommon(
    flavor: 'Staging',
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
