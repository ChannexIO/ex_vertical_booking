defmodule ExVerticalBooking.Response.OtaReadTest do
  use ExUnit.Case
  doctest ExVerticalBooking
  @moduletag :ex_vertical_booking_response_ota_read

  alias ExVerticalBooking.Response.Converter
  alias ExVerticalBooking.Response.OtaRead

  @raw_message {"OTA_ResRetrieveRS", %{},
                [
                  {"Success", %{}, []},
                  {"ReservationsList", %{},
                   [
                     {"HotelReservation",
                      %{
                        CreateDateTime: '2020-09-22T08:32:48+02:00',
                        ResStatus: 'Commit',
                        RoomStayReservation: 'true'
                      },
                      [
                        {"UniqueID",
                         %{
                           ID: '287329696/87030894|8953',
                           ID_Context: 'CrsConfirmNumber',
                           Type: '14'
                         }, []},
                        {"RoomStays", %{},
                         [
                           {"RoomStay", %{},
                            [
                              {"RoomTypes", %{},
                               [
                                 {"RoomType", %{NumberOfUnits: '1', RoomTypeCode: 'ExecDouble'},
                                  []}
                               ]},
                              {"RatePlans", %{}, [{"RatePlan", %{RatePlanCode: 'roomonly'}, []}]},
                              {"RoomRates", %{},
                               [
                                 {"RoomRate",
                                  %{RatePlanCode: 'roomonly', RoomTypeCode: 'ExecDouble'},
                                  [
                                    {"Rates", %{},
                                     [
                                       {"Rate",
                                        %{
                                          EffectiveDate: '2020-10-29',
                                          ExpireDate: '2020-10-30',
                                          RateTimeUnit: 'Day'
                                        },
                                        [
                                          {"Base",
                                           %{AmountAfterTax: '0.0000', CurrencyCode: 'GBP'}, []},
                                          {"Discount", %{AmountAfterTax: '85.0000'},
                                           [{"DiscountReason", %{}, [{"Text", %{}, ["7x6"]}]}]}
                                        ]}
                                     ]}
                                  ]}
                               ]},
                              {"GuestCounts", %{},
                               [{"GuestCount", %{AgeQualifyingCode: '10', Count: '2'}, []}]},
                              {"TimeSpan", %{End: '2020-10-30', Start: '2020-10-23'}, []}
                            ]}
                         ]},
                        {"ResGuests", %{},
                         [
                           {"ResGuest", %{},
                            [
                              {"Profiles", %{},
                               [
                                 {"ProfileInfo", %{},
                                  [
                                    {"Profile", %{ProfileType: '1'},
                                     [
                                       {"Customer", %{BirthDate: '1950-12-31'},
                                        [
                                          {"PersonName", %{},
                                           [
                                             {"GivenName", %{}, ["tizio"]},
                                             {"Surname", %{}, ["caio"]}
                                           ]},
                                          {"Telephone",
                                           %{PhoneNumber: '0123456789', PhoneTechType: '1'}, []},
                                          {"Email", %{}, ["prova@microsoft.com"]},
                                          {"Address", %{},
                                           [
                                             {"AddressLine", %{}, ["via viole 15"]},
                                             {"CityName", %{}, ["Roma"]},
                                             {"PostalCode", %{}, ["12345"]},
                                             {"StateProv", %{}, ["RM"]},
                                             {"CountryName", %{}, ["IT"]}
                                           ]}
                                        ]}
                                     ]}
                                  ]}
                               ]}
                            ]}
                         ]},
                        {"ResGlobalInfo", %{},
                         [
                           {"HotelReservationIDs", %{},
                            [
                              {"HotelReservationID",
                               %{ResID_Type: '25', ResID_Value: '287329696/87030881|8947'}, []}
                            ]},
                           {"Comments", %{},
                            [
                              {"Comment", %{},
                               [
                                 {"Text", %{},
                                  [
                                    "GUEST NAME:Mario ROSSI\nLate arrive\nNo smoking room\nNr. guests: 2\nCommission Amount: 146.25"
                                  ]}
                               ]}
                            ]},
                           {"Guarantee", %{},
                            [
                              {"GuaranteesAccepted", %{},
                               [
                                 {"GuaranteeAccepted", %{PaymentTransactionTypeCode: 'charge'},
                                  [
                                    {"PaymentCard",
                                     %{
                                       CardCode: 'MC',
                                       CardNumber: '0000000000099',
                                       CardType: '1',
                                       ExpireDate: '0911',
                                       SeriesCode: '000'
                                     }, [{"CardHolderName", %{}, ["tizio"]}]}
                                  ]}
                               ]}
                            ]},
                           {"Total", %{AmountAfterTax: '731.25', CurrencyCode: 'GBP'}, []},
                           {"Profiles", %{},
                            [
                              {"ProfileInfo", %{},
                               [
                                 {"UniqueID", %{ID: '11', ID_Context: 'CRS', Type: '32'}, []},
                                 {"Profile", %{ProfileType: '10'},
                                  [
                                    {"CompanyInfo", %{},
                                     [
                                       {"CompanyName",
                                        %{
                                          Code: '9606020',
                                          CodeContext: 'IATA',
                                          CompanyShortName: 'BOOKINGS GBPOPE B.V.'
                                        }, []},
                                       {"AddressInfo", %{}, []},
                                       {"TelephoneInfo",
                                        %{PhoneNumber: '0031-200005414', PhoneTechType: '1'}, []},
                                       {"BusinessLocale", %{},
                                        [
                                          {"AddressLine", %{},
                                           ["WETERINGSCHANS 28 - 4, 1017 SG"]},
                                          {"CityName", %{}, ["AMSTERDAM"]},
                                          {"PostalCode", %{}, ["1000"]},
                                          {"CountryName", %{}, ["NL"]}
                                        ]}
                                     ]}
                                  ]}
                               ]}
                            ]}
                         ]}
                      ]}
                   ]}
                ]}

  @message %{
    OTA_ResRetrieveRS: %{
      Success: %{},
      ReservationsList: [
        %{
          HotelReservation: %{
            "@CreateDateTime": '2020-09-22T08:32:48+02:00',
            "@ResStatus": 'Commit',
            "@RoomStayReservation": 'true',
            ResGlobalInfo: %{
              Comments: [
                %{
                  Comment: %{
                    Text:
                      "GUEST NAME:Mario ROSSI\nLate arrive\nNo smoking room\nNr. guests: 2\nCommission Amount: 146.25"
                  }
                }
              ],
              Guarantee: %{
                GuaranteesAccepted: [
                  %{
                    GuaranteeAccepted: %{
                      "@PaymentTransactionTypeCode": 'charge',
                      PaymentCard: %{
                        "@CardCode": 'MC',
                        "@CardNumber": '0000000000099',
                        "@CardType": '1',
                        "@ExpireDate": '0911',
                        "@SeriesCode": '000',
                        CardHolderName: "tizio"
                      }
                    }
                  }
                ]
              },
              HotelReservationIDs: [
                %{
                  HotelReservationID: %{
                    "@ResID_Type": '25',
                    "@ResID_Value": '287329696/87030881|8947'
                  }
                }
              ],
              Profiles: [
                %{
                  ProfileInfo: %{
                    Profile: %{
                      "@ProfileType": '10',
                      CompanyInfo: %{
                        AddressInfo: %{},
                        BusinessLocale: %{
                          AddressLine: "WETERINGSCHANS 28 - 4, 1017 SG",
                          CityName: "AMSTERDAM",
                          CountryName: "NL",
                          PostalCode: "1000"
                        },
                        CompanyName: %{
                          "@Code": '9606020',
                          "@CodeContext": 'IATA',
                          "@CompanyShortName": 'BOOKINGS GBPOPE B.V.'
                        },
                        TelephoneInfo: %{"@PhoneNumber": '0031-200005414', "@PhoneTechType": '1'}
                      }
                    },
                    UniqueID: %{"@ID": '11', "@ID_Context": 'CRS', "@Type": '32'}
                  }
                }
              ],
              Total: %{"@AmountAfterTax": '731.25', "@CurrencyCode": 'GBP'}
            },
            RoomStays: [
              %{
                RoomStay: %{
                  GuestCounts: [%{GuestCount: %{"@AgeQualifyingCode": '10', "@Count": '2'}}],
                  RatePlans: [%{RatePlan: %{"@RatePlanCode": 'roomonly'}}],
                  RoomRates: [
                    %{
                      RoomRate: %{
                        "@RatePlanCode": 'roomonly',
                        "@RoomTypeCode": 'ExecDouble',
                        Rates: [
                          %{
                            Rate: %{
                              "@EffectiveDate": '2020-10-29',
                              "@ExpireDate": '2020-10-30',
                              "@RateTimeUnit": 'Day',
                              Base: %{"@AmountAfterTax": '0.0000', "@CurrencyCode": 'GBP'},
                              Discount: %{
                                "@AmountAfterTax": '85.0000',
                                DiscountReason: %{Text: "7x6"}
                              }
                            }
                          }
                        ]
                      }
                    }
                  ],
                  RoomTypes: [
                    %{RoomType: %{"@NumberOfUnits": '1', "@RoomTypeCode": 'ExecDouble'}}
                  ],
                  TimeSpan: %{"@End": '2020-10-30', "@Start": '2020-10-23'}
                }
              }
            ],
            UniqueID: %{
              "@ID": '287329696/87030894|8953',
              "@ID_Context": 'CrsConfirmNumber',
              "@Type": '14'
            },
            ResGuests: [
              %{
                ResGuest: %{
                  Profiles: [
                    %{
                      ProfileInfo: %{
                        Profile: %{
                          "@ProfileType": '1',
                          Customer: %{
                            "@BirthDate": '1950-12-31',
                            Address: %{
                              AddressLine: "via viole 15",
                              CityName: "Roma",
                              CountryName: "IT",
                              PostalCode: "12345",
                              StateProv: "RM"
                            },
                            Email: "prova@microsoft.com",
                            PersonName: %{GivenName: "tizio", Surname: "caio"},
                            Telephone: %{"@PhoneNumber": '0123456789', "@PhoneTechType": '1'}
                          }
                        }
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }

  test "convert" do
    assert {:ok, @message, %{}} ==
             Converter.convert({:ok, @raw_message, %{}}, OtaRead.list_nodes())
  end
end
