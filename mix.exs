defmodule ExVerticalBooking.MixProject do
  use Mix.Project

  @version "0.2.20"

  def project do
    [
      app: :ex_vertical_booking,
      version: @version,
      build_path: "./_build",
      config_path: "./config/config.exs",
      deps_path: "./deps",
      lockfile: "./mix.lock",
      elixir: "~> 1.12.3",
      start_permanent: Mix.env() == :prod,
      name: "ExVerticalBooking",
      source_url: "https://github.com/ChannexIO/ex_vertical_booking",
      docs: docs(),
      description: description(),
      package: package(),
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
      {:sweet_xml, "~> 0.7.2"},
      {:xml_builder, "~> 2.2"},
      {:http_client, github: "ChannexIO/http_client", tag: "v0.3.6"},
      {:elixir_uuid, "~> 1.2.1"},
      {:erlsom, "~> 1.5"},
      {:exsom, "~> 0.2.1"},
      {:detergentex, "0.0.7"},
      {:ex_doc, "~> 0.27.3", only: :dev}
    ]
  end

  defp docs do
    [extras: ["README.md"]]
  end

  defp description do
    "VerticalBooking API Extension for Elixir"
  end

  defp package do
    [
      name: "ex_vertical_booking",
      files: ~w(lib config .formatter.exs mix.exs README.md LICENSE),
      maintainers: ["Andrew Judis Yudin"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/ChannexIO/ex_vertical_booking"}
    ]
  end
end
