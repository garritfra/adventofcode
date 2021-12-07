ExUnit.start()

defmodule Lanternfish do
  def load_file() do
    File.read!("../input.txt")
    |> String.split(",", trim: true)
  end

  def parse_swarm(input) do
    input
    |> Enum.group_by(& &1)
    |> Enum.map(fn {i, vals} -> {i, Enum.count(vals)} end)
    |> Map.new()
  end

  def give_offspring(fish, 0) do
    fish |> Map.delete(9)
  end

  def give_offspring(fish, days_remaining) do
    safe_fish =
      fish
      |> Map.put_new(0, 0)
      |> Map.put_new(1, 0)
      |> Map.put_new(2, 0)
      |> Map.put_new(3, 0)
      |> Map.put_new(4, 0)
      |> Map.put_new(5, 0)
      |> Map.put_new(6, 0)
      |> Map.put_new(7, 0)
      |> Map.put_new(8, 0)
      |> Map.put_new(9, 0)

    safe_fish
    |> Map.put(7, safe_fish[7] + safe_fish[0])
    |> Map.put(9, safe_fish[9] + safe_fish[0])
    |> Enum.map(fn {internal_counter, amount} -> {internal_counter - 1, amount} end)
    |> Map.new()
    |> Map.delete(-1)
    |> Map.delete(9)
    |> give_offspring(days_remaining - 1)
  end

  def solve(days) do
    fish =
      load_file()
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(&elem(&1, 0))
      |> parse_swarm()
      |> give_offspring(days)

    Enum.map(fish, fn {_, amount} -> amount end)
    |> Enum.sum()
  end

  @spec first() :: Integer
  def first() do
    solve(80)
  end

  @spec second() :: Integer
  def second() do
    solve(256)
  end
end

defmodule LanternfishTest do
  use ExUnit.Case

  describe "giveOffsprint/2" do
    test "Initial value" do
      swarm = Lanternfish.parse_swarm([3, 4, 3, 1, 2])
      assert Lanternfish.give_offspring(swarm, 0) == %{1 => 1, 2 => 1, 3 => 2, 4 => 1}
    end

    test "After 1 day" do
      swarm = Lanternfish.parse_swarm([3, 4, 3, 1, 2])

      assert Lanternfish.give_offspring(swarm, 1) == %{
               0 => 1,
               1 => 1,
               2 => 2,
               3 => 1,
               4 => 0,
               5 => 0,
               6 => 0,
               7 => 0,
               8 => 0
             }
    end

    test "After 2 days" do
      swarm = Lanternfish.parse_swarm([3, 4, 3, 1, 2])

      assert Lanternfish.give_offspring(swarm, 2) == %{
               0 => 1,
               1 => 2,
               2 => 1,
               3 => 0,
               4 => 0,
               5 => 0,
               6 => 1,
               7 => 0,
               8 => 1
             }
    end
  end
end
