import 'dart:async';

import 'package:flutter/foundation.dart';

/// Adapta un Stream a Listenable para el refreshListenable de go_router.
class StreamListenable extends ChangeNotifier {
  StreamListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  void notify() => notifyListeners();

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
