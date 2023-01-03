type item = {"label": string, "value": string}

@deriving(abstract)
type comps_type = {
  @as("DropdownIndicator")
  dropdownIndicatorComp: React.component<{.}>,
  @as("ValueContainer")
  valueContainerComp: React.component<{.}>,
  @as("Option")
  optionComp: React.component<{.}>,
}

@module("react-select")
external components: comps_type = "components"

@deriving(abstract)
type comps = {
  @optional @as("DropdownIndicator")
  dropdownIndicator: Js.Nullable.t<React.componentLike<{.}, React.element>>,
  @optional @as("ValueContainer")
  valueContainer: React.componentLike<{.}, React.element>,
  @optional @as("Option")
  option: React.componentLike<{.}, React.element>,
}

@module("react-select") @react.component
external make: (
  ~multi: bool,
  ~options: array<item>=?,
  ~value: item=?,
  ~placeholder: string=?,
  ~components: comps=?,
) => React.element = "default"
