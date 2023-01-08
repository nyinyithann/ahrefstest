%%raw(`import '../style/main.css'`)

ReactDOM.querySelector("#root")->(
  rootElm =>
    switch rootElm {
    | Some(rootElm) => {
        let root = ReactBinding.createRoot(rootElm)
        ReactBinding.Root.render(root, <App />)
      }

    | None => Js.Console.error("Failed to start React: couldn't find the #root element")
    }
)
