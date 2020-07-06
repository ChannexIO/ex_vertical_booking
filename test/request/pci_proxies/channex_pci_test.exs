defmodule ExVerticalBooking.Request.PCIProxies.ChannexPCITest do
  use ExUnit.Case
  @moduletag :ex_vertical_booking_channex_pci

  alias ExVerticalBooking.Request.PCIProxies.ChannexPCI
  doctest ChannexPCI

  test "success parse_headers" do
    assert {:ok,
            %{
              tokens: ["token_1", "token_2", ""],
              errors: ["", "", "error_3"],
              warnings: ["warning_1", "warning_2_1;warning_2_2", ""]
            }} ==
             ChannexPCI.parse_headers(%{
               headers: [
                 ["X-PCI-CHANNEX-TOKENS", "token_1, token_2, "],
                 ["X-PCI-CHANNEX-ERRORS", ", , error_3"],
                 ["X-PCI-CHANNEX-WARNINGS", "warning_1, warning_2_1;warning_2_2, "]
               ]
             })
  end

  test "fail parse_headers" do
    assert {:error, "Meta not contains any headers"} == ChannexPCI.parse_headers(%{})
  end

  test "success convert_token_headers when empty" do
    assert {:ok, []} ==
             ChannexPCI.convert_token_headers(%{tokens: [], errors: nil, warnings: nil})
  end

  test "fail convert_token_headers when empty token without any errors" do
    assert {:error, "Headers contains non consistent errors list"} ==
             ChannexPCI.convert_token_headers(%{
               tokens: ["token_1", "token_2", ""],
               errors: nil,
               warnings: nil
             })
  end

  test "success convert_token_headers when all valid, but warning" do
    assert {:ok, [%{token: "token_1", warning: "warning_1"}, %{token: "token_2"}]} ==
             ChannexPCI.convert_token_headers(%{
               tokens: ["token_1", "token_2"],
               errors: nil,
               warnings: ["warning_1", ""]
             })
  end

  test "success convert_token_headers when two first valid and last is error, and warning" do
    assert {:ok,
            [
              %{token: "token_1", warning: "warning_1"},
              %{token: "token_2"},
              %{error: "error_3"}
            ]} ==
             ChannexPCI.convert_token_headers(%{
               tokens: ["token_1", "token_2", ""],
               errors: ["", "", "error_3"],
               warnings: ["warning_1", "", ""]
             })
  end

  test "success convert_token_headers when first and last valid, but middle is error" do
    assert {:ok,
            [
              %{token: "token_1"},
              %{error: "error_2"},
              %{token: "token_3"}
            ]} ==
             ChannexPCI.convert_token_headers(%{
               tokens: ["token_1", "", "token_3"],
               errors: ["", "error_2", ""],
               warnings: nil
             })
  end

  test "success convert_token_headers when all error" do
    assert {:ok,
            [
              %{error: "error_1"},
              %{error: "error_2"},
              %{error: "error_3"}
            ]} ==
             ChannexPCI.convert_token_headers(%{
               tokens: ["", "", ""],
               errors: ["error_1", "error_2", "error_3"],
               warnings: nil
             })
  end

  test "success convert_token_headers when count of warnings non consistent" do
    assert {:error, "Headers contains non consistent warnings list"} ==
             ChannexPCI.convert_token_headers(%{
               tokens: ["token_1", "", "token_3"],
               errors: ["", "error_2", ""],
               warnings: ["warning_1", "warning_2", "warning_3", "warning_4"]
             })
  end

  test "success convert_token_headers when count of warnings non consistent 2" do
    assert {:error, "Headers contains non consistent warnings list"} ==
             ChannexPCI.convert_token_headers(%{
               tokens: ["token_1", "", "token_3"],
               errors: ["", "error_2", ""],
               warnings: ["warning_1", "warning_2"]
             })
  end

  test "success convert_token_headers when count of errors non consistent" do
    assert {:error, "Headers contains non consistent errors list"} =
             ChannexPCI.convert_token_headers(%{
               tokens: ["token_1", "token_3"],
               errors: ["error_2"],
               warnings: ["", ""]
             })
  end
end
