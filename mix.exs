defmodule MintUnix.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :mint_unix,
      version: @version,
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
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
      {:mint, "~> 1.3"},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp description do
    "Mint transport implementation for UNIX sockets"
  end

  defp docs do
    [
      source_url: "https://github.com/elridion/mint_unix"
    ]
  end

  defp package do
    [
      maintainers: ["Hans Gödeke"],
      files: ~w(lib mix.exs README* LICENSE*),
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/elridion/mint_unix"
      }
    ]
  end
end
