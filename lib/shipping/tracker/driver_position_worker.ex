defmodule Shipping.Tracker.DriverPositionWorker do
    use GenServer
  
    alias Shipping.Driver.Events.LoadPickedUp
    alias Shipping.Driver.Events.LoadDelivered
    alias Shipping.Shipper.Events.LoadCreated

    @name __MODULE__
  
    def start_link() do
      GenServer.start_link(__MODULE__, [], name: @name)
    end
  
    def init([]) do
      Shipping.PubSub.subscribe("load_created", self())
      Shipping.PubSub.subscribe("load_picked_up", self())
      Shipping.PubSub.subscribe("load_delivered", self())

      {:ok, []}
    end
  
    def handle_info(%LoadCreated{} = event, state) do

      {:noreply, state}
    end
  

    def handle_info(%LoadPickedUp{} = event, state) do
      
      {:noreply, state}
    end

    def handle_info(%LoadDelivered{} = event, state) do
      
      {:noreply, state}
    end
end