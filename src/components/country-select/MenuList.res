@module("./MenuList.module.css") external styles: {..} = "default"

module IntCmp = Belt.Id.MakeComparable({
  type t = int
  let cmp = (a, b) => Int32.compare(a, b)
})

type props = {isFocused: bool}
@get external getProps: React.element => props = "props"
@send external scrollToItem: (Dom.element, int) => unit = "scrollToItem"
@send external resetAfterIndex: (Dom.element, int) => unit = "resetAfterIndex"

module MenuItem = {
  @react.component
  let make = (~index, ~setMeasuredHeight, ~child) => {
    let ref = React.useRef(Js.Nullable.null)
    React.useLayoutEffect1(() => {
      switch ref.current->Js.Nullable.toOption {
      | Some(c) => {
          let h = Webapi__Dom.Element.getBoundingClientRect(c)->Webapi__Dom.DomRect.height
          if !Js.Float.isNaN(h) {
            setMeasuredHeight(index, Belt.Float.toInt(h))
          }
        }

      | None => ()
      }

      None
    }, [ref.current])
    <div ref={ReactDOM.Ref.domRef(ref)}> {child} </div>
  }
}

let getCurrentIndex = (rows: array<React.element>) => {
  rows->Belt.Array.getIndexBy(x => getProps(x).isFocused)->Belt.Option.getWithDefault(0)
}

let makeMenuList = (props: ReactSelect.Select.menuListProps) => {
  let rows = React.useMemo1(() => React.Children.toArray(props.children), [props.children])

  /* Js.log("props") */
  /* Js.log(props) */
  /* Js.log("props.children") */
  /* Js.log(props.children) */
  /* let child = rows[0] */
  /* Js.log(getProps(child)) */
  /* Js.log(getCurrentIndex(rows)) */

  let currentIndex = React.useMemo1(() => getCurrentIndex(rows), [rows])

  let (measuredHeights, setMeasuredHeights) = React.useState(_ => Belt.Map.make(~id=module(IntCmp)))

  let list = React.useRef(Js.Nullable.null)

  let setMeasuredHeight = (index, measuredHeight) => {
    if measuredHeights->Belt.Map.getWithDefault(index, -1) != measuredHeight {
      setMeasuredHeights(prev => Belt.Map.set(prev, index, measuredHeight))
      switch Js.Nullable.toOption(list.current) {
      | Some(l) => resetAfterIndex(l, index)
      | None => ()
      }
    }
  }

  React.useEffect1(() => {
    setMeasuredHeights(_ => Belt.Map.make(~id=module(IntCmp)))
    None
  }, [rows])

  React.useEffect3(() => {
    switch Js.Nullable.toOption(list.current) {
    | Some(l) =>
      if currentIndex > 0 {
        scrollToItem(l, currentIndex)
      }
    | None => ()
    }
    None
  }, (currentIndex, rows, list))

  <div className={styles["main"]}>
    <ReactWindow.List
      width={Util.NumberOrString.int(300)}
      height={Util.NumberOrString.int(200)}
      itemCount={rows->Array.length}
      itemSize={index => measuredHeights->Belt.Map.get(index)->Belt.Option.getWithDefault(25)}
      ref={ReactDOM.Ref.domRef(list)}>
      {({index, style}) => {
        <div key={string_of_int(index)} style>
          <MenuItem index setMeasuredHeight child={rows[index]} />
        </div>
      }}
    </ReactWindow.List>
  </div>
}
