defmodule BirdsongQuizzer.QuizFormulator do
  def perform(params) do
    question_groups(params)
    |> Enum.map(fn {songs, index} -> question(songs, index) end)
  end

  defp question_groups(params) do
    songs(params) |> Enum.chunk_every(4) |> Enum.with_index()
  end

  defp question(songs, index) do
    correct_song = Enum.random(songs)

    %{
      id: index,
      songUrl: formatted_song_url(correct_song),
      answers:
        Enum.map(songs, fn song ->
          answer(song, correct_song.id)
        end)
    }
  end

  defp answer(song, correct_song_id) do
    %{commonName: song.common_name, isCorrect: correct_song_id == song.id}
  end

  defp songs(params) do
    BirdsongQuizzer.XenocantoClient.perform(params)
  end

  defp formatted_song_url(song) do
    "http:#{song.file_url}"
  end
end
