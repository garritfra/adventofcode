ExUnit.start()

defmodule Whales do
  def load_file(path) do
    File.read!(path)
    |> String.split(",", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  def distance_to(a, b), do: abs(a - b)

  def find_cheapest_route(positions),
    do: find_cheapest_route(positions, Enum.min(positions), nil)

  def find_cheapest_route(positions, target, cheapest) do
    if target == Enum.max(positions) + 1 do
      cheapest
    else
      current =
        if target == Enum.max(positions) + 1 do
          cheapest
        else
          positions
          |> Enum.map(fn position -> distance_to(position, target) end)
          |> Enum.sum()
        end

      new_cheapest =
        if current < cheapest do
          current
        else
          cheapest
        end

      find_cheapest_route(positions, target + 1, new_cheapest)
    end
  end

  @spec first() :: Integer
  def first() do
    positions = load_file("../input.txt")
    find_cheapest_route(positions)
  end

  @spec second() :: Integer
  def second() do
  end
end

defmodule WhalesTest do
  use ExUnit.Case
end
