defmodule ExLiveReqCounter.Cache do
  use Nebulex.Cache,
    otp_app: :ex_live_req_counter,
    adapter: Nebulex.Adapters.Local
end
