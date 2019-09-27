defmodule ExVerticalBooking do
  @moduledoc """
  Documentation for ExVerticalBooking.
  """

  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Response

  alias ExVerticalBooking.Request.{
    OtaHotelBookingRuleNotif,
    OtaHotelInvCountNotif,
    OtaHotelRateAmountNotif,
    OtaHotelResNotif,
    OtaPing,
    OtaRead
  }

  alias ExVerticalBooking.Response.OtaHotelBookingRuleNotif, as: OtaHotelBookingRuleNotifConverter
  alias ExVerticalBooking.Response.OtaHotelInvCountNotif, as: OtaHotelInvCountNotifConverter
  alias ExVerticalBooking.Response.OtaHotelRateAmountNotif, as: OtaHotelRateAmountNotifConverter
  alias ExVerticalBooking.Response.OtaHotelResNotif, as: OtaHotelResNotifConverter
  alias ExVerticalBooking.Response.OtaPing, as: OtaPingConverter
  alias ExVerticalBooking.Response.OtaRead, as: OtaReadConverter

  @type credentials :: %{endpoint: String.t(), password: String.t(), user: String.t()}

  @doc """
    Ping message

    This is a simple XML message that could be useful to test if the connection is working correctly. We suggest
  to implement this method first in order to be sure that the SOAP level communication is correct.

  ## Example

    ExVerticalBooking.ota_ping()
  """
  @spec ota_ping(credentials) :: {:ok, any(), Meta.t()} | {:error, map(), Meta.t()}
  def ota_ping(credentials) do
    credentials
    |> OtaPing.execute(prepare_meta())
    |> Response.parse_response()
    |> OtaPingConverter.convert()
  end

  @doc """
  This method is used to update availability.
  """
  @spec ota_hotel_inv_count_notif(OtaHotelInvCountNotif.t(), credentials) ::
          {:ok, any(), Meta.t()} | {:error, map(), Meta.t()}
  def ota_hotel_inv_count_notif(%{hotel_code: _, inventories: _} = params, credentials) do
    params
    |> OtaHotelInvCountNotif.execute(credentials, prepare_meta())
    |> Response.parse_response()
    |> OtaHotelInvCountNotifConverter.convert()
  end

  @doc """
  This method is used to update rates (per room prices).
  """
  @spec ota_hotel_rate_amount_notif(OtaHotelRateAmountNotif.t(), credentials) ::
          {:ok, any(), Meta.t()} | {:error, map(), Meta.t()}
  def ota_hotel_rate_amount_notif(%{hotel_code: _, rate_amount_messages: _} = params, credentials) do
    params
    |> OtaHotelRateAmountNotif.execute(credentials, prepare_meta())
    |> Response.parse_response()
    |> OtaHotelRateAmountNotifConverter.convert()
  end

  @doc """
  This method is used to update booking rule.
  """
  @spec ota_hotel_booking_rule_notif(OtaHotelBookingRuleNotif.t(), credentials) ::
          {:ok, any(), Meta.t()} | {:error, map(), Meta.t()}
  def ota_hotel_booking_rule_notif(%{hotel_code: _, rule_messages: _} = params, credentials) do
    params
    |> OtaHotelBookingRuleNotif.execute(credentials, prepare_meta())
    |> Response.parse_response()
    |> OtaHotelBookingRuleNotifConverter.convert()
  end

  @doc """
  This method is used for booking confirmation.
  """
  @spec ota_hotel_res_notif(list(), credentials) ::
          {:ok, any(), Meta.t()} | {:error, map(), Meta.t()}
  def ota_hotel_res_notif(booking_ids, credentials) do
    %{
      hotel_reservations:
        Enum.map(
          booking_ids,
          &%{
            unique_id: %{
              type: "14",
              id_context: "CrsConfirmNumber",
              id: &1
            },
            res_global_info: %{
              hotel_reservation_ids: [
                %{
                  res_id_type: "10",
                  res_id_value: "xxxxxx",
                  res_id_source: "PMS",
                  res_id_source_context: "PmsConfirmNumber"
                }
              ]
            }
          }
        )
    }
    |> OtaHotelResNotif.execute(credentials, prepare_meta())
    |> Response.parse_response()
    |> OtaHotelResNotifConverter.convert()
  end

  @doc """
  This method is retrieve reservations for property.
  """
  @spec ota_read(%{hotel_code: String.t()}, credentials) ::
          {:ok, any(), Meta.t()} | {:error, map(), Meta.t()}
  def ota_read(%{hotel_code: _} = params, credentials) do
    params
    |> OtaRead.execute(credentials, prepare_meta())
    |> Response.parse_response()
    |> OtaReadConverter.convert()
  end

  defp prepare_meta() do
    %{
      request: nil,
      response: nil,
      method: nil,
      started_at: DateTime.utc_now(),
      finished_at: nil,
      success: true,
      errors: []
    }
  end
end
