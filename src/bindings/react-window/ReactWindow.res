open Util

type childRenderProps = {index: int, style: ReactDOM.Style.t}

module List = {
  @module("react-window") @react.component
  external make: (
    ~width: NumberOrString.t,
    ~height: NumberOrString.t,
    ~itemCount: int,
    ~itemSize: int => int,
    ~ref: ReactDOM.domRef,
    ~outerRef: ReactDOM.domRef=?,
    ~overScanCount: int=?,
    ~itemData: array<React.element>,
    ~children: childRenderProps => React.element,
  ) => React.element = "VariableSizeList"
}
