defmodule ExECPay.EncryptTest do
  use ExUnit.Case
  alias ExECPay.Encrypt

  @application :ex_ecpay

  def ecpay_params(_) do
    %{
      ecpay_params: %{
        "CheckMacValue" => "1C5F538510DEBED36507365F02E0BF6F4BEC0F9236677139BF7B657EECB204F9",
        "CustomField1" => "",
        "CustomField2" => "",
        "CustomField3" => "",
        "CustomField4" => "",
        "MerchantID" => "2000132",
        "MerchantTradeNo" => "4Y9qJQbkvI5fZZtKPOZx",
        "PaymentDate" => "2022/10/06 23:21:21",
        "PaymentType" => "Credit_CreditCard",
        "PaymentTypeChargeFee" => "0",
        "RtnCode" => "1",
        "RtnMsg" => "付款成功",
        "SimulatePaid" => "1",
        "StoreID" => "",
        "TradeAmt" => "3015",
        "TradeDate" => "2022/10/06 22:28:50",
        "TradeNo" => "2210062228500226"
      }
    }
  end

  describe "compare_check_mac_value/1" do
    setup [:ecpay_params]

    test "when ecpay params is valid", %{ecpay_params: ecpay_params} do
      Application.put_env(@application, :hash_key, "5294y06JbISpM5x9")
      Application.put_env(@application, :hash_iv, "v77hoKGq4kWxNNIS")
      Application.put_env(@application, :merchant_id, "2000132")
      assert Encrypt.compare_check_mac_value(ecpay_params) == true
    end

    test "when ecpay params is NOT valid", %{ecpay_params: ecpay_params} do
      assert Encrypt.compare_check_mac_value(ecpay_params) == false
    end
  end
end
