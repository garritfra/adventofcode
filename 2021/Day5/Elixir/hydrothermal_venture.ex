defmodule HypothermalVenture do
  @type line :: %{
          from: {integer, integer},
          to: {integer, integer}
        }

  def load_file() do
    File.read!("../input.txt")
    |> String.split("\n", trim: true)
  end

  def parse_line({from, to}) do
    %{
      from:
        String.split(from, ",")
        |> Enum.map(&Integer.parse/1)
        |> Enum.map(&elem(&1, 0))
        |> List.to_tuple(),
      to:
        String.split(to, ",")
        |> Enum.map(&Integer.parse/1)
        |> Enum.map(&elem(&1, 0))
        |> List.to_tuple()
    }
  end

  @spec parse_lines(input :: [String.t()]) :: [line]
  def parse_lines(input) do
    Enum.map(input, fn ln ->
      String.replace(ln, " ", "")
      |> String.split("->", trim: true)
      |> List.to_tuple()
      |> parse_line()
    end)
  end

  def init_array(), do: Matrix.from_list(List.duplicate(List.duplicate(0, 1000), 1000))

  def draw_line(matrix, %{from: {x1, y1}, to: {x2, y2}} = line)
      when x2 - x1 == 0 and y2 - y1 == 0 do
    put_in(matrix[y1][x1], matrix[y1][x1] + 1)
  end

  def draw_line(matrix, %{from: {x1, y1}, to: {x2, y2}}) do
    delta_x = x2 - x1
    delta_y = y2 - y1

    updated_matrix = put_in(matrix[y1][x1], matrix[y1][x1] + 1)

    new_x =
      case delta_x do
        x when x > 0 -> x1 + 1
        x when x < 0 -> x1 - 1
        x when x == 0 -> x1
      end

    new_y =
      case delta_y do
        y when y > 0 -> y1 + 1
        y when y < 0 -> y1 - 1
        y when y == 0 -> y1
      end

    draw_line(updated_matrix, %{from: {new_x, new_y}, to: {x2, y2}})
  end

  def draw_lines(matrix, []), do: matrix
  def draw_lines(matrix, [line | tail]), do: draw_lines(draw_line(matrix, line), tail)

  def solve(lines) do
    matrix = init_array()

    draw_lines(matrix, lines)
    |> Matrix.to_list()
    |> List.flatten()
    |> Enum.filter(fn x -> x >= 2 end)
    |> Enum.count()
  end

  @spec first() :: Integer
  def first() do
    lines =
      load_file()
      |> parse_lines()
      |> Enum.filter(fn %{from: {x1, y1}, to: {x2, y2}} -> x1 == x2 or y1 == y2 end)

    solve(lines)
  end

  @spec second() :: Integer
  def second() do
    lines =
      load_file()
      |> parse_lines()

    solve(lines)
  end
end

defmodule Matrix do
  @moduledoc """
  Helpers for working with multidimensional lists, also called matrices.
  """

  @doc """
  Converts a multidimensional list into a zero-indexed map.

  ## Example

      iex> list = [["x", "o", "x"]]
      ...> Matrix.from_list(list)
      %{0 => %{0 => "x", 1 => "o", 2 => "x"}}
  """
  def from_list(list) when is_list(list) do
    do_from_list(list)
  end

  defp do_from_list(list, map \\ %{}, index \\ 0)
  defp do_from_list([], map, _index), do: map

  defp do_from_list([h | t], map, index) do
    map = Map.put(map, index, do_from_list(h))
    do_from_list(t, map, index + 1)
  end

  defp do_from_list(other, _, _), do: other

  @doc """
  Converts a zero-indexed map into a multidimensional list.

  ## Example

      iex> matrix = %{0 => %{0 => "x", 1 => "o", 2 => "x"}}
      ...> Matrix.to_list(matrix)
      [["x", "o", "x"]]
  """
  def to_list(matrix) when is_map(matrix) do
    do_to_list(matrix)
  end

  defp do_to_list(matrix) when is_map(matrix) do
    for {_index, value} <- matrix,
        into: [],
        do: do_to_list(value)
  end

  defp do_to_list(other), do: other
end
