@react.component
let make = (
  ~isOpen: bool,
  ~target: React.element,
  ~children: React.element,
  ~onClose: unit => unit,
) => {
  let shadow = "hsla(218, 50%, 10%, 0.1)"
  let menuStyle = ReactDOM.Style.make(
    ~backgroundColor="white",
    ~borderRadius="2px",
    ~boxShadow=`0 0 0 1px ${shadow}, 0 4px 11px ${shadow}`,
    ~marginTop="4px",
    ~position="absolute",
    ~height="40px",
    ~zIndex="2",
    (),
  )
  let blanketStyle = ReactDOM.Style.make(
    ~bottom="0",
    ~left="0",
    ~top="0",
    ~right="0",
    ~position="fixed",
    ~zIndex="1",
    (),
  )
  <div style={ReactDOM.Style.make(~position="relative", ())}>
    {target}
    {isOpen ? <div style={menuStyle}> children </div> : React.null}
    {isOpen ? <div style={blanketStyle} onClick={_ => onClose()} /> : React.null}
  </div>
}
