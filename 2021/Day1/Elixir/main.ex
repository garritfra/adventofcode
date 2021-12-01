# iex()> Day1.load_file |> Day1.first

defmodule Day1 do
  def load_file() do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn n -> Integer.parse(n) end)
    |> Enum.map(fn tup -> Kernel.elem(tup, 0) end)
  end

  @spec first([Integer]) :: Integer
  def first(input) do
    Enum.zip(0..length(input), input)
    |> Enum.reduce(0, fn ({index, distance}, acc) ->
      case index - 1 do
        -1 ->
          0
        previousIndex ->
          previous = Enum.at(input, previousIndex)
          if distance > previous do
            acc + 1
          else
            acc
          end
      end
    end)
  end

  @spec second([Integer]) :: Integer
  def second(input) do
    :second
  end
end
