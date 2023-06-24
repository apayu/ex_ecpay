# ex_ecpay

# Installation
Add :ex_ecpay as a dependency in your mix.exs file.
```elixir
def deps do
  [
    {:ex_ecpay, "~> 0.1.0"}
  ]
end
```

# Configuration
```elixir
import Config

config :ex_ecpay,
  service_url: "https://payment-stage.ecpay.com.tw/Cashier/AioCheckOut/V5",
  merchant_id: "your_merchant_id",
  hash_key: "your_hash_key",
  hash_iv: "your_hash_iv",
  base_url: "your url"
```

# Usage example
