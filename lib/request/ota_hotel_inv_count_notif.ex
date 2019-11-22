defmodule ExVerticalBooking.Request.OtaHotelInvCountNotif do
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request
  alias ExVerticalBooking.Request.{Document, Helpers}

  @action "OTA_HotelInvCountNotif"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}
  @type t ::
          %{
            hotel_code: String.t(),
            inventories: [
              %{
                status_application_control: %{
                  start: String.t(),
                  end: String.t(),
                  inv_type_code: String.t()
                },
                inv_counts: [
                  %{count_type: String.t(), count: String.t()}
                ]
              }
            ]
          }

  @doc """
  This method is used to update availability.
  """
  @spec execute(t, credentials, Meta.t()) :: {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_code: _, inventories: _} = params, credentials, meta) do
    params
    |> build_hotel_inv_count_notif(Map.put(meta, :method, @action))
    |> Document.build(@action, credentials)
    |> Request.send(credentials)
  end

  @spec build_hotel_inv_count_notif(t, Meta.t()) :: {{atom(), map | nil, list | nil}, Meta.t()}
  def build_hotel_inv_count_notif(%{hotel_code: _, inventories: []} = payload, meta) do
    {:error, payload, meta |> Map.put(:success, false) |> Map.put(:errors, [:empty_payload])}
  end

  def build_hotel_inv_count_notif(%{hotel_code: hotel_code, inventories: inventories}, meta) do
    inventories_elements =
      inventories
      |> Enum.map(fn %{
                       status_application_control: status_application_control,
                       inv_counts: inv_counts
                     } ->
        {:"ns1:Inventory", nil,
         [
           Helpers.build_status_application_control(status_application_control, nil),
           Helpers.build_inv_counts(inv_counts)
         ]}
      end)

    {{:"ns1:Inventories", %{HotelCode: "#{hotel_code}"}, inventories_elements}, meta}
  end
end
