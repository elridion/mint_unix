defmodule MintUnixTest do
  use ExUnit.Case
  doctest MintUnix

  test "greets the world" do
    assert MintUnix.hello() == :world
  end
end
