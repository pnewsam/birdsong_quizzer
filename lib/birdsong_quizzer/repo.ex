defmodule BirdsongQuizzer.Repo do
  use Ecto.Repo,
    otp_app: :birdsong_quizzer,
    adapter: Ecto.Adapters.Postgres
end
