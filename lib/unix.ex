defmodule Mint.Core.Transport.UNIX do
  @moduledoc false

  @behaviour Mint.Core.Transport

  @transport_opts :stream

  @option_map [
    buffer: :rcvctrlbuf,
    recbuf: :rcvctrlbuf,
    sndbuf: :sndctrlbuf
  ]

  @impl true
  def connect(_hostname, _port, opts) do
    with {:ok, socket_file} <- Keyword.fetch(opts, :socket),
         {:ok, socket} <- :socket.open(:local, @transport_opts),
         :ok <- :socket.connect(socket, %{family: :local, path: socket_file}) do
      {:ok, socket}
    else
      :error -> wrap_error("Missing :socket option")
      error -> wrap_err(error)
    end
  end

  @impl true
  def upgrade(socket, _scheme, _hostname, _port, _opts) do
    {:ok, socket}
  end

  @impl true
  def negotiated_protocol(_socket), do: wrap_err({:error, :protocol_not_negotiated})

  @impl true
  def send(socket, payload) do
    wrap_err(:socket.send(socket, payload))
  end

  @impl true
  defdelegate close(socket), to: :socket

  @impl true
  def recv(socket, bytes, timeout) do
    wrap_err(:socket.recv(socket, bytes, timeout))
  end

  @impl true
  def controlling_process(socket, _pid) do
    wrap_err(:socket.getopt(socket, :otp, :controlling_process))
  end

  @impl true
  def setopts(_socket, []) do
    :ok
  end

  def setopts(socket, [{option, value} | opts]) do
    case setopt(socket, option, value) do
      :ok -> setopts(socket, opts)
      error -> wrap_err(error)
    end
  end

  defp setopt(socket, option, value) do
    :socket.setopt(socket, :otp, map_option(option), value)
  end

  @impl true
  def getopts(_socket, []) do
    {:ok, []}
  end

  def getopts(socket, [option | opts]) do
    with {:ok, res_opts} <- getopts(socket, opts),
         {:ok, value} <- getopt(socket, option) do
      {:ok, Keyword.put(res_opts, option, value)}
    else
      error -> wrap_err(error)
    end
  end

  defp getopt(socket, option) do
    :socket.getopt(socket, :otp, map_option(option))
  end

  defp map_option(option) do
    @option_map[option] || option
  end

  @impl true
  def wrap_error(reason) do
    %Mint.TransportError{reason: reason}
  end

  defp wrap_err({:error, reason}), do: {:error, wrap_error(reason)}
  defp wrap_err(other), do: other
end
