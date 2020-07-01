defmodule ExVerticalBooking.Request.PCIProxies.Fixtures do
  @fixture %{
    vb_response: ~s(
<?xml version="1.0" encoding="UTF-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://schemas.xmlsoap.org/ws/2004/08/addressing" xmlns:ns2="http://www.opentravel.org/OTA/2003/05">
    <SOAP-ENV:Header>
        <ns1:MessageID>uuid:6548d817-95bb-49e4-2192-9becc3c73294</ns1:MessageID>
        <ns1:To>http://www.gestionealbergo.com/ws/ota</ns1:To>
        <ns1:From>
            <Address>http://schemas.xmlsoap.org/ws/2004/12/addressing/role/anonymous</Address>
        </ns1:From>
        <ns1:RelatesTo RelationshipType="ns1:Reply">uuid:712e7f5b-8353-d6b9-1531-
b27d5a53f6d7</ns1:RelatesTo>
        <ns1:Action>http://www.aec-internet.it/booking_engine/int/gestione
albergo/OTA_ResRetrieveRS</ns1:Action>
    </SOAP-ENV:Header>
    <SOAP-ENV:Body>
        <ns2:OTA_ResRetrieveRS>
            <ns2:Success />
            <ns2:ReservationsList>
                <ns2:HotelReservation RoomStayReservation="true" ResStatus="Commit" CreateDateTime="2010-09-22T08:32:48+02:00">
                    <ns2:UniqueID Type="14" ID_Context="CrsConfirmNumber" ID="287329696/87030894|8953" />
                    <ns2:RoomStays>
                        <ns2:RoomStay>
                            <ns2:RoomTypes>
                                <ns2:RoomType RoomTypeCode="MTRD" NumberOfUnits="1" />
                            </ns2:RoomTypes>
                            <ns2:RatePlans>
                                <ns2:RatePlan RatePlanCode="BB_BAR" />
                            </ns2:RatePlans>
                            <ns2:RoomRates>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-23" ExpireDate="2010- 10-24">
                                            <ns2:Base AmountAfterTax="200.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-24" ExpireDate="2010- 10-25">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-25" ExpireDate="2010- 10-26">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-26" ExpireDate="2010- 10-27">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-27" ExpireDate="2010- 10-28">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-28" ExpireDate="2010- 10-29">
                                            <ns2:Base AmountAfterTax="72.2500" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-29" ExpireDate="2010- 10-30">
                                            <ns2:Base AmountAfterTax="0.0000" CurrencyCode="EUR" />
                                            <ns2:Discount AmountAfterTax="85.0000">
                                                <ns2:DiscountReason>
                                                    <ns2:Text>7x6</ns2:Text>
                                                </ns2:DiscountReason>
                                            </ns2:Discount>
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                            </ns2:RoomRates>
                            <GuestCounts>
                                <GuestCount AgeQualifyingCode="10" Count="2" />
                            </GuestCounts>
                            <ns2:TimeSpan Start="2010-10-23" End="2010-10-30" />
                        </ns2:RoomStay>
                    </ns2:RoomStays>
                    <ns2:ResGuests>
                        <ns2:ResGuest>
                            <ns2:Profiles>
                                <ns2:ProfileInfo>
                                    <ns2:Profile ProfileType="1">
                                        <ns2:Customer BirthDate="1950-12-31">
                                            <ns2:PersonName>
                                                <ns2:GivenName>Not valid card</ns2:GivenName>
                                                <ns2:Surname>caio</ns2:Surname>
                                            </ns2:PersonName>
                                            <ns2:Telephone PhoneTechType="1" PhoneNumber="0123456789" />
                                            <ns2:Email>prova@microsoft.com</ns2:Email>
                                            <ns2:Address>
                                                <ns2:AddressLine>via viole 15</ns2:AddressLine>
                                                <ns2:CityName>Roma</ns2:CityName>
                                                <ns2:PostalCode>12345</ns2:PostalCode>
                                                <ns2:StateProv>RM</ns2:StateProv>
                                                <ns2:CountryName>IT</ns2:CountryName>
                                            </ns2:Address>
                                        </ns2:Customer>
                                    </ns2:Profile>
                                </ns2:ProfileInfo>
                            </ns2:Profiles>
                        </ns2:ResGuest>
                    </ns2:ResGuests>
                    <ns2:ResGlobalInfo>
                        <ns2:HotelReservationIDs>
                            <ns2:HotelReservationID ResID_Type="25" ResID_Value="287329696/87030881|8947" />
                        </ns2:HotelReservationIDs>
                        <ns2:Comments>
                            <ns2:Comment>
                                <ns2:Text>
GUEST NAME:Mario ROSSI
Late arrive
No smoking room
Nr. guests: 2
Commission Amount: 146.25
</ns2:Text>
                            </ns2:Comment>
                        </ns2:Comments>
                        <ns2:Guarantee>
                            <ns2:GuaranteesAccepted>
                                <ns2:GuaranteeAccepted PaymentTransactionTypeCode="charge">
                                    <ns2:PaymentCard CardType="1" CardCode="AX" CardNumber="346711457470000" SeriesCode="000" ExpireDate="0925">
                                        <ns2:CardHolderName>Not valid card</ns2:CardHolderName>
                                    </ns2:PaymentCard>
                                </ns2:GuaranteeAccepted>
                            </ns2:GuaranteesAccepted>
                        </ns2:Guarantee>
                        <ns2:Total AmountAfterTax="731.25" CurrencyCode="EUR" />
                        <ns2:Profiles>
                            <ns2:ProfileInfo>
                                <ns2:UniqueID Type="32" ID_Context="CRS" ID="11" />
                                <ns2:Profile ProfileType="10">
                                    <ns2:CompanyInfo>
                                        <ns2:CompanyName CompanyShortName="BOOKINGS EUROPE B.V." Code="9606020" CodeContext="IATA" />
                                        <ns2:AddressInfo />
                                        <ns2:TelephoneInfo PhoneTechType="1" PhoneNumber="0031-200005414" />
                                        <ns2:BusinessLocale>
                                            <ns2:AddressLine>WETERINGSCHANS 28 - 4, 1017 SG</ns2:AddressLine>
                                            <ns2:CityName>AMSTERDAM</ns2:CityName>
                                            <ns2:PostalCode>1000</ns2:PostalCode>
                                            <ns2:CountryName>NL</ns2:CountryName>
                                        </ns2:BusinessLocale>
                                    </ns2:CompanyInfo>
                                </ns2:Profile>
                            </ns2:ProfileInfo>
                        </ns2:Profiles>
                    </ns2:ResGlobalInfo>
                </ns2:HotelReservation>
                <ns2:HotelReservation RoomStayReservation="true" ResStatus="Commit" CreateDateTime="2010-09-22T08:32:48+02:00">
                    <ns2:UniqueID Type="14" ID_Context="CrsConfirmNumber" ID="287329696/87030894|8953" />
                    <ns2:RoomStays>
                        <ns2:RoomStay>
                            <ns2:RoomTypes>
                                <ns2:RoomType RoomTypeCode="MTRD" NumberOfUnits="1" />
                            </ns2:RoomTypes>
                            <ns2:RatePlans>
                                <ns2:RatePlan RatePlanCode="BB_BAR" />
                            </ns2:RatePlans>
                            <ns2:RoomRates>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-23" ExpireDate="2010- 10-24">
                                            <ns2:Base AmountAfterTax="200.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-24" ExpireDate="2010- 10-25">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-25" ExpireDate="2010- 10-26">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-26" ExpireDate="2010- 10-27">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-27" ExpireDate="2010- 10-28">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-28" ExpireDate="2010- 10-29">
                                            <ns2:Base AmountAfterTax="72.2500" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-29" ExpireDate="2010- 10-30">
                                            <ns2:Base AmountAfterTax="0.0000" CurrencyCode="EUR" />
                                            <ns2:Discount AmountAfterTax="85.0000">
                                                <ns2:DiscountReason>
                                                    <ns2:Text>7x6</ns2:Text>
                                                </ns2:DiscountReason>
                                            </ns2:Discount>
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                            </ns2:RoomRates>
                            <GuestCounts>
                                <GuestCount AgeQualifyingCode="10" Count="2" />
                            </GuestCounts>
                            <ns2:TimeSpan Start="2010-10-23" End="2010-10-30" />
                        </ns2:RoomStay>
                    </ns2:RoomStays>
                    <ns2:ResGuests>
                        <ns2:ResGuest>
                            <ns2:Profiles>
                                <ns2:ProfileInfo>
                                    <ns2:Profile ProfileType="1">
                                        <ns2:Customer BirthDate="1950-12-31">
                                            <ns2:PersonName>
                                                <ns2:GivenName>Master card</ns2:GivenName>
                                                <ns2:Surname>caio</ns2:Surname>
                                            </ns2:PersonName>
                                            <ns2:Telephone PhoneTechType="1" PhoneNumber="0123456789" />
                                            <ns2:Email>prova@microsoft.com</ns2:Email>
                                            <ns2:Address>
                                                <ns2:AddressLine>via viole 15</ns2:AddressLine>
                                                <ns2:CityName>Roma</ns2:CityName>
                                                <ns2:PostalCode>12345</ns2:PostalCode>
                                                <ns2:StateProv>RM</ns2:StateProv>
                                                <ns2:CountryName>IT</ns2:CountryName>
                                            </ns2:Address>
                                        </ns2:Customer>
                                    </ns2:Profile>
                                </ns2:ProfileInfo>
                            </ns2:Profiles>
                        </ns2:ResGuest>
                    </ns2:ResGuests>
                    <ns2:ResGlobalInfo>
                        <ns2:HotelReservationIDs>
                            <ns2:HotelReservationID ResID_Type="25" ResID_Value="287329696/87030881|8947" />
                        </ns2:HotelReservationIDs>
                        <ns2:Comments>
                            <ns2:Comment>
                                <ns2:Text>
GUEST NAME:Mario ROSSI
Late arrive
No smoking room
Nr. guests: 2
Commission Amount: 146.25
</ns2:Text>
                            </ns2:Comment>
                        </ns2:Comments>
                        <ns2:Guarantee>
                            <ns2:GuaranteesAccepted>
                                <ns2:GuaranteeAccepted PaymentTransactionTypeCode="charge">
                                    <ns2:PaymentCard CardType="17" CardCode="MC" CardNumber="5289821252358403" SeriesCode="000" ExpireDate="0925">
                                        <ns2:CardHolderName>Master card</ns2:CardHolderName>
                                    </ns2:PaymentCard>
                                </ns2:GuaranteeAccepted>
                            </ns2:GuaranteesAccepted>
                        </ns2:Guarantee>
                        <ns2:Total AmountAfterTax="731.25" CurrencyCode="EUR" />
                        <ns2:Profiles>
                            <ns2:ProfileInfo>
                                <ns2:UniqueID Type="32" ID_Context="CRS" ID="11" />
                                <ns2:Profile ProfileType="10">
                                    <ns2:CompanyInfo>
                                        <ns2:CompanyName CompanyShortName="BOOKINGS EUROPE B.V." Code="9606020" CodeContext="IATA" />
                                        <ns2:AddressInfo />
                                        <ns2:TelephoneInfo PhoneTechType="1" PhoneNumber="0031-200005414" />
                                        <ns2:BusinessLocale>
                                            <ns2:AddressLine>WETERINGSCHANS 28 - 4, 1017 SG</ns2:AddressLine>
                                            <ns2:CityName>AMSTERDAM</ns2:CityName>
                                            <ns2:PostalCode>1000</ns2:PostalCode>
                                            <ns2:CountryName>NL</ns2:CountryName>
                                        </ns2:BusinessLocale>
                                    </ns2:CompanyInfo>
                                </ns2:Profile>
                            </ns2:ProfileInfo>
                        </ns2:Profiles>
                    </ns2:ResGlobalInfo>
                </ns2:HotelReservation>
                <ns2:HotelReservation RoomStayReservation="true" ResStatus="Commit" CreateDateTime="2010-09-22T08:32:48+02:00">
                    <ns2:UniqueID Type="14" ID_Context="CrsConfirmNumber" ID="287329696/87030894|8953" />
                    <ns2:RoomStays>
                        <ns2:RoomStay>
                            <ns2:RoomTypes>
                                <ns2:RoomType RoomTypeCode="MTRD" NumberOfUnits="1" />
                            </ns2:RoomTypes>
                            <ns2:RatePlans>
                                <ns2:RatePlan RatePlanCode="BB_BAR" />
                            </ns2:RatePlans>
                            <ns2:RoomRates>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-23" ExpireDate="2010- 10-24">
                                            <ns2:Base AmountAfterTax="200.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-24" ExpireDate="2010- 10-25">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-25" ExpireDate="2010- 10-26">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-26" ExpireDate="2010- 10-27">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-27" ExpireDate="2010- 10-28">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-28" ExpireDate="2010- 10-29">
                                            <ns2:Base AmountAfterTax="72.2500" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-29" ExpireDate="2010- 10-30">
                                            <ns2:Base AmountAfterTax="0.0000" CurrencyCode="EUR" />
                                            <ns2:Discount AmountAfterTax="85.0000">
                                                <ns2:DiscountReason>
                                                    <ns2:Text>7x6</ns2:Text>
                                                </ns2:DiscountReason>
                                            </ns2:Discount>
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                            </ns2:RoomRates>
                            <GuestCounts>
                                <GuestCount AgeQualifyingCode="10" Count="2" />
                            </GuestCounts>
                            <ns2:TimeSpan Start="2010-10-23" End="2010-10-30" />
                        </ns2:RoomStay>
                    </ns2:RoomStays>
                    <ns2:ResGuests>
                        <ns2:ResGuest>
                            <ns2:Profiles>
                                <ns2:ProfileInfo>
                                    <ns2:Profile ProfileType="1">
                                        <ns2:Customer BirthDate="1950-12-31">
                                            <ns2:PersonName>
                                                <ns2:GivenName>Master card duplicate</ns2:GivenName>
                                                <ns2:Surname>caio</ns2:Surname>
                                            </ns2:PersonName>
                                            <ns2:Telephone PhoneTechType="1" PhoneNumber="0123456789" />
                                            <ns2:Email>prova@microsoft.com</ns2:Email>
                                            <ns2:Address>
                                                <ns2:AddressLine>via viole 15</ns2:AddressLine>
                                                <ns2:CityName>Roma</ns2:CityName>
                                                <ns2:PostalCode>12345</ns2:PostalCode>
                                                <ns2:StateProv>RM</ns2:StateProv>
                                                <ns2:CountryName>IT</ns2:CountryName>
                                            </ns2:Address>
                                        </ns2:Customer>
                                    </ns2:Profile>
                                </ns2:ProfileInfo>
                            </ns2:Profiles>
                        </ns2:ResGuest>
                    </ns2:ResGuests>
                    <ns2:ResGlobalInfo>
                        <ns2:HotelReservationIDs>
                            <ns2:HotelReservationID ResID_Type="25" ResID_Value="287329696/87030881|8947" />
                        </ns2:HotelReservationIDs>
                        <ns2:Comments>
                            <ns2:Comment>
                                <ns2:Text>
GUEST NAME:Mario ROSSI
Late arrive
No smoking room
Nr. guests: 2
Commission Amount: 146.25
</ns2:Text>
                            </ns2:Comment>
                        </ns2:Comments>
                        <ns2:Guarantee>
                            <ns2:GuaranteesAccepted>
                                <ns2:GuaranteeAccepted PaymentTransactionTypeCode="charge">
                                    <ns2:PaymentCard CardType="17" CardCode="MC" CardNumber="5289821252358403" SeriesCode="000" ExpireDate="0925">
                                        <ns2:CardHolderName>Master card duplicate</ns2:CardHolderName>
                                    </ns2:PaymentCard>
                                </ns2:GuaranteeAccepted>
                            </ns2:GuaranteesAccepted>
                        </ns2:Guarantee>
                        <ns2:Total AmountAfterTax="731.25" CurrencyCode="EUR" />
                        <ns2:Profiles>
                            <ns2:ProfileInfo>
                                <ns2:UniqueID Type="32" ID_Context="CRS" ID="11" />
                                <ns2:Profile ProfileType="10">
                                    <ns2:CompanyInfo>
                                        <ns2:CompanyName CompanyShortName="BOOKINGS EUROPE B.V." Code="9606020" CodeContext="IATA" />
                                        <ns2:AddressInfo />
                                        <ns2:TelephoneInfo PhoneTechType="1" PhoneNumber="0031-200005414" />
                                        <ns2:BusinessLocale>
                                            <ns2:AddressLine>WETERINGSCHANS 28 - 4, 1017 SG</ns2:AddressLine>
                                            <ns2:CityName>AMSTERDAM</ns2:CityName>
                                            <ns2:PostalCode>1000</ns2:PostalCode>
                                            <ns2:CountryName>NL</ns2:CountryName>
                                        </ns2:BusinessLocale>
                                    </ns2:CompanyInfo>
                                </ns2:Profile>
                            </ns2:ProfileInfo>
                        </ns2:Profiles>
                    </ns2:ResGlobalInfo>
                </ns2:HotelReservation>
                <ns2:HotelReservation RoomStayReservation="true" ResStatus="Commit" CreateDateTime="2010-09-22T08:32:48+02:00">
                    <ns2:UniqueID Type="14" ID_Context="CrsConfirmNumber" ID="287329696/87030894|8953" />
                    <ns2:RoomStays>
                        <ns2:RoomStay>
                            <ns2:RoomTypes>
                                <ns2:RoomType RoomTypeCode="MTRD" NumberOfUnits="1" />
                            </ns2:RoomTypes>
                            <ns2:RatePlans>
                                <ns2:RatePlan RatePlanCode="BB_BAR" />
                            </ns2:RatePlans>
                            <ns2:RoomRates>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-23" ExpireDate="2010- 10-24">
                                            <ns2:Base AmountAfterTax="200.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-24" ExpireDate="2010- 10-25">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-25" ExpireDate="2010- 10-26">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-26" ExpireDate="2010- 10-27">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-27" ExpireDate="2010- 10-28">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-28" ExpireDate="2010- 10-29">
                                            <ns2:Base AmountAfterTax="72.2500" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-29" ExpireDate="2010- 10-30">
                                            <ns2:Base AmountAfterTax="0.0000" CurrencyCode="EUR" />
                                            <ns2:Discount AmountAfterTax="85.0000">
                                                <ns2:DiscountReason>
                                                    <ns2:Text>7x6</ns2:Text>
                                                </ns2:DiscountReason>
                                            </ns2:Discount>
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                            </ns2:RoomRates>
                            <GuestCounts>
                                <GuestCount AgeQualifyingCode="10" Count="2" />
                            </GuestCounts>
                            <ns2:TimeSpan Start="2010-10-23" End="2010-10-30" />
                        </ns2:RoomStay>
                    </ns2:RoomStays>
                    <ns2:ResGuests>
                        <ns2:ResGuest>
                            <ns2:Profiles>
                                <ns2:ProfileInfo>
                                    <ns2:Profile ProfileType="1">
                                        <ns2:Customer BirthDate="1950-12-31">
                                            <ns2:PersonName>
                                                <ns2:GivenName>Bad card type</ns2:GivenName>
                                                <ns2:Surname>caio</ns2:Surname>
                                            </ns2:PersonName>
                                            <ns2:Telephone PhoneTechType="1" PhoneNumber="0123456789" />
                                            <ns2:Email>prova@microsoft.com</ns2:Email>
                                            <ns2:Address>
                                                <ns2:AddressLine>via viole 15</ns2:AddressLine>
                                                <ns2:CityName>Roma</ns2:CityName>
                                                <ns2:PostalCode>12345</ns2:PostalCode>
                                                <ns2:StateProv>RM</ns2:StateProv>
                                                <ns2:CountryName>IT</ns2:CountryName>
                                            </ns2:Address>
                                        </ns2:Customer>
                                    </ns2:Profile>
                                </ns2:ProfileInfo>
                            </ns2:Profiles>
                        </ns2:ResGuest>
                    </ns2:ResGuests>
                    <ns2:ResGlobalInfo>
                        <ns2:HotelReservationIDs>
                            <ns2:HotelReservationID ResID_Type="25" ResID_Value="287329696/87030881|8947" />
                        </ns2:HotelReservationIDs>
                        <ns2:Comments>
                            <ns2:Comment>
                                <ns2:Text>
GUEST NAME:Mario ROSSI
Late arrive
No smoking room
Nr. guests: 2
Commission Amount: 146.25
</ns2:Text>
                            </ns2:Comment>
                        </ns2:Comments>
                        <ns2:Guarantee>
                            <ns2:GuaranteesAccepted>
                                <ns2:GuaranteeAccepted PaymentTransactionTypeCode="charge">
                                    <ns2:PaymentCard CardType="24" CardCode="VI" CardNumber="6011023353494913" SeriesCode="000" ExpireDate="0925">
                                        <ns2:CardHolderName>Bad card type</ns2:CardHolderName>
                                    </ns2:PaymentCard>
                                </ns2:GuaranteeAccepted>
                            </ns2:GuaranteesAccepted>
                        </ns2:Guarantee>
                        <ns2:Total AmountAfterTax="731.25" CurrencyCode="EUR" />
                        <ns2:Profiles>
                            <ns2:ProfileInfo>
                                <ns2:UniqueID Type="32" ID_Context="CRS" ID="11" />
                                <ns2:Profile ProfileType="10">
                                    <ns2:CompanyInfo>
                                        <ns2:CompanyName CompanyShortName="BOOKINGS EUROPE B.V." Code="9606020" CodeContext="IATA" />
                                        <ns2:AddressInfo />
                                        <ns2:TelephoneInfo PhoneTechType="1" PhoneNumber="0031-200005414" />
                                        <ns2:BusinessLocale>
                                            <ns2:AddressLine>WETERINGSCHANS 28 - 4, 1017 SG</ns2:AddressLine>
                                            <ns2:CityName>AMSTERDAM</ns2:CityName>
                                            <ns2:PostalCode>1000</ns2:PostalCode>
                                            <ns2:CountryName>NL</ns2:CountryName>
                                        </ns2:BusinessLocale>
                                    </ns2:CompanyInfo>
                                </ns2:Profile>
                            </ns2:ProfileInfo>
                        </ns2:Profiles>
                    </ns2:ResGlobalInfo>
                </ns2:HotelReservation>
                <ns2:HotelReservation RoomStayReservation="true" ResStatus="Commit" CreateDateTime="2010-09-22T08:32:48+02:00">
                    <ns2:UniqueID Type="14" ID_Context="CrsConfirmNumber" ID="287329696/87030894|8953" />
                    <ns2:RoomStays>
                        <ns2:RoomStay>
                            <ns2:RoomTypes>
                                <ns2:RoomType RoomTypeCode="MTRD" NumberOfUnits="1" />
                            </ns2:RoomTypes>
                            <ns2:RatePlans>
                                <ns2:RatePlan RatePlanCode="BB_BAR" />
                            </ns2:RatePlans>
                            <ns2:RoomRates>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-23" ExpireDate="2010- 10-24">
                                            <ns2:Base AmountAfterTax="200.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-24" ExpireDate="2010- 10-25">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-25" ExpireDate="2010- 10-26">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-26" ExpireDate="2010- 10-27">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-27" ExpireDate="2010- 10-28">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-28" ExpireDate="2010- 10-29">
                                            <ns2:Base AmountAfterTax="72.2500" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-29" ExpireDate="2010- 10-30">
                                            <ns2:Base AmountAfterTax="0.0000" CurrencyCode="EUR" />
                                            <ns2:Discount AmountAfterTax="85.0000">
                                                <ns2:DiscountReason>
                                                    <ns2:Text>7x6</ns2:Text>
                                                </ns2:DiscountReason>
                                            </ns2:Discount>
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                            </ns2:RoomRates>
                            <GuestCounts>
                                <GuestCount AgeQualifyingCode="10" Count="2" />
                            </GuestCounts>
                            <ns2:TimeSpan Start="2010-10-23" End="2010-10-30" />
                        </ns2:RoomStay>
                    </ns2:RoomStays>
                    <ns2:ResGuests>
                        <ns2:ResGuest>
                            <ns2:Profiles>
                                <ns2:ProfileInfo>
                                    <ns2:Profile ProfileType="1">
                                        <ns2:Customer BirthDate="1950-12-31">
                                            <ns2:PersonName>
                                                <ns2:GivenName>Visa</ns2:GivenName>
                                                <ns2:Surname>caio</ns2:Surname>
                                            </ns2:PersonName>
                                            <ns2:Telephone PhoneTechType="1" PhoneNumber="0123456789" />
                                            <ns2:Email>prova@microsoft.com</ns2:Email>
                                            <ns2:Address>
                                                <ns2:AddressLine>via viole 15</ns2:AddressLine>
                                                <ns2:CityName>Roma</ns2:CityName>
                                                <ns2:PostalCode>12345</ns2:PostalCode>
                                                <ns2:StateProv>RM</ns2:StateProv>
                                                <ns2:CountryName>IT</ns2:CountryName>
                                            </ns2:Address>
                                        </ns2:Customer>
                                    </ns2:Profile>
                                </ns2:ProfileInfo>
                            </ns2:Profiles>
                        </ns2:ResGuest>
                    </ns2:ResGuests>
                    <ns2:ResGlobalInfo>
                        <ns2:HotelReservationIDs>
                            <ns2:HotelReservationID ResID_Type="25" ResID_Value="287329696/87030881|8947" />
                        </ns2:HotelReservationIDs>
                        <ns2:Comments>
                            <ns2:Comment>
                                <ns2:Text>
GUEST NAME:Mario ROSSI
Late arrive
No smoking room
Nr. guests: 2
Commission Amount: 146.25
</ns2:Text>
                            </ns2:Comment>
                        </ns2:Comments>
                        <ns2:Guarantee>
                            <ns2:GuaranteesAccepted>
                                <ns2:GuaranteeAccepted PaymentTransactionTypeCode="charge">
                                    <ns2:PaymentCard CardType="24" CardCode="VI" CardNumber="4210006979099699" SeriesCode="000" ExpireDate="0925">
                                        <ns2:CardHolderName>Visa</ns2:CardHolderName>
                                    </ns2:PaymentCard>
                                </ns2:GuaranteeAccepted>
                            </ns2:GuaranteesAccepted>
                        </ns2:Guarantee>
                        <ns2:Total AmountAfterTax="731.25" CurrencyCode="EUR" />
                        <ns2:Profiles>
                            <ns2:ProfileInfo>
                                <ns2:UniqueID Type="32" ID_Context="CRS" ID="11" />
                                <ns2:Profile ProfileType="10">
                                    <ns2:CompanyInfo>
                                        <ns2:CompanyName CompanyShortName="BOOKINGS EUROPE B.V." Code="9606020" CodeContext="IATA" />
                                        <ns2:AddressInfo />
                                        <ns2:TelephoneInfo PhoneTechType="1" PhoneNumber="0031-200005414" />
                                        <ns2:BusinessLocale>
                                            <ns2:AddressLine>WETERINGSCHANS 28 - 4, 1017 SG</ns2:AddressLine>
                                            <ns2:CityName>AMSTERDAM</ns2:CityName>
                                            <ns2:PostalCode>1000</ns2:PostalCode>
                                            <ns2:CountryName>NL</ns2:CountryName>
                                        </ns2:BusinessLocale>
                                    </ns2:CompanyInfo>
                                </ns2:Profile>
                            </ns2:ProfileInfo>
                        </ns2:Profiles>
                    </ns2:ResGlobalInfo>
                </ns2:HotelReservation>
                <ns2:HotelReservation RoomStayReservation="true" ResStatus="Commit" CreateDateTime="2010-09-22T08:32:48+02:00">
                    <ns2:UniqueID Type="14" ID_Context="CrsConfirmNumber" ID="287329696/87030894|8953" />
                    <ns2:RoomStays>
                        <ns2:RoomStay>
                            <ns2:RoomTypes>
                                <ns2:RoomType RoomTypeCode="MTRD" NumberOfUnits="1" />
                            </ns2:RoomTypes>
                            <ns2:RatePlans>
                                <ns2:RatePlan RatePlanCode="BB_BAR" />
                            </ns2:RatePlans>
                            <ns2:RoomRates>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-23" ExpireDate="2010- 10-24">
                                            <ns2:Base AmountAfterTax="200.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-24" ExpireDate="2010- 10-25">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-25" ExpireDate="2010- 10-26">
                                            <ns2:Base AmountAfterTax="102.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-26" ExpireDate="2010- 10-27">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-27" ExpireDate="2010- 10-28">
                                            <ns2:Base AmountAfterTax="85.0000" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-28" ExpireDate="2010- 10-29">
                                            <ns2:Base AmountAfterTax="72.2500" CurrencyCode="EUR" />
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                                <ns2:RoomRate RoomTypeCode="MTRD" RatePlanCode="BB_BAR">
                                    <ns2:Rates>
                                        <ns2:Rate RateTimeUnit="Day" EffectiveDate="2010-10-29" ExpireDate="2010- 10-30">
                                            <ns2:Base AmountAfterTax="0.0000" CurrencyCode="EUR" />
                                            <ns2:Discount AmountAfterTax="85.0000">
                                                <ns2:DiscountReason>
                                                    <ns2:Text>7x6</ns2:Text>
                                                </ns2:DiscountReason>
                                            </ns2:Discount>
                                        </ns2:Rate>
                                    </ns2:Rates>
                                </ns2:RoomRate>
                            </ns2:RoomRates>
                            <GuestCounts>
                                <GuestCount AgeQualifyingCode="10" Count="2" />
                            </GuestCounts>
                            <ns2:TimeSpan Start="2010-10-23" End="2010-10-30" />
                        </ns2:RoomStay>
                    </ns2:RoomStays>
                    <ns2:ResGuests>
                        <ns2:ResGuest>
                            <ns2:Profiles>
                                <ns2:ProfileInfo>
                                    <ns2:Profile ProfileType="1">
                                        <ns2:Customer BirthDate="1950-12-31">
                                            <ns2:PersonName>
                                                <ns2:GivenName>American Express</ns2:GivenName>
                                                <ns2:Surname>caio</ns2:Surname>
                                            </ns2:PersonName>
                                            <ns2:Telephone PhoneTechType="1" PhoneNumber="0123456789" />
                                            <ns2:Email>prova@microsoft.com</ns2:Email>
                                            <ns2:Address>
                                                <ns2:AddressLine>via viole 15</ns2:AddressLine>
                                                <ns2:CityName>Roma</ns2:CityName>
                                                <ns2:PostalCode>12345</ns2:PostalCode>
                                                <ns2:StateProv>RM</ns2:StateProv>
                                                <ns2:CountryName>IT</ns2:CountryName>
                                            </ns2:Address>
                                        </ns2:Customer>
                                    </ns2:Profile>
                                </ns2:ProfileInfo>
                            </ns2:Profiles>
                        </ns2:ResGuest>
                    </ns2:ResGuests>
                    <ns2:ResGlobalInfo>
                        <ns2:HotelReservationIDs>
                            <ns2:HotelReservationID ResID_Type="25" ResID_Value="287329696/87030881|8947" />
                        </ns2:HotelReservationIDs>
                        <ns2:Comments>
                            <ns2:Comment>
                                <ns2:Text>
GUEST NAME:Mario ROSSI
Late arrive
No smoking room
Nr. guests: 2
Commission Amount: 146.25
</ns2:Text>
                            </ns2:Comment>
                        </ns2:Comments>
                        <ns2:Guarantee>
                            <ns2:GuaranteesAccepted>
                                <ns2:GuaranteeAccepted PaymentTransactionTypeCode="charge">
                                    <ns2:PaymentCard CardType="1" CardCode="AX" CardNumber="346711457476666" SeriesCode="000" ExpireDate="0925">
                                        <ns2:CardHolderName>American Express</ns2:CardHolderName>
                                    </ns2:PaymentCard>
                                </ns2:GuaranteeAccepted>
                            </ns2:GuaranteesAccepted>
                        </ns2:Guarantee>
                        <ns2:Total AmountAfterTax="731.25" CurrencyCode="EUR" />
                        <ns2:Profiles>
                            <ns2:ProfileInfo>
                                <ns2:UniqueID Type="32" ID_Context="CRS" ID="11" />
                                <ns2:Profile ProfileType="10">
                                    <ns2:CompanyInfo>
                                        <ns2:CompanyName CompanyShortName="BOOKINGS EUROPE B.V." Code="9606020" CodeContext="IATA" />
                                        <ns2:AddressInfo />
                                        <ns2:TelephoneInfo PhoneTechType="1" PhoneNumber="0031-200005414" />
                                        <ns2:BusinessLocale>
                                            <ns2:AddressLine>WETERINGSCHANS 28 - 4, 1017 SG</ns2:AddressLine>
                                            <ns2:CityName>AMSTERDAM</ns2:CityName>
                                            <ns2:PostalCode>1000</ns2:PostalCode>
                                            <ns2:CountryName>NL</ns2:CountryName>
                                        </ns2:BusinessLocale>
                                    </ns2:CompanyInfo>
                                </ns2:Profile>
                            </ns2:ProfileInfo>
                        </ns2:Profiles>
                    </ns2:ResGlobalInfo>
                </ns2:HotelReservation>
            </ns2:ReservationsList>
        </ns2:OTA_ResRetrieveRS>
    </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
  ),
    response: %ExVerticalBooking.Response{
      body: "",
      headers: [
        {"Cache-Control", "no-cache"},
        {"Pragma", "no-cache"},
        {"Content-Length", "7956"},
        {"Content-Type", "application/xml; charset=UTF-8"},
        {"Expires", "-1"},
        {"X-pciBooking-Tokenization-Warnings",
         "[1004] The card number does not match the card type"},
        {"X-VERTICALBOOKINGFETCHCC",
         "https://service.pcibooking.net/api/payments/paycard/token_1;https://service.pcibooking.net/api/payments/paycard/token_2"},
        {"Date", "Wed, 23 Oct 2019 11:21:37 GMT"},
        {"X-XSS-Protection", "1; mode=block"},
        {"X-Content-Type-Options", "nosniff"}
      ],
      request_url:
        "https://service.pcibooking.net/api/payments/paycard/capture?sessionToken=79574c3482bc498f82b7afe8be295eb0&httpMethod=POST&profileName=VerticalBooking&targetURI=http://www.mocky.io/v2/5db0329e2f00007200c1398b&saveCVV=true",
      status_code: 200
    },
    meta: %{
      finished_at: ~U[2019-10-23 11:21:38.813141Z],
      headers: [
        ["Cache-Control", "no-cache"],
        ["Pragma", "no-cache"],
        ["Content-Length", "7956"],
        ["Content-Type", "application/xml; charset=UTF-8"],
        ["Expires", "-1"],
        [
          "X-pciBooking-Tokenization-Warnings",
          "[1004] The card number does not match the card type;;"
        ],
        [
          "X-VERTICALBOOKINGFETCHCC",
          "https://service.pcibooking.net/api/payments/paycard/token_1;https://service.pcibooking.net/api/payments/paycard/token_2"
        ],
        ["Date", "Wed, 23 Oct 2019 11:21:37 GMT"],
        ["X-XSS-Protection", "1; mode=block"],
        ["X-Content-Type-Options", "nosniff"]
      ],
      method: "POST",
      pci: %{
        errors: [],
        tokens: [
          "https://service.pcibooking.net/api/payments/paycard/token_1",
          "https://service.pcibooking.net/api/payments/paycard/token_2"
        ],
        warnings: ["[1004] The card number does not match the card type", ""]
      },
      request: "",
      response: "",
      success: true
    }
  }

  def get(key), do: @fixture[key]
  def get(), do: @fixture
end
