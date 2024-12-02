import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

fn read_file(path: String) -> List(String) {
  case simplifile.read(from: path) {
    Ok(contents) -> contents |> string.split("\n")
    Error(_) -> [""]
  }
}

pub fn main() {
  //part_1() |> io.println
  part_2() |> io.println
}

fn part_1() -> String {
  let contents = read_file("./src/input")
  let left_list = left(contents)
  let right_list = right(contents)

  let zipped = list.zip(left_list |> list.sort(by: int.compare), right_list |> list.sort(by: int.compare))

  let assert Ok(sum) = zipped
  |> list.map(fn(x) { int.absolute_value(x.0 - x.1) })
  |> list.reduce(fn(acc, x) { acc + x })
  
  sum |> int.to_string
}

fn part_2() -> String {
  let contents = read_file("./src/input")
  let left_list = left(contents)
  let right_list = right(contents)

  let assert Ok(sum) = left_list
  |> list.map(fn(x) { x * list.count(right_list, fn(y) { y == x })})
  |> list.reduce(fn(acc, x) { acc + x })

  sum |> int.to_string
}

fn left(list: List(String)) -> List(Int) {
  list
  |> list.map(split)
  |> list.map(fn(x) { x.0 })
}

fn right(list: List(String)) -> List(Int) {
  list
  |> list.map(split)
  |> list.map(fn(x) { x.1 })
}

fn split(line: String) -> #(Int, Int) {
  let result = case line |> string.trim |> string.split_once("   ") {
    Ok(strs) -> strs
    Error(_) -> #("0", "0")
  }

  let assert Ok(first) = result.0 |> string.trim |> int.parse
  let assert Ok(second) = result.1 |> string.trim |> int.parse
  #(first, second)
}

