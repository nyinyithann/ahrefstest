type props<'a> = {data: 'a}

type menuListProps = {
  children: React.element,
  maxHeight: int,
  hasValue: bool,
  innerRef: ReactDOM.Ref.t,
}

@deriving(abstract)
type components = {
  @as("DropdownIndicator")
  dropdownIndicatorComp: React.component<{.}>,
  @as("ValueContainer")
  valueContainerComp: React.component<{.}>,
  @as("Option")
  optionComp: React.component<props<ViewModel.country>>,
  @as("MenuList")
  menuListComp: React.component<menuListProps>,
  @as("NoOptionsMessage")
  noOptionsMessageCom: React.component<{.}>,
}

@module("react-select")
external components: components = "components"

type filterOption
type filterConfig = {ignoreAccents: bool}
@module("react-select") @val
external createFilter: filterConfig => filterOption = "createFilter"

@deriving(abstract)
type customComponents = {
  @optional @as("DropdownIndicator")
  dropdownIndicator: Js.Nullable.t<React.componentLike<{.}, React.element>>,
  @optional @as("ValueContainer")
  valueContainer: React.componentLike<{.}, React.element>,
  @optional @as("Option")
  option: React.componentLike<props<ViewModel.country>, React.element>,
  @optional @as("MenuList")
  menuList: React.componentLike<menuListProps, React.element>,
  @optional @as("NoOptionsMessage")
  noOptionsMessage: React.componentLike<{.}, React.element>,
}

type styler = ReactDOM.Style.t => ReactDOM.Style.t

@deriving(abstract)
type injectedStyles = {
  @optional
  menu: styler,
  @optional
  control: styler,
  @optional
  option: styler,
}

@module("react-select") @react.component
external make: (
  ~classNamePrefix: string=?,
  ~multi: bool,
  ~autoFocus: bool=?,
  ~backspaceRemovesValue: bool=?,
  ~controlShouldRenderValue: bool=?,
  ~hideSelectedOptions: bool=?,
  ~isClearable: bool=?,
  ~menuIsOpen: bool=?,
  ~ignoreAccents: bool=?,
  ~tabSelectsValue: bool=?,
  ~className: string=?,
  ~captureMenuScroll: bool=?,
  ~filterOption: filterOption=?,
  ~isLoading: bool=?,
  ~options: array<ViewModel.country>=?,
  ~value: ViewModel.country=?,
  ~placeholder: string=?,
  ~components: customComponents=?,
  ~styles: injectedStyles=?,
  ~onChange: Js.Nullable.t<'a> => unit,
) => React.element = "default"
