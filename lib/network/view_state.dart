class ViewState<T> {
  Status status;

  T? data;

  String? message;

  Type? type;

  ViewState.loading() : status = Status.kLoading;

  ViewState.completed(this.data) : status = Status.kCompleted;

  ViewState.error(this.message, this.type) : status = Status.kError;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { kLoading, kCompleted, kError }

enum Type { kConnection, kOther }
