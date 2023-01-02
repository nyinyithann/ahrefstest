type item = {"label": string, "value": string}

type common_props = {"clearValue": unit => unit, "getValue": unit => item, "hasValue": bool}
type inner_props = { "innerProps" : common_props }

@deriving(abstract)
type comps = {
  @optional @as("DropdownIndicator")
  dropdownIndicator: Js.Nullable.t<React.componentLike<inner_props, React.element>>,
  @optional @as("Placeholder") placeholder: Js.Nullable.t<React.componentLike<inner_props, React.element>>,
}

@module("react-select") @react.component
external make: (
  ~multi: bool,
  ~options: array<item>=?,
  ~value: item=?,
  ~components: comps=?,
) => React.element = "default"
