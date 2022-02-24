class Result {}

class Error implements Result {
  dynamic error;

  Error(this.error);
}

class Success<T> implements Result {
  T data;

  Success(this.data);
}
