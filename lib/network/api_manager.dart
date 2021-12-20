import 'package:rxdart/rxdart.dart';

import 'app_exception.dart';
import 'view_state.dart';

class ApiManager {
  Stream<ViewState<T>> callApi<T>(Stream source, {customResponse}) {
    return source.map((response) {
      return ViewState<T>.completed(customResponse ?? response);
    }).onErrorReturnWith((error, stack) {
      return ViewState<T>.error(error.toString(),
          error is NoInternetException ? Type.kConnection : Type.kOther);
    }).startWith(ViewState<T>.loading());
  }
}
