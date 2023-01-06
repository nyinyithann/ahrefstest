let {string} = module(React)

@react.component
let make = () => {
  <div
    style={ReactDOM.Style.make(
      ~display="flex",
      ~justifyContent="center",
      ~alignItems="center",
      ~width="100%",
      ~height="100vh",
      (),
    )}>
    <span style={ReactDOM.Style.make(~display="block", ~fontSize="2rem", ())}>
      {"This page doesn't exist."->string}
    </span>
  </div>
}
