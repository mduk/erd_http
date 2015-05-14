%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(toppage_handler).

-export([init/2]).

init(Req, Opts) ->
  { ok, Die } = resource_discovery:get_resource( die ),
  N = erd_dice_die:roll( Die ),
	Req2 = cowboy_req:reply(200, [
		{<<"content-type">>, <<"text/plain">>}
	], io_lib:format(
    "Path ~s~n"
    "Request handler was ~p running on node ~s~n"
    "Die roll was ~p~n"
    "Die was ~p running on node ~p~n", [
    cowboy_req:path(Req),
    self(),
    node( self() ),
    N,
    Die,
    node( Die )
  ] ), Req),
	{ok, Req2, Opts}.
