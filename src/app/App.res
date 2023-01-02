@module("./App.module.css") external styles: {..} = "default"

let {string, useState} = module(React)

@react.component
let make = () => {
  open ReactBinding
  let lazyHome = React.createElement(
    Lazy.lazy_(() =>
      Lazy.import_("../pages/home/Home.js")->Js.Promise.then_(
        comp => Js.Promise.resolve({"default": comp["make"]}),
        _,
      )
    ),
    (),
  )

  let url = RescriptReactRouter.useUrl()
  let component = switch url.path {
  | list{} => <SuspensionLoader> lazyHome </SuspensionLoader>
  | _ => <NotFound />
  }

  <main className={styles["main"]}>
    <ErrorBoundary>
      <div className={styles["page-container"]}> {component} </div>
    </ErrorBoundary>
  </main>
}
