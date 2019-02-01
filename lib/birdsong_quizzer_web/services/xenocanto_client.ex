defmodule BirdsongQuizzer.XenocantoClient do
  @base_uri "https://www.xeno-canto.org/api/2/recordings?query="

  def perform(params) do
    uri = "#{@base_uri}#{query(params)}"
    response = HTTPotion.get!(uri)
    IO.inspect(response)
    %{"recordings" => recordings} = Poison.decode!(response.body)
    for recording <- recordings, do: parse(recording)
  end

  defp parse(recording) do
    %{"id" => id, "gen" => genus, "sp" => species, "en" => common_name, "file" => file_url} =
      recording

    %{id: id, genus: genus, species: species, common_name: common_name, file_url: file_url}
  end

  defp query(params) do
    "lat:#{lat(params)}%20lon:#{lon(params)}%20since:#{since()}%20q:A"
  end

  defp lat(params) do
    [lat_param | _] = Regex.run(~r/-*\d{2}\.\d{2}/, params["lat"])
    lat_param
  end

  defp lon(params) do
    [lon_param | _] = Regex.run(~r/-*\d{2}\.\d{2}/, params["lon"])
    lon_param
  end

  defp since do
    "365"
  end
end
