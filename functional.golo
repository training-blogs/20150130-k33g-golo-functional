module func.Tional

struct T = {
  value,
  error
}

function main = |args| {
    let a = T()
    a: value(5): error(null)
    let b = T(42, null)

    println(a)
    println(b)
}
