# iex()> Day3.first

defmodule BinaryDiagnostics do
  def load_file() do
    File.read!("../input.txt")
    |> String.split("\n", trim: true)
  end

  def most_common(list) do
    gb = Enum.group_by(list, & &1)
    max = Enum.map(gb, fn {_, val} -> length(val) end) |> Enum.max()
    [most_common] = for {key, val} <- gb, length(val) == max, do: key
    most_common
  end

  def least_common(list) do
    gb = Enum.group_by(list, & &1)
    min = Enum.map(gb, fn {_, val} -> length(val) end) |> Enum.min()
    [least_common] = for {key, val} <- gb, length(val) == min, do: key
    least_common
  end

  def get_result(binary_list, comparator) do
    binary_list
    |> Enum.map(fn bin -> String.split(bin, "", trim: true) end)
    |> Enum.zip_reduce([], fn elements, acc ->
      [comparator.(elements) | acc]
    end)
    |> Enum.reverse()
    |> Enum.join("")
    |> Integer.parse(2)
    |> elem(0)
  end

  @spec first() :: Integer
  def first() do
    binaries = load_file
    gamma = get_result(binaries, &most_common/1)
    epsilon = get_result(binaries, &least_common/1)

    gamma * epsilon
  end

  @spec second() :: Integer
  def second() do
    :second
  end
end
