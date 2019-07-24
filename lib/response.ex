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
  alias ExVerticalBooking.Response.FaultProcessor
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
  def parse_response({:error, _, meta} = e), do: FaultProcessor.create_response(e, meta)

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

{:badrpc,
 {:EXIT,
  {:function_clause,
   [
     {ExVerticalBooking.Request.Document, :build,
      [
        {:error, %{hotel_code: "18296", inventories: []},
         %{
           errors: [:empty_payload],
           finished_at: nil,
           method: nil,
           request: nil,
           response: nil,
           started_at: ~U[2019-07-24 03:51:40.981606Z],
           success: false
         }},
        "OTA_HotelInvCountNotif",
        %{
          endpoint: "https://pms.verticalbooking.com/thebookingfactory/OTA_PMS.php",
          hotel_code: "18296",
          mapping: %{
            "rate_plan_code_dictionary" => %{
              "values" => [
                %{"Update_Rates" => "Y", "id" => "Breakfast", "title" => "Breakfast"},
                %{"Update_Rates" => "Y", "id" => "BreakfastSO", "title" => "BreakfastSO"},
                %{"Update_Rates" => "Y", "id" => "roomonly", "title" => "roomonly"},
                %{"Update_Rates" => "Y", "id" => "MORate", "title" => "MORate"}
              ]
            },
            "room_type_code_dictionary" => %{
              "values" => [
                %{"Update" => "Y", "id" => "StdDouble", "title" => "StdDouble"},
                %{"Update" => "Y", "id" => "ExecDouble", "title" => "ExecDouble"},
                %{"Update" => "Y", "id" => "TwinFamily", "title" => "TwinFamily"},
                %{"Update" => "Y", "id" => "SmallDouble", "title" => "SmallDouble"}
              ]
            }
          },
          password: "b98xytc9q2",
          user: "t35f6efm90"
        },
        []
      ], [file: 'lib/request/document.ex', line: 16]},
     {ExVerticalBooking.Request.OtaHotelInvCountNotif, :execute, 3,
      [file: 'lib/request/ota_hotel_inv_count_notif.ex', line: 33]},
     {ExVerticalBooking, :ota_hotel_inv_count_notif, 2,
      [file: 'lib/ex_vertical_booking.ex', line: 44]},
     {ChannelConnection.Adapters.VerticalBooking, :sync, 2,
      [file: 'lib/channel_connection/adapters/vertical_booking.ex', line: 81]},
     {ChannelConnection.Adapter, :exec_logged_action, 4,
      [file: 'lib/channel_connection/adapter.ex', line: 138]},
     {:rpc, :local_call, 3, [file: 'rpc.erl', line: 321]},
     {ChannelConnectionsManager.Connection.Writer, :sync, 1,
      [file: 'lib/channel_connections_manager/connection/writer.ex', line: 213]}
   ]}}}
