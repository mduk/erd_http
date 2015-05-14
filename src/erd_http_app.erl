%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(erd_http_app).
-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.

start(_Type, _Args) ->
  net_kernel:connect_node( 'erd_dice1@Holly' ),

  resource_discovery:add_target_resource_type( die ),
  resource_discovery:trade_resources(),

	Dispatch = cowboy_router:compile([
		{'_', [
			{'_', toppage_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_http(http, 100, [{port, 8080}], [
		{env, [{dispatch, Dispatch}]}
	]),
	erd_http_sup:start_link().

stop(_State) ->
	ok.
