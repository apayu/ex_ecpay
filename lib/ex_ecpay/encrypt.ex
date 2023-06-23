defmodule ExECPay.Encrypt do
  alias ExECPay.Config
  alias ExECPay.AIOParams

  # ecppay CheckMacValue check mechanism, reference to https://developers.ecpay.com.tw/?p=2902
  def compare_check_mac_value(%{"CheckMacValue" => check_mac_value} = callback_params) do
    callback_params
    |> Map.reject(fn {k, _v} -> k == "CheckMacValue" end)
    |> calculate_check_mac_value()
    |> then(&(&1 == check_mac_value))
  end

  def calculate_check_mac_value(ecpay_params) do
    ecpay_params
    |> Map.to_list()
    |> Keyword.drop([:__struct__])
    |> Keyword.drop([:check_mac_value])
    |> Enum.sort_by(& &1)
    |> Enum.map_join("&", fn {k, v} -> fetch_field_name(k) <> "=" <> v end)
    |> then(&("HashKey=#{Config.hash_key()}&" <> &1 <> "&HashIV=#{Config.hash_iv()}"))
    |> URI.encode_www_form()
    |> ecpay_url_encode()
    |> String.downcase()
    |> then(&:crypto.hash(:sha256, &1))
    |> Base.encode16(case: :upper)
  end

  # ecpay URLEncode, reference to https://developers.ecpay.com.tw/?p=2904
  defp ecpay_url_encode(value) do
    value
    |> String.replace("%29", ")")
    |> String.replace("%28", "(")
  end

  def fetch_field_name(key) do
    Keyword.fetch!(AIOParams.attr(), key)
  end
end
