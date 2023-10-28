/// エラーがあれば String 型のエラーを返し、なければ null を返す
typedef StringError = String?;

/// エラーがあれば String 型のエラーを返し、なければ null を返すバリデーション関数
typedef StringErrorValidator = StringError Function(String? value);
