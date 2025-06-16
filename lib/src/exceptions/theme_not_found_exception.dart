class DesignSystemModeNotFoundException implements Exception {
  final String message;

  DesignSystemModeNotFoundException(this.message);

  @override
  String toString() => 'DesignSystemModeNotFoundException : $message';
}
