defmodule ChiliPlayerTest do
  use ExUnit.Case
  doctest Player

  test "GET videos with invalid token" do
    assert ChiliPlayer.videos([token: "some_invalid_token"]) == {:error, "Unauthorized - Check your credentials"}
  end

  test "GET videos with empty params" do
    assert ChiliPlayer.videos() == {:error, "Unauthorized - Check your credentials"}
  end
end
