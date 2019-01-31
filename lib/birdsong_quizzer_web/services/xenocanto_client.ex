defmodule BirdsongQuizzer.XenocantoClient do
  @base_uri "https://www.xeno-canto.org/api/2/recordings?query="

  def perform do
    response = HTTPotion.get!("#{@base_uri}#{query()}")
    IO.inspect(response)
    %{"recordings" => recordings} = Poison.decode!(response.body)
    for recording <- recordings, do: parse(recording)
  end

  defp parse(recording) do
    %{"id" => id, "gen" => genus, "sp" => species, "en" => common_name, "file" => file_url} =
      recording

    %{id: id, genus: genus, species: species, common_name: common_name, file_url: file_url}
  end

  defp query do
    "lat:#{lat()}%20lon:#{lon()}%20since:#{since()}%20q:A"
  end

  defp lat do
    "42.37"
  end

  defp lon do
    "-71.10"
  end

  defp since do
    "180"
  end
end
