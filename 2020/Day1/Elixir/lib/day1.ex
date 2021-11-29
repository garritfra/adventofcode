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
    Enum.reduce(input, 0, fn curr1, res1 ->
      if res1 > 0 and res1 != nil do
        res1
      else
        Enum.reduce(input, 0, fn curr2, res2 ->
          if res2 > 0 and res2 != nil do
            res2
          else
            if curr1 + curr2 == 2020 do
              curr1 * curr2
            end
          end
        end)
      end
    end)
  end

  @spec second([Integer]) :: Integer
  def second(input) do
    :second
  end
end
