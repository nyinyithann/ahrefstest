module Root = {
  type t

  @send external render: (t, React.element) => unit = "render"
}

@module("react-dom/client")
external createRoot: Dom.element => Root.t = "createRoot"

module Suspense = {
  @module("react") @react.component
  external make: (~fallback: React.element, ~children: React.element, unit) => React.element =
    "Suspense"
}

module Lazy = {
  @val
  external import_: string => Js.Promise.t<{"make": React.component<unit>}> = "import"

  @module("react")
  external lazy_: (unit => Js.Promise.t<{"default": React.component<unit>}>) => React.component<
    unit,
  > = "lazy"
}
