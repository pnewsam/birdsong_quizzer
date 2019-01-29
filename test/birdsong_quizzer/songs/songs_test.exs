defmodule BirdsongQuizzer.SongsTest do
  use BirdsongQuizzer.DataCase

  alias BirdsongQuizzer.Songs

  describe "songs" do
    alias BirdsongQuizzer.Songs.Song

    @valid_attrs %{common_name: "some common_name", file_url: "some file_url", genus: "some genus", species: "some species"}
    @update_attrs %{common_name: "some updated common_name", file_url: "some updated file_url", genus: "some updated genus", species: "some updated species"}
    @invalid_attrs %{common_name: nil, file_url: nil, genus: nil, species: nil}

    def song_fixture(attrs \\ %{}) do
      {:ok, song} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Songs.create_song()

      song
    end

    test "list_songs/0 returns all songs" do
      song = song_fixture()
      assert Songs.list_songs() == [song]
    end

    test "get_song!/1 returns the song with given id" do
      song = song_fixture()
      assert Songs.get_song!(song.id) == song
    end

    test "create_song/1 with valid data creates a song" do
      assert {:ok, %Song{} = song} = Songs.create_song(@valid_attrs)
      assert song.common_name == "some common_name"
      assert song.file_url == "some file_url"
      assert song.genus == "some genus"
      assert song.species == "some species"
    end

    test "create_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Songs.create_song(@invalid_attrs)
    end

    test "update_song/2 with valid data updates the song" do
      song = song_fixture()
      assert {:ok, %Song{} = song} = Songs.update_song(song, @update_attrs)
      assert song.common_name == "some updated common_name"
      assert song.file_url == "some updated file_url"
      assert song.genus == "some updated genus"
      assert song.species == "some updated species"
    end

    test "update_song/2 with invalid data returns error changeset" do
      song = song_fixture()
      assert {:error, %Ecto.Changeset{}} = Songs.update_song(song, @invalid_attrs)
      assert song == Songs.get_song!(song.id)
    end

    test "delete_song/1 deletes the song" do
      song = song_fixture()
      assert {:ok, %Song{}} = Songs.delete_song(song)
      assert_raise Ecto.NoResultsError, fn -> Songs.get_song!(song.id) end
    end

    test "change_song/1 returns a song changeset" do
      song = song_fixture()
      assert %Ecto.Changeset{} = Songs.change_song(song)
    end
  end
end
