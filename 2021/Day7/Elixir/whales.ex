ExUnit.start()

defmodule Whales do
  def load_file(path) do
    File.read!(path)
    |> String.split(",", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  def distance_to(a, b), do: abs(a - b)

  def increasing_distance_to(a, b) do
    1..abs(a - b)
    |> Enum.to_list()
    |> Enum.sum()
  end

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

  def find_new_cheapest_route(positions),
    do: find_new_cheapest_route(positions, Enum.min(positions), nil)

  def find_new_cheapest_route(positions, target, cheapest) do
    # This takes a while, so we add debug output
    IO.inspect(target, label: "Target")
    IO.inspect(Enum.count(positions), label: "Positions")

    if target >= Enum.count(positions) + 1 do
      cheapest
    else
      current =
        if target == Enum.max(positions) + 1 do
          cheapest
        else
          positions
          |> Enum.map(fn position -> increasing_distance_to(position, target) end)
          |> Enum.sum()
        end

      new_cheapest =
        if current < cheapest do
          current
        else
          cheapest
        end

      find_new_cheapest_route(positions, target + 1, new_cheapest)
    end
  end

  @spec first() :: Integer
  def first() do
    positions = load_file("../input.txt")
    find_cheapest_route(positions)
  end

  @spec second() :: Integer
  def second() do
    positions = load_file("../input.txt")
    find_new_cheapest_route(positions)
  end
end

defmodule WhalesTest do
  use ExUnit.Case
end
