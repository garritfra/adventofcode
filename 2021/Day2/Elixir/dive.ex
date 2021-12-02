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

  def dive_aimed(input) do
    dive_aimed(input, {0, 0, 0})
  end

  def dive_aimed([], {depth, horizontal, _}), do: depth * horizontal

  def dive_aimed(["forward", amount_str | tail], {depth, horizontal, aim}) do
    amount = String.to_integer amount_str
    dive_aimed(tail, {depth + aim * amount, horizontal + amount, aim})
  end

  def dive_aimed(["down", amount_str | tail], {depth, horizontal, aim}) do
    amount = String.to_integer amount_str
    dive_aimed(tail, {depth, horizontal, aim + amount})
  end

  def dive_aimed(["up", amount_str | tail], {depth, horizontal, aim}) do
    amount = String.to_integer amount_str
    dive_aimed(tail, {depth, horizontal, aim - amount})
  end

  @spec second() :: Integer
  def second() do
    Dive.load_file
    |> dive_aimed
  end
end
