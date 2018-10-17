defmodule ChiliPlayer.MixProject do
  use Mix.Project

  def project do
    [
      app: :chili_player,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Basic Elixir lib to access chiligum videos web player."
  end

  defp package() do
      [
        name: "chili_player",
        licenses: ["Apache 2.0"],
        links: %{"GitHub" => "https://github.com/chiligumdev/ex_chili_player"}
      ]
    end
end
