
import 'main_common.dart';
import 'firebase_options_prod.dart'; // Generated later

Future<void> main() async {
  await mainCommon(
    flavor: 'Production',
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
