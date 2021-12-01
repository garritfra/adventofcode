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

  def sliding_window([first_depth, second_depth, third_depth | tail]) do
    sum = first_depth + second_depth + third_depth
    sliding_window([second_depth, third_depth] ++ tail, sum, 0)
  end

  def sliding_window([first_depth, second_depth, third_depth | tail], previous_sum, counter) do
    sum = first_depth + second_depth + third_depth
    new_counter = if sum > previous_sum do
      counter + 1
    else
      counter
    end
    sliding_window([second_depth, third_depth] ++ tail, sum, new_counter)
  end

  def sliding_window(rest, previous_sum, counter), do: counter

  @spec second([Integer]) :: Integer
  def second(input) do
    sliding_window(input)
  end
end
