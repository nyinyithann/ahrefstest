open Util

type childRenderProps = {data: array<React.element>, index: int, style: ReactDOM.Style.t}

type innerProps = {
    children: React.element,
    style: ReactDOM.Style.t
}

type innerElementType = React.componentLike<innerProps, React.element> 

module List = {
  @module("react-window") @react.component
  external make: (
    ~className: string=?,
    ~width: NumberOrString.t,
    ~height: NumberOrString.t,
    ~itemCount: int,
    ~itemSize: int => int,
    ~innerElementType: innerElementType=?,
    ~initialScrollOffset: int=?,
    ~estimatedItemSize: int=?,
    ~ref: ReactDOM.domRef=?,
    ~outerRef: ReactDOM.domRef=?,
    ~overscanCount: int=?,
    ~itemData: array<React.element>,
    ~children: childRenderProps => React.element,
  ) => React.element = "VariableSizeList"
} 
