-module(erd_http).

-export([start/0]).

start() -> application:ensure_all_started( erd_http ).
