class AddNewException implements Exception {
  final String message;

  AddNewException(
    this.message,
  );
}

class NoConnectionException extends AddNewException {
  NoConnectionException() : super('Sem conexão');
}

class FieldsRequiredException extends AddNewException {
  FieldsRequiredException()
      : super(
            'Perguntas obrigatórios não respondidas. Por favor revise o formulário.');
}

class NoResponseException extends AddNewException {
  NoResponseException()
      : super(
            'Não consegui encontrar um layout que atendesse as suas expectativas, por favor tente novamente.');
}
