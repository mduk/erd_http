%% Feel free to use, reuse and abuse the code in this file.

%% @doc Hello world handler.
-module(toppage_handler).

-export([init/2]).

init(Req, Opts) ->
  { ok, Die } = resource_discovery:get_resource( die ),
  DiceNodesTxt = [ io_lib:format( "~p ~s~n", [ P, N ] ) || { P, N } <- erd_dice_app:dice_nodes() ],

  N = erd_dice_die:roll( Die ),
  BodyTxt = io_lib:format(
    "Request handler was ~p running on node ~s~n"
    "Die roll was ~p~n"
    "Die was ~p running on node ~p~n", [
    self(),
    node( self() ),
    N,
    Die,
    node( Die )
  ] ),

	Req2 = cowboy_req:reply(200, [
		{<<"content-type">>, <<"text/plain">>}
	], [ DiceNodesTxt, "\n\n", BodyTxt ], Req),
	{ok, Req2, Opts}.
