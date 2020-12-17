abstract class Usecase<Params, Result> {
  const Usecase();

  Result call(Params params);
}
