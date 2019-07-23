defmodule ExVerticalBooking.Response do
  @moduledoc """
  Struct for response given by soap call.
  """

  defstruct body: nil, headers: [], request_url: nil, status_code: nil

  @type t :: %__MODULE__{
          body: any(),
          headers: list(tuple()),
          request_url: String.t(),
          status_code: pos_integer()
        }

  alias ExVerticalBooking.Response.Parser

  @doc """
  Executing with xml response body as string.

  Function `parse/1` returns a full parsed response structure as map.
  """
  @spec parse(__MODULE__.t(), map) :: {:ok, any(), map} | {:error, map(), map}
  def parse(%ExVerticalBooking.Response{body: body, status_code: status_code}, meta) do
    Parser.parse(body, status_code, meta)
  end

  @spec parse(String.t(), integer(), map) :: {:ok, any(), map} | {:error, map(), map}
  def parse(body, status_code, meta) when status_code >= 400 do
    body |> Parser.parse(:fault, meta)
  end

  def parse(body, _status_code, meta), do: body |> Parser.parse(:successful, meta) |> cleanup_keys

  def parse_response({:ok, response, meta}), do: parse(response.body, response.status_code, meta)

  def cleanup_keys(map) when is_map(map) do
    map
    |> Map.keys()
    |> Enum.reduce(%{}, &Map.put(&2, cleanup_tag_namspace(&1), cleanup_keys(map[&1])))
  end

  def cleanup_keys(value) when is_list(value), do: Enum.map(value, &cleanup_keys(&1))

  def cleanup_keys(value), do: value

  def cleanup_tag_namspace(tag) when is_atom(tag) do
    tag |> Atom.to_string() |> cleanup_tag_namspace
  end

  def cleanup_tag_namspace(tag_with_namespace) do
    with [_, tag] <- Regex.run(~r/\w*\:(\w*)/, tag_with_namespace) do
      String.to_atom(tag)
    else
      _ -> String.to_atom(tag_with_namespace)
    end
  end

  def reduce_first_level_map(map), do: map[map |> Map.keys() |> List.first()]
end
