defmodule BirdsongQuizzerWeb.SongControllerTest do
  use BirdsongQuizzerWeb.ConnCase

  alias BirdsongQuizzer.Songs
  alias BirdsongQuizzer.Songs.Song

  @create_attrs %{
    common_name: "some common_name",
    file_url: "some file_url",
    genus: "some genus",
    species: "some species"
  }
  @update_attrs %{
    common_name: "some updated common_name",
    file_url: "some updated file_url",
    genus: "some updated genus",
    species: "some updated species"
  }
  @invalid_attrs %{common_name: nil, file_url: nil, genus: nil, species: nil}

  def fixture(:song) do
    {:ok, song} = Songs.create_song(@create_attrs)
    song
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all songs", %{conn: conn} do
      conn = get(conn, Routes.song_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create song" do
    test "renders song when data is valid", %{conn: conn} do
      conn = post(conn, Routes.song_path(conn, :create), song: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.song_path(conn, :show, id))

      assert %{
               "id" => id,
               "common_name" => "some common_name",
               "file_url" => "some file_url",
               "genus" => "some genus",
               "species" => "some species"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.song_path(conn, :create), song: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update song" do
    setup [:create_song]

    test "renders song when data is valid", %{conn: conn, song: %Song{id: id} = song} do
      conn = put(conn, Routes.song_path(conn, :update, song), song: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.song_path(conn, :show, id))

      assert %{
               "id" => id,
               "common_name" => "some updated common_name",
               "file_url" => "some updated file_url",
               "genus" => "some updated genus",
               "species" => "some updated species"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, song: song} do
      conn = put(conn, Routes.song_path(conn, :update, song), song: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete song" do
    setup [:create_song]

    test "deletes chosen song", %{conn: conn, song: song} do
      conn = delete(conn, Routes.song_path(conn, :delete, song))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.song_path(conn, :show, song))
      end
    end
  end

  defp create_song(_) do
    song = fixture(:song)
    {:ok, song: song}
  end
end
