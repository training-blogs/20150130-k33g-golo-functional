module func.Tional

struct T = {
  value,
  error
}

augment T {
  function getOrElse = |this, replacementIfNull| {
    if this: value() is null {
      if replacementIfNull oftype java.lang.invoke.DirectMethodHandle.class {
        return replacementIfNull(this)
      }
      return replacementIfNull
    }
    return this: value()
  }
}

function main = |args| {
    let a = T()
    a: value(5): error(null)
    let b = T(42, null)

    println(a)
    println(b)

    let c = T(null, null)
    let d = c: getOrElse("n/a") # d == "n/a"

    println(c)
    println(d)

    let e = T(null, null)
    let f = e: getOrElse(|instanceOfT| {
      println("Argh! f is null")
      return 42
    }) # f == 42

    println(e)
    println(f)
}
