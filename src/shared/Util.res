module NumberOrString = {
  @unboxed type rec t = Any('a): t
  let string = (v: string) => Any(v)
  let int = (v: int) => Any(v)
}

let debounce = (fn, delay) => {
  let id: ref<option<Js.Global.timeoutId>> = ref(None)
  () => {
    switch id.contents {
    | Some(tid) => Js.Global.clearTimeout(tid)
    | None => ()
    }
    id := Some(Js.Global.setTimeout(() => {
          fn()
        }, delay))
  }
}

let throttle = (fn, delay) => {
    let tick = ref(false)
    () => {
        if !(tick.contents) {
            fn()
            tick := true
            Js.Global.setTimeout(() => {
                 tick := false
            }, delay) -> ignore
        }
    }
}
