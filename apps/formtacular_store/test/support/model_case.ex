defmodule FormtacularStore.ModelCase do
  @moduledoc """
  This module sets up tests cases for easy interaction with the database
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias FormtacularStore.Repo

      import Ecto.Changeset
      import FormtacularStore.ModelCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(FormtacularStore.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(FormtacularStore.Repo, {:shared, self()})
    end

    :ok
  end

  def errors_on(struct, data) do
    apply(struct.__struct__, :changeset, [struct, data])
    |> translate_errors
  end

  def translate_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&translate_error/1)
    |> Enum.flat_map(fn {key, errors} -> for msg <- errors, do: {key, msg} end)
  end

  defp translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(FormtacularStore.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(FormtacularStore.Gettext, "errors", msg, opts)
    end
  end
end
