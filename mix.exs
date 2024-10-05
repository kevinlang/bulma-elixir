defmodule Bulma.MixProject do
  use Mix.Project

  @url "https://github.com/kevinlang/bulma-elixir"

  def project do
    [
      app: :bulma,
      version: "1.0.2",
      elixir: "~> 1.8",
      name: "Bulma",
      description: "Bulma Sass files for easy use with dart_sass",
      deps: deps(),
      package: package(),
      docs: docs()
    ]
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.34", only: :docs}
    ]
  end

  defp package() do
    %{
      licenses: ["MIT"],
      maintainers: ["Kevin Lang, David Parry"],
      links: %{"GitHub" => @url},
      files: ~w(mix.exs LICENSE README.md bulma.scss sass)
    }
  end

  defp docs() do
    [
      extras: [
        "README.md"
      ],
      main: "readme"
    ]
  end
end
