defmodule ExVerticalBooking.Request.OtaHotelResNotif do
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request
  alias ExVerticalBooking.Request.{Document}

  @action "OTA_HotelResNotif"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}
  @type t ::
          %{
            hotel_reservations: [
              %{
                unique_id: %{
                  type: String.t(),
                  id_context: String.t(),
                  id: String.t()
                },
                res_global_info: %{
                  hotel_reservation_ids: [
                    %{
                      res_id_type: String.t(),
                      res_id_value: String.t(),
                      res_id_source: String.t(),
                      res_id_source_context: String.t()
                    }
                  ]
                }
              }
            ]
          }

  @doc """
  This method is used to update availability.
  """
  @spec execute(t, credentials, Meta.t()) :: {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_reservations: _} = params, credentials, meta) do
    params
    |> build_hotel_res_notif(meta)
    |> Document.build(@action, credentials)
    |> Request.send(meta, credentials)
  end

  @spec build_hotel_res_notif(t, Meta.t()) :: {{atom(), map | nil, list | nil}, Meta.t()}
  def build_hotel_res_notif(%{hotel_reservations: hotel_reservations}, meta) do
    hotel_reservations_elements =
      hotel_reservations
      |> Enum.map(fn %{
                       unique_id: unique_id,
                       res_global_info: res_global_info
                     } ->
        {:"ns1:HotelReservation", nil,
         [
           build_unique_id(unique_id),
           build_res_global_info(res_global_info)
         ]}
      end)

    {{:"ns1:HotelReservations", nil, hotel_reservations_elements}, meta}
  end

  def build_unique_id(%{type: type, id_context: id_context, id: id}) do
    {:"ns1:UniqueID", %{Type: type, ID_Context: id_context, ID: id}, nil}
  end

  def build_res_global_info(%{hotel_reservation_ids: hotel_reservation_ids}) do
    {:"ns1:ResGlobalInfo", nil,
     [
       {:"ns1:HotelReservationIDs", nil,
        Enum.map(hotel_reservation_ids, fn %{
                                             res_id_type: res_id_type,
                                             res_id_value: res_id_value,
                                             res_id_source: res_id_source,
                                             res_id_source_context: res_id_source_context
                                           } ->
          {:"ns1:HotelReservationID",
           %{
             ResID_Type: res_id_type,
             ResID_Value: res_id_value,
             ResID_Source: res_id_source,
             ResID_SourceContext: res_id_source_context
           }, nil}
        end)}
     ]}
  end
end
