abstract class Failure {
  final String message;
  final String? code;
  final dynamic data;

  const Failure({required this.message, this.code, this.data});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.code, super.data});

  factory DatabaseFailure.openError() {
    return const DatabaseFailure(
      message: 'Failed to open the database',
      code: 'DB_OPEN_ERROR',
    );
  }

  factory DatabaseFailure.queryError({String? query}) {
    return DatabaseFailure(
      message: 'Failed to execute query',
      code: 'DB_QUERY_ERROR',
      data: {'query': query},
    );
  }

  factory DatabaseFailure.insertError({String? table}) {
    return DatabaseFailure(
      message: 'Failed to insert data into the database',
      code: 'DB_INSERT_ERROR',
      data: {'table': table},
    );
  }

  factory DatabaseFailure.updateError({String? table}) {
    return DatabaseFailure(
      message: 'Failed to update data in the database',
      code: 'DB_UPDATE_ERROR',
      data: {'table': table},
    );
  }

  factory DatabaseFailure.deleteError({String? table}) {
    return DatabaseFailure(
      message: 'Failed to delete data from the database',
      code: 'DB_DELETE_ERROR',
      data: {'table': table},
    );
  }

  factory DatabaseFailure.unknownError([String? details]) {
    return DatabaseFailure(
      message: 'An unknown database error occurred',
      code: 'DB_UNKNOWN_ERROR',
      data: {'details': details},
    );
  }
}
