defmodule Customer do
  def take_ticket(customer_num) do
    receive do
      {:ticket} ->
      #  IO.puts("Customer got a ticket")
        waitForServer(customer_num)
      {:finish} ->
        exit(:normal)
    end
  end

  def waitForServer(customer_num) do
    receive do
      {:serve, server_num, manager, n, fibn} ->
        IO.puts("Customer was told that fib of #{n} equals #{fibn}")
        askForTicket(manager)
      {:finish} ->
        exit(:normal)
    end
  end

  def askForTicket(manager) do
    sleep_time = :rand.uniform(1000)
    :timer.sleep(sleep_time)
    IO.puts("asking for a ticket")
    send(manager, {:request_ticket, self()})
    take_ticket(self())
  end
end
