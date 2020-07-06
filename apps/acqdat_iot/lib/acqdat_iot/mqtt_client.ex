defmodule MqttClient do
  def setup_connection() do
    {:ok, pid} =
    Tortoise.Connection.start_link(
      client_id: "elixir_client",
      user_name: "something",
      password: "something1",
      handler: {Tortoise.Handler.Logger, []},
      server: {Tortoise.Transport.Tcp, host: 'localhost', port: 1883},
      subscriptions: [{"/devices/1/org/1project/1/gateway/1/events", 0}]
    )
  end

  def publish() do
    Tortoise.publish("elixir_client", "/org/1/project/1/gateway/1/config", "Hello from the World of Tomorrow !", qos: 0)
  end
end
