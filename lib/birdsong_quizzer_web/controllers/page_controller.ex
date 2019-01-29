defmodule BirdsongQuizzerWeb.PageController do
  use BirdsongQuizzerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
