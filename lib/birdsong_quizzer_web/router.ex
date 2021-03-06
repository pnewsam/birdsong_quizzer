defmodule BirdsongQuizzerWeb.Router do
  use BirdsongQuizzerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "http://127.0.0.1:8081"
    plug :accepts, ["json"]
  end

  scope "/", BirdsongQuizzerWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BirdsongQuizzerWeb do
    pipe_through :api

    get "/songs", SongController, :index
    get "/quizzes", QuizController, :index
  end
end
