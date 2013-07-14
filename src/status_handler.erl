-module(status_handler).
-author("geekbull.in@gmail.com").

-export([init/3]).
-export([content_types_provided/2]).
-export([status/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.


%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"application/json">>, status}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
status(Req, State) ->
	Body = <<"{\"message\": \"alive\", \"server\": \"adveda\", \"version\": \"0.1.0\"}">>,
	{Body, Req, State}.
