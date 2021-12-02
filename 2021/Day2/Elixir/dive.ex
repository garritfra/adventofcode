# iex()> Day1.first

defmodule Dive do
  def load_file() do
    File.read!("../input.txt")
    |> String.replace(" ", "\n")
    |> String.split("\n", trim: true)
  end

  def dive(input) do
    dive(input, {0, 0})
  end

  def dive([], {depth, horizontal}), do: depth * horizontal

  def dive(["forward", amount_str | tail], {depth, horizontal}) do
    amount = String.to_integer amount_str
    dive(tail, {depth, horizontal + amount})
  end

  def dive(["down", amount_str | tail], {depth, horizontal}) do
    amount = String.to_integer amount_str
    dive(tail, {depth + amount, horizontal})
  end

  def dive(["up", amount_str | tail], {depth, horizontal}) do
    amount = String.to_integer amount_str
    dive(tail, {depth - amount, horizontal})
  end

  @spec first() :: Integer
  def first() do
    Dive.load_file
    |> dive
  end

  @spec second([Integer]) :: Integer
  def second(input) do
    :second
  end
end
