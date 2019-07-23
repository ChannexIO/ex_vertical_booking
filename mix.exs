defmodule ExVerticalBooking.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_vertical_booking,
      version: "0.1.0",
      build_path: "./_build",
      config_path: "./config/config.exs",
      deps_path: "./deps",
      lockfile: "./mix.lock",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :detergentex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:sweet_xml, "~> 0.6.5"},
      {:xml_builder, "~> 2.1"},
      {:httpoison, "~> 1.3"},
      {:elixir_uuid, "~> 1.2"},
      {:exsom, "~> 0.1.0"},
      {:detergentex, "0.0.5"}
    ]
  end
end
