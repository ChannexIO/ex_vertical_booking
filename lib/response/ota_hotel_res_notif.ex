defmodule ExVerticalBooking.Response.OtaHotelResNotif do
  alias ExVerticalBooking.Response.Converter

  @list_nodes [
    "OTA_ResRetrieveRS/ReservationsList",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/RoomStays",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/RoomStays/RoomStay/RoomTypes",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/RoomStays/RoomStay/RoomRates",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/RoomStays/RoomStay/RoomRates/RoomRate/Rates",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/ResGlobalInfo/Comments",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/ResGlobalInfo/Comments/Guarantee/GuaranteesAccepted",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/ResGlobalInfo/Comments/HotelReservationIDs",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/ResGlobalInfo/Comments/Profiles",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/ResGlobalInfo/Comments/ResGuests",
    "OTA_ResRetrieveRS/ReservationsList/HotelReservation/ResGlobalInfo/Comments/ResGuests/ResGuest/Profiles"
  ]

  def list_nodes, do: @list_nodes
  def convert(struct), do: Converter.convert(struct, @list_nodes)
end
