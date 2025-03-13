import 'main_common.dart';
import 'firebase_options_dev.dart';

Future<void> main() async {
  await mainCommon(
    flavor: 'dev',
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}