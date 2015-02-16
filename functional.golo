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

  # surcharge de getOrElse
  function getOrElse = |this, replacementIfNull, replacementIfError| {
    if this: error() isnt null {
      if replacementIfError oftype java.lang.invoke.DirectMethodHandle.class {
        return replacementIfError(this)
      }
      return replacementIfError
    } else {
      if this: value() is null {
        if replacementIfNull oftype java.lang.invoke.DirectMethodHandle.class {
          return replacementIfNull(this)
        }
        return replacementIfNull
      }
      return this: value()
    }
  }
}

function divide = |a, b| {
  let ret = T(null, null)
  try {
    ret: value(a/b)
  } catch (e) {
    ret: error(e)
  } finally {
    return ret
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

    let g = divide(5,0): getOrElse("n/a", "Huston? We've got a problem!")
    # g == "Huston? We've got a problem!"

    println(g)

    let h = divide(5,0): getOrElse("n/a", |instanceOfT| {
      println(instanceOfT: error()) # display "java.lang.ArithmeticException: / by zero"
      return 42
    }) # h == 42

    println(h)
}
