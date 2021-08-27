defmodule Bulma.MixProject do
  use Mix.Project

  @url "https://github.com/kevinlang/bulma-elixir"

  def project do
    [
      app: :bulma,
      version: "0.9.3",
      elixir: "~> 1.8",
      name: "Bulma",
      description: "Bulma Sass files for easy use with dart_sass",
      deps: deps(),
      package: package()
    ]
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.21", only: :docs}
    ]
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Kevin Lang"],
      links: %{"GitHub" => @url},
      files: ~w(mix.exs LICENSE README.md bulma.sass sass)
    }
  end
end
