defmodule ExVerticalBooking.Response.Parser do
  @moduledoc """
  Provides a functions for parse an xml-like response body.
  """

  import SweetXml, only: [xpath: 2, sigil_x: 2]
  alias ExVerticalBooking.Error
  alias ExVerticalBooking.Response
  alias ExVerticalBooking.Response.FaultProcessor

  @soap_version_namespaces %{
    "1.1" => :"http://schemas.xmlsoap.org/soap/envelope/",
    "1.2" => :"http://www.w3.org/2003/05/soap-envelope"
  }
  @doc """
  Executing with xml response body.

  If a list is empty then `parse/1` returns full parsed response structure into map.
  """
  @spec parse(String.t(), atom(), map) :: map()
  def parse(xml_response, :fault, meta) do
    xml_response = String.trim(xml_response)
    try do
      fault_tag = get_fault_tag(xml_response)

      e =
        xml_response
        |> xpath(~x"//#{fault_tag}/*"l)
        |> parse_elements()
        |> Enum.reduce(%{}, fn el, acc ->
          with {key, _, [value]} <- el do
            Map.put(acc, key, value)
          end
        end)
        |> FaultProcessor.create_response(meta)
    rescue
      e in ArgumentError -> FaultProcessor.create_response(e, meta)
      e in FunctionClauseError -> FaultProcessor.create_response(e, meta)
    catch
      :exit, e -> FaultProcessor.create_response(e, meta)
    end
  end

  def parse(xml_response, _response_type, meta) do
    try do
      body_tag = get_body_tag(xml_response)

      {:ok, xml_response |> xpath(~x"//#{body_tag}/*"l) |> parse_elements() |> List.first(), meta}
    rescue
      e in ArgumentError -> FaultProcessor.create_response(e, meta)
      e in FunctionClauseError -> FaultProcessor.create_response(e, meta)
    end
  end

  @spec parse_record(tuple()) :: map() | String.t()
  defp parse_record({:xmlElement, tag, _, _, _, _, _, attributes, elements, _, _, _}) do
    {get_tag_name(tag),
     attributes
     |> Enum.map(&parse_record/1)
     |> Enum.reduce(%{}, fn {attr_name, value}, acc -> Map.put(acc, attr_name, value) end),
     parse_elements(elements)}
  end

  defp parse_record({:xmlAttribute, attr_name, _, _, _, _, _, _, value, _}),
    do: {attr_name, value}

  defp parse_record({:xmlText, _, _, _, value, _}) do
    transform_record_value(value)
  end

  def get_tag_name(tag) when is_atom(tag), do: tag |> Atom.to_string() |> get_tag_name()

  def get_tag_name(tag), do: tag |> String.split(":") |> List.last()

  defp transform_record_value('\n'), do: nil
  defp transform_record_value(nil), do: nil

  defp transform_record_value(value) when is_list(value),
    do: value |> to_string() |> String.trim()

  defp transform_record_value(value) when is_binary(value), do: value |> String.trim()

  @spec parse_elements(list() | tuple()) :: map()
  defp parse_elements([]), do: []
  defp parse_elements(elements) when is_tuple(elements), do: parse_record(elements)

  defp parse_elements(elements) when is_list(elements) do
    elements
    |> Enum.map(&parse_record/1)
    |> Enum.filter(&(not is_nil(&1)))
    |> parse_element_values()
  end

  @spec parse_element_values(list()) :: any()
  defp parse_element_values(elements) do
    cond do
      Enum.all?(elements, &is_map/1) && unique_tags?(elements) ->
        Enum.reduce(elements, &Map.merge/2)

      Enum.all?(elements, &is_map/1) ->
        elements |> Enum.map(&Map.to_list/1) |> List.flatten()

      true ->
        elements |> Enum.filter(&(&1 != ""))
    end
  end

  defp unique_tags?(elements) do
    keys =
      elements
      |> Enum.map(&Map.keys/1)
      |> List.flatten()

    Enum.uniq(keys) == keys
  end

  defp get_envelope_namespace(xml_response) do
    env_namespace = @soap_version_namespaces[soap_version()]

    xml_response
    |> xpath(~x"//namespace::*"l)
    |> Enum.find(fn {_, _, _, _, namespace_url} -> namespace_url == env_namespace end)
    |> elem(3)
  end

  defp get_fault_tag(xml_response) do
    xml_response
    |> get_envelope_namespace()
    |> List.to_string()
    |> apply_namespace_to_tag("Fault")
  end

  defp get_body_tag(xml_response) do
    xml_response
    |> get_envelope_namespace()
    |> List.to_string()
    |> apply_namespace_to_tag("Body")
  end

  defp apply_namespace_to_tag(nil, tag), do: tag
  defp apply_namespace_to_tag(env_namespace, tag), do: env_namespace <> ":" <> tag

  defp soap_version, do: Application.fetch_env!(:soap, :globals)[:version]

  def handle_response(
        {:ok,
         %HTTPoison.Response{
           body: body,
           headers: headers,
           request_url: request_url,
           status_code: status_code
         }}
      ) do
    {:ok,
     %Response{body: body, headers: headers, request_url: request_url, status_code: status_code}}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
