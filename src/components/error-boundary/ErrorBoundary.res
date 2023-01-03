@module("./ErrorBoundary.module.css") external styles: {..} = "default"
@val @scope(("window", "location")) external reload: unit => unit = "reload"

module Fallback = {
  @react.component
  let make = (~error, ~info: RescriptReactErrorBoundary.info) => {
    let onClick = _ => {
      RescriptReactRouter.push("/")
      reload()
    }
    <div className={styles["main"]}>
      <article
        className={styles["article"]}>
        <header>
          <h2> {"Sorry, something went wrong!"->React.string} </h2>
        </header>
        <nav>
          <p>
            {"Would you try to reload the whole site?"->React.string}
          </p>
          <button
            type_="button"
            onClick>
            {"Reload"->React.string}
          </button>
        </nav>
        <details>
          <summary> {"Details"->React.string} </summary>
          {switch error {
          | Js.Exn.Error(e) =>
            switch Js.Exn.message(e) {
            | Some(msg) =>
              <p>
                {msg->React.string}
              </p>
            | None => React.null
            }
          | _ => React.null
          }}
          <p>
            {`${info.componentStack}`->React.string}
          </p>
        </details>
      </article>
    </div>
  }
}

@react.component
let make = (~children: React.element) => {
  <RescriptReactErrorBoundary fallback={({error, info}) => <Fallback error info />}>
    children
  </RescriptReactErrorBoundary>
}
