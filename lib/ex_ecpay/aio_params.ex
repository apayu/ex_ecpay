defmodule ExECPay.AIOParams do
  alias ExECPay.Config

  @attr [
    merchant_id: "MerchantID",
    merchant_trade_no: "MerchantTradeNo",
    merchant_trade_date: "MerchantTradeDate",
    payment_type: "PaymentType",
    total_amount: "TotalAmount",
    trade_desc: "TradeDesc",
    item_name: "ItemName",
    return_url: "ReturnURL",
    payment_info_url: "PaymentInfoURL",
    encrypt_type: "EncryptType",
    choose_payment: "ChoosePayment",
    check_mac_value: "CheckMacValue"
  ]

  defstruct merchant_id: Config.merchant_id(),
            merchant_trade_no: nil,
            merchant_trade_date: nil,
            payment_type: "aio",
            total_amount: nil,
            trade_desc: nil,
            item_name: nil,
            return_url: "#{Config.base_url()}/ecpay/callback",
            payment_info_url: "#{Config.base_url()}/ecpay/payment_info",
            encrypt_type: "1",
            choose_payment: nil,
            check_mac_value: nil

  def attr(), do: @attr
end
