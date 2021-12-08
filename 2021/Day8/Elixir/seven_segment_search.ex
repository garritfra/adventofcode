ExUnit.start()

defmodule SevenSegmentSearch do
  def load_file(path) do
    File.read!(path)
    |> String.split("\n", trim: true)
  end

  def parse_input(lines) do
    lines
    |> Enum.map(fn line ->
      {signals, output_values} =
        String.split(line, "|", trim: true)
        |> Enum.map(fn part -> String.split(part, " ", trim: true) end)
        |> List.to_tuple()
    end)
  end

  @spec find_unique([String], [String]) :: [String]
  def find_unique(signals, output_values) do
    unique_signal_lengths =
      signals
      |> Enum.map(&String.length/1)
      |> Enum.frequencies()
      |> Enum.filter(fn {_, occurences} -> occurences == 1 end)
      |> Enum.map(&elem(&1, 0))

    Enum.filter(output_values, fn value ->
      Enum.member?(unique_signal_lengths, String.length(value))
    end)
  end

  @spec first() :: Integer
  def first() do
    inputs =
      load_file("../input.txt")
      |> parse_input()

    Enum.map(inputs, fn {signals, output_values} -> find_unique(signals, output_values) end)
    |> List.flatten()
    |> Enum.count()
  end

  @spec second() :: Integer
  def second() do
    :second
  end
end

defmodule SevenSegmentSearchTest do
  use ExUnit.Case

  describe "find_unique/2" do
    test "Example" do
      signals = [
        "be",
        "cfbegad",
        "cbdgef",
        "fgaecd",
        "cgeb",
        "fdcge",
        "agebfd",
        "fecdb",
        "fabcd",
        "edb"
      ]

      output_values = ["fdgacbe", "cefdb", "cefbgd", "gcbe"]

      expected_result = ["fdgacbe", "gcbe"]
      assert SevenSegmentSearch.find_unique(signals, output_values) == expected_result
    end
  end
end
