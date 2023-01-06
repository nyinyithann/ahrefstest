module NumberOrString = {
  @unboxed type rec t = Any('a): t
  let string = (v: string) => Any(v)
  let int = (v: int) => Any(v)
}
