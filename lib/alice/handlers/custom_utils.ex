defmodule Alice.Handlers.CustomUtils do

  use Alice.Router

  alias Alice.Conn

  command ~r/\bwhere are you\b/, :where_are_you

  @doc """
  Ask Alice where she lives
  `@alice where are you`
  """
  def where_are_you(conn) do
    {:ok, data} = :inet.getif()
    List.to_tuple(data) |> elem(0) |> elem(0) |> :inet.ntoa() |> to_string() |> reply(conn)
    if System.get_env("HOSTNAME") do
      reply("And my hostname is", conn)
      System.get_env("HOSTNAME") |> reply(conn)
    else
      reply("And I can't seem to find my hostname", conn)
    end
  end

end
