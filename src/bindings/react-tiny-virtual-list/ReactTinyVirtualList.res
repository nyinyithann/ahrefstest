module NumberOrString = {
  @unboxed type rec t = Any('a): t
  let string = (v: string) => Any(v)
  let int = (v: int) => Any(v)
}

type renderItemParam = {index: int, style: ReactDOM.Style.t}

@module("react-tiny-virtual-list") @react.component
external make: (
  ~width: NumberOrString.t,
  ~height: NumberOrString.t,
  ~itemCount: int,
  ~itemSize: int,
  ~style: ReactDOM.Style.t=?,
  ~renderItem: renderItemParam => React.element,
) => React.element = "default"
