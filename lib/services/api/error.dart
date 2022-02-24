class PlanBIMError {
  String errorMessage;
  int errorCode;
  ErrorType errorType;

  PlanBIMError(this.errorCode, this.errorMessage, this.errorType);

  @override
  String toString() {
    return '$errorType Error : ($errorCode)  $errorMessage';
  }

  void addError(Object data) {
    this.errorMessage = errorMessage;
  }
}

enum ErrorType { NORMAL, MINOR, CRITICAL }
