defmodule ExECPay.Config do
  @config_vars [
    :service_url,
    :merchant_id,
    :hash_key,
    :hash_iv,
    :base_url
  ]

  Enum.each(@config_vars, fn k ->
    def unquote(k)(), do: Application.get_env(:ex_ecpay, unquote(k))
  end)
end
