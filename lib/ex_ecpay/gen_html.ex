defmodule ExECPay.GenHTML do
  import Phoenix.HTML
  import Phoenix.HTML.Tag

  alias ExECPay.{Config, AIOParams, Encrypt}

  def gen_ecpay_html(aio_params) do
    ecpay_post_form(aio_params) <>
      "<script type=\"text/javascript\">document.getElementById(\"_form_aiochk\").submit();</script>"
  end

  def ecpay_post_form(aio_params) do
    check_mac_value = Encrypt.calculate_check_mac_value(aio_params)
    aio_params = %{aio_params | check_mac_value: check_mac_value}

    content_tag :form, action: Config.service_url(), method: "post", id: "_form_aiochk" do
      for {key, value} <- Map.to_list(aio_params) |> Keyword.drop([:__struct__]) do
        tag(:input,
          type: "hidden",
          name: fetch_field_name(key),
          id: fetch_field_name(key),
          value: value
        )
      end
    end
    |> safe_to_string()
  end

  def fetch_field_name(key) do
    Keyword.fetch!(AIOParams.attr(), key)
  end
end
