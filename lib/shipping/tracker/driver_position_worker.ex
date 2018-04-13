defmodule Shipping.Tracker.DriverPositionWorker do
    use GenServer
  
    alias Shipping.Driver.Events.LoadPickedUp
    alias Shipping.Driver.Events.LoadDelivered
    alias Shipping.Shipper.Events.LoadCreated
    alias Shipping.Tracker.Events.DriverPositionChanged

    alias Shipping.Tracker
    alias Shipping.Tracker.LoadStorage

    @name __MODULE__
  
    def start_link() do
      GenServer.start_link(__MODULE__, [], name: @name)
    end
  
    def init([]) do
      Shipping.PubSub.subscribe("load_created", self())
      Shipping.PubSub.subscribe("load_picked_up", self())
      Shipping.PubSub.subscribe("load_delivered", self())
      Shipping.PubSub.subscribe("driver_position_changed", self())

      {:ok, []}
    end
  
    def handle_info(%LoadCreated{} = event, state) do
      LoadStorage.store_load(event)

      {:noreply, state}
    end
  

    def handle_info(%LoadPickedUp{} = event, state) do
      Tracker.handle_load_picked_up(event)

      {:noreply, state}
    end

    def handle_info(%LoadDelivered{} = event, state) do
      Tracker.handle_load_delivered(event)

      {:noreply, state}
    end

    def handle_info(%DriverPositionChanged{} = event, state) do
      IO.inspect(event)

      {:noreply, state}
    end
end