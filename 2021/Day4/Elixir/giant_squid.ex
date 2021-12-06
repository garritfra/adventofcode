# iex()> Day3.first

defmodule GiantSquid do
  def load_file() do
    File.read!("../input.txt")
    |> String.split("\n\n", trim: true)
  end

  def drawn_numbers(input) do
    Enum.at(input, 0)
    |> String.split(",", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn t -> elem(t, 0) end)
  end

  def parse_board(board) do
    String.split(board, "\n")
    |> Enum.map(fn board ->
      String.replace(board, "  ", " ")
      |> String.split(" ", trim: true)
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn t -> elem(t, 0) end)
      |> Enum.map(fn col -> {col, false} end)
    end)
  end

  def play_bingo(boards, [drawn | tail]) do
    boards_after_game = Enum.map(boards, &apply_drawn_number(&1, drawn))
    winner = Enum.find(boards_after_game, false, &has_bingo/1)
    if winner, do: {winner, drawn}, else: play_bingo(boards_after_game, tail)
  end

  def play_bingo(board, []), do: board

  def play_all_drawn_numbers(boards, [drawn | tail]) do
    boards_after_game =
      Enum.map(boards, fn {data, elements_left, won_with} = board ->
        {apply_drawn_number(elem(board, 0), drawn), elements_left, won_with}
      end)
      |> Enum.map(fn {data, elements_left, won_with} = board ->
        if has_bingo(data) and !won_with do
          {data, Enum.count(tail) + 1, drawn}
        else
          board
        end
      end)

    if Enum.all?(Enum.map(boards, &(elem(&1, 2)))) do
      boards
    else
      play_all_drawn_numbers(boards_after_game, tail)
    end
  end

  def play_all_drawn_numbers(boards, []), do: boards

  def apply_drawn_number(board, num) do
    Enum.map(board, fn row ->
      Enum.map(row, fn {value, matched} ->
        if value == num, do: {value, true}, else: {value, matched}
      end)
    end)
  end

  def row_has_bingo(row), do: Enum.all?(row)

  def has_bingo(board) do
    matched_matrix =
      Enum.map(board, fn row ->
        Enum.map(row, fn {value, matched} -> matched end)
      end)

    row_bingo = Enum.any?(matched_matrix, &row_has_bingo/1)

    col_bingo =
      Enum.zip(matched_matrix)
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.any?(&row_has_bingo/1)

    row_bingo or col_bingo
  end

  def parse_boards(input) do
    Enum.drop(input, 1)
    |> Enum.map(&parse_board/1)
  end

  @spec first() :: Integer
  def first() do
    drawn = load_file() |> drawn_numbers
    boards = load_file() |> parse_boards
    {winner, last_drawn} = play_bingo(boards, drawn)

    undrawn_sum =
      List.flatten(winner)
      |> Enum.filter(fn {_, was_drawn} -> !was_drawn end)
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()

    undrawn_sum * last_drawn
  end

  @spec second() :: Integer
  def second() do
    drawn = load_file |> drawn_numbers

    boards =
      load_file()
      |> parse_boards
      |> Enum.map(fn board -> {board, nil, nil} end)

    boards_after_games =
      play_all_drawn_numbers(boards, drawn)
      |> Enum.sort_by(&elem(&1, 1))

    {data, _, last_drawn} = board = Enum.at(boards_after_games, 0)

    undrawn_sum =
      List.flatten(data)
      |> Enum.filter(fn {_, was_drawn} -> !was_drawn end)
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()

    undrawn_sum * last_drawn


  end
end
