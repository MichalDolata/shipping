defmodule Shipping.Tracker.Supervisor do
  use Supervisor

  @name __MODULE__

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: @name)
  end

  def init(_) do
    children = [
      supervisor(Shipping.Tracker.DriverPositionWorker, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
