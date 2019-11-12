defmodule ExVerticalBooking.Request.OtaHotelRatePlanQuery do
  alias ExVerticalBooking.Meta
  alias ExVerticalBooking.Request
  alias ExVerticalBooking.Request.{Document, Helpers}

  @action "OTA_HotelRatePlanNotif"

  @type credentials :: %{user: String.t(), password: String.t(), endpoint: String.t()}
  @type t :: %{hotel_code: String.t(), rate_plan_candidate: String.t()}

  @doc """
  This method is used to rate_plan query.
  """
  @spec execute(t, credentials, Meta.t()) :: {:ok, struct(), Meta.t()} | {:error, any(), Meta.t()}
  def execute(%{hotel_code: _, rate_plan_candidate: _} = params, credentials, meta) do
    params
    |> build_hotel_rate_plan_query(meta)
    |> Document.build(@action, credentials)
    |> Request.send(credentials)
  end

  @spec build_hotel_rate_plan_query(t, Meta.t()) :: {{atom(), map | nil, list | nil}, Meta.t()}
  def build_hotel_rate_plan_query(%{hotel_code: hotel_code, rate_plan_candidate: nil} = payload, meta) do
    rate_plans = [
      {:"ns1:HotelRef", %{HotelCode: "#{hotel_code}"}, nil}
    ]

    {{:"ns1:RatePlans", nil, rate_plans}, meta}
  end

  def build_hotel_inv_count_notif(
        %{hotel_code: hotel_code, rate_plan_candidate: rate_plan_candidate},
        meta
      ) do
    rate_plans = [
      {:"ns1:HotelRef", %{HotelCode: "#{hotel_code}"}, nil}
    ]

    {{:"ns1:RatePlans", nil, rate_plans}, meta}
  end
end
