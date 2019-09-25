defmodule ExVerticalBooking.Response.Converter do
  def convert({:ok, struct, meta}, list_nodes) do
    {:ok, wrap(%{}, struct, [], list_nodes), meta}
  end

  def convert(response, _), do: response

  def wrap(acc, {key, %{}, [value]}, _prev, _list_nodes) when is_binary(value) do
    Map.put(acc, atomize(key), value)
  end

  def wrap(acc, {key, args, childs}, prev, list_nodes) do
    Map.put(
      acc,
      atomize(key),
      case get_type_for([key | prev], list_nodes) do
        :list ->
          childs
          |> Enum.reduce([], fn child, acc ->
            [wrap(%{}, child, [key | prev], list_nodes) | acc]
          end)
          |> Enum.reverse()

        :map ->
          arguments =
            Enum.reduce(
              args,
              %{},
              fn {key, value}, acc -> Map.put(acc, atomize("@#{key}"), value) end
            )

          Enum.reduce(childs, arguments, fn child, acc ->
            wrap(acc, child, [key | prev], list_nodes)
          end)
      end
    )
  end

  def get_type_for(path, list_nodes) do
    str_path = path |> Enum.reverse() |> Enum.join("/")

    if Enum.member?(list_nodes, str_path) do
      :list
    else
      :map
    end
  end

  defp atomize(key) when is_binary(key), do: String.to_atom(key)
  defp atomize(key), do: key
end
