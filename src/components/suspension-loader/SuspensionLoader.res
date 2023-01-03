open ReactBinding
@react.component
let make = (~children) => {
  <Suspense fallback={<Loader className="loading" />}> {children} </Suspense>
}
