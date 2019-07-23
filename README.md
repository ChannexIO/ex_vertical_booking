# ExVerticalBooking

VerticalBooking API Extension for Elixir

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_vertical_booking` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_vertical_booking, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
def load_bookings() do
  ExVerticalBooking.ota_read(
    %{hotel_code: "VB_HOTEL_CODE"},
    %{
      endpoint: "https://pms.verticalbooking.com/requestor_id/OTA_PMS.php",
      password: "PASSWORD",
      user: "USER"
    }
  )
end
```