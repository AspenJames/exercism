import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.fold(<<>>, fn(acc, n) { <<acc:bits, encode_nucleotide(n):2>> })
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  // case dna {
  //   <<>> -> Error(Nil)
  //   <<n:2>> -> decode_nucleotide(n) |> result.map(fn(n) { [n] })
  //   <<n:2, rest:bits>> ->
  //     decode_nucleotide(n)
  //     |> result.try(fn(d) {
  //       decode(rest)
  //       |> result.try(fn(r) { Ok([d, ..r]) })
  //     })
  //   _ -> Error(Nil)
  // }
  do_decode(dna, [])
}

fn do_decode(
  dna: BitArray,
  acc: List(Nucleotide),
) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<>> -> Ok(list.reverse(acc))
    <<n:2, rest:bits>> ->
      decode_nucleotide(n)
      |> result.try(fn(dec) { do_decode(rest, [dec, ..acc]) })
    _ -> Error(Nil)
  }
}
