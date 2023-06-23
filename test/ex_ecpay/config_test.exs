defmodule ExECPay.ConfigTest do
  use ExUnit.Case
  alias ExECPay.Config

  @application :ex_ecpay

  setup_all do
    reset_env()
    on_exit(&reset_env/0)
  end

  test "service_url is recognized" do
    Application.put_env(
      @application,
      :service_url,
      "https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut/V5"
    )

    assert Config.service_url() == "https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut/V5"
  end

  test "merchant_id is recognized" do
    Application.put_env(@application, :merchant_id, "2000132")
    assert Config.merchant_id() == "2000132"
  end

  test "hash_key is recognized" do
    Application.put_env(@application, :hash_key, "test_key")
    assert Config.hash_key() == "test_key"
  end

  test "hash_iv is recognized" do
    Application.put_env(@application, :hash_iv, "test_iv")
    assert Config.hash_iv() == "test_iv"
  end

  test "base_url is recognized" do
    Application.put_env(@application, :base_url, "http://localhost:4000")
    assert Config.base_url() == "http://localhost:4000"
  end

  defp reset_env() do
    Application.get_all_env(@application)
    |> Keyword.keys()
    |> Enum.each(&Application.delete_env(@application, &1))
  end
end
