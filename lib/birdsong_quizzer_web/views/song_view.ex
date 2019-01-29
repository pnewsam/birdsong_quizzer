defmodule BirdsongQuizzerWeb.SongView do
  use BirdsongQuizzerWeb, :view
  alias BirdsongQuizzerWeb.SongView

  def render("index.json", %{songs: songs}) do
    %{data: render_many(songs, SongView, "song.json")}
  end

  def render("show.json", %{song: song}) do
    %{data: render_one(song, SongView, "song.json")}
  end

  def render("song.json", %{song: song}) do
    %{id: song.id,
      genus: song.genus,
      species: song.species,
      file_url: song.file_url,
      common_name: song.common_name}
  end
end
