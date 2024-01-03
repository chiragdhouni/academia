import 'package:fpdart/fpdart.dart';
import 'package:academia/New%20folder/core/failure.dart';


typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = FutureEither<void>;
