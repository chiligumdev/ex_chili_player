defmodule ChiliPlayerTest do
  use ExUnit.Case
  doctest Player

  setup_all do
    {:ok, invalid_token: "someinvalidtoken"}
  end

  describe "Try to GET videos with invalid auth paramenters" do
    test "GET videos with invalid token", state do
      assert ChiliPlayer.videos([token: state[:invalid_token]]) == {:error, "Unauthorized - Check your credentials"}
      assert ChiliPlayer.videos() == {:error, "Unauthorized - Check your credentials"}
      refute ChiliPlayer.videos([token: FigaroElixir.env["token"]]) == {:ok, %{}}
    end
  end
end
