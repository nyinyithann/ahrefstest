type item = {"label": string, "value": string}

type common_props = {"clearValue": unit => unit, "getValue": unit => item, "hasValue": bool}

type comps = {"DropdownIndicator": option<React.component<common_props>>}

@module("react-select") @react.component
external make: (
  ~multi: bool,
  ~options: array<item>=?,
  ~value: item=?,
  ~components: comps=?,
) => React.element = "default"
