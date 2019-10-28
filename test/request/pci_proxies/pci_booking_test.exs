defmodule ExVerticalBooking.Request.PCIProxies.PCIBookingTest do
  use ExUnit.Case
  @moduletag :ex_vertical_booking_pci_booking

  alias ExVerticalBooking.Request.PCIProxies.Fixtures
  alias ExVerticalBooking.Request.PCIProxies.PCIBooking
  doctest PCIBooking

  @meta Fixtures.get(:meta)
  @pci @meta.pci

  test "success parse_headers" do
    assert {:ok, @pci} = PCIBooking.parse_headers(@meta)
  end

  test "fail parse_headers" do
    assert {:error, %{success: false}} = PCIBooking.parse_headers(Map.delete(@meta, :headers))
  end

  test "success convert_token_headers when empty" do
    assert {:ok, []} = PCIBooking.convert_token_headers(%{tokens: [], errors: [], warnings: []})
  end

  test "success convert_token_headers when all valid" do
    assert {:ok, [%{tokens: "token_1"}, %{tokens: "token_2"}]} =
             PCIBooking.convert_token_headers(%{
               tokens: ["token_1", "token_2"],
               errors: [],
               warnings: []
             })
  end

  test "success convert_token_headers when all valid, but warning" do
    assert {:ok, [%{tokens: "token_1", warnings: "warning_1"}, %{tokens: "token_2"}]} =
             PCIBooking.convert_token_headers(%{
               tokens: ["token_1", "token_2"],
               errors: [],
               warnings: ["warning_1", ""]
             })
  end

  test "success convert_token_headers when two first valid and last is error, and warning" do
    assert {:ok,
            [
              %{tokens: "token_1", warnings: "warning_1"},
              %{tokens: "token_2"},
              %{errors: "error_3"}
            ]} =
             PCIBooking.convert_token_headers(%{
               tokens: ["token_1", "token_2"],
               errors: ["", "", "error_3"],
               warnings: ["warning_1", "", ""]
             })
  end

  test "success convert_token_headers when first and last valid, but middle is error" do
    assert {:ok,
            [
              %{tokens: "token_1"},
              %{errors: "error_2"},
              %{tokens: "token_3"}
            ]} =
             PCIBooking.convert_token_headers(%{
               tokens: ["token_1", "token_3"],
               errors: ["", "error_2", ""],
               warnings: []
             })
  end

  test "success convert_token_headers when all error" do
    assert {:ok,
            [
              %{errors: "error_1"},
              %{errors: "error_2"},
              %{errors: "error_3"}
            ]} =
             PCIBooking.convert_token_headers(%{
               tokens: [],
               errors: ["error_1", "error_2", "error_3"],
               warnings: []
             })
  end

  test "success convert_token_headers when count of warnings non consistent" do
    assert {:error, :non_consistent_warnings_list} =
             PCIBooking.convert_token_headers(%{
               tokens: ["token_1", "token_3"],
               errors: ["", "error_2", ""],
               warnings: ["", ""]
             })
  end

  test "success convert_token_headers when count of errors non consistent" do
    assert {:error, :non_consistent_errors_list} =
             PCIBooking.convert_token_headers(%{
               tokens: ["token_1", "token_3"],
               errors: ["", "error_2"],
               warnings: ["", ""]
             })
  end
end
