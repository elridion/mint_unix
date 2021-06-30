# MintUnix

Mint transport implementation for UNIX sockets.  
Documentation is available on [hex](https://hexdocs.pm/mint_unix).
## Installation

The package can be installed by adding `mint_unix` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:mint_unix, "~> 0.1.0"}
  ]
end
```
## Usage

Manually create a HTTP1 or HTTP2 Mint connection wich can be used afterwards.

```elixir
alias Mint.Core.Transport.UNIX

opts = [mode: :passive, transport_opts: [socket: "/var/run/myapplication.sock"]]

{:ok, conn} = Mint.HTTP1.connect(UNIX, "localhost", 80, opts)
```

The connection can then be used as documented in the Mint [documentation](https://hex.pm/packages/mint).
