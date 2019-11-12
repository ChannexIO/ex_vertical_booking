defmodule ExVerticalBooking.Request.OtaHotelRoomStayQuery do
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request
  alias ExVerticalBooking.Request.{Document, Helpers}

  @action "OTA_HotelAvailRQ"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}
  @type t :: %{hotel_code: String.t(), room_stay_candidate: String.t()}

  @doc """
  This method is used to room_stay query.
  """
  @spec execute(t, credentials, Meta.t()) :: {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_code: _, room_stay_candidate: _} = params, credentials, meta) do
    params
    |> build_hotel_room_stay_query(meta)
    |> Document.build(@action, credentials)
    |> Request.send(credentials)
  end

  @spec build_hotel_room_stay_query(t, Meta.t()) :: {{atom(), map | nil, list | nil}, Meta.t()}
  def build_hotel_room_stay_query(%{hotel_code: hotel_code, room_stay_candidate: nil} = payload, meta) do
    room_stays = [
      {:"ns1:HotelRef", %{HotelCode: "#{hotel_code}"}, nil}
    ]

    {{:"ns1:RatePlans", nil, room_stays}, meta}
  end

  def build_hotel_inv_count_notif(
        %{hotel_code: hotel_code, room_stay_candidate: room_stay_candidate},
        meta
      ) do
    room_stays = [
      {:"ns1:HotelRef", %{HotelCode: "#{hotel_code}"}, nil}
    ]

    {{:"ns1:RoomStays", nil, room_stays}, meta}
  end
end
