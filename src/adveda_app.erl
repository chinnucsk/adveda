-module(adveda_app).
-author("geekbull.in@gmail.com").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
	Dispatch = cowboy_router:compile([
		{'_',[
				{"/", root_handler, []},
				{"/status", status_handler, []}
			 ]
		}

	]), 
	{ok, _} = cowboy:start_http(http,100, [{port, 5544}],[{env, [{dispatch, Dispatch}]}]), 
    adveda_sup:start_link().

stop(_State) ->
    ok.
