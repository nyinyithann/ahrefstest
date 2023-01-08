@react.component
let make = (~className: option<string>=?) => {
  <svg
    ?className
    width="8px"
    height="5px"
    viewBox="0 0 8 5"
    style={ReactDOM.Style.make(
      ~padding="0",
      ~minWidth="8px",
      ~minHeight="5px",
      ~border="0",
      ~borderRadius="0",
      ~boxShadow="0 0 0 0 rgba(0, 0, 0, 0)",
      ~backgroundColor="transparent",
      (),
    )}
    version="1.1"
    xmlns="http://www.w3.org/2000/svg">
    <g id="Landing" stroke="none" strokeWidth="1" fill="none" fillRule="evenodd">
      <g id="Artboard" transform="translate(-286.000000, -197.000000)">
        <g id="Group" transform="translate(185.000000, 186.000000)">
          <g id="Group" transform="translate(101.000000, 9.000000)">
            <rect id="box" x="0" y="0" width="8" height="8" />
            <polygon id="icon" ?className points="0 2 8 2 4 7" />
          </g>
        </g>
      </g>
    </g>
  </svg>
}
