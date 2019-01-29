defmodule BirdsongQuizzerWeb.SongController do
  use BirdsongQuizzerWeb, :controller

  alias BirdsongQuizzer.{XenocantoClient}
  alias BirdsongQuizzer.Songs.Song

  action_fallback BirdsongQuizzerWeb.FallbackController

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    songs = XenocantoClient.perform()
    render(conn, "index.json", songs: songs)
  end

  def show(conn, %{"id" => id}) do
    song = Songs.get_song!(id)
    render(conn, "show.json", song: song)
  end
end
