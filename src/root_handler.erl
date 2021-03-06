-module(root_handler).
-author("geekbull.in@gmail.com").

-export([init/3]).

-export([content_types_provided/2]).
-export([welcome/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

%% Callbacks
content_types_provided(Req, State) ->
	{[		
		{<<"application/json">>, welcome}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
welcome(Req, State) ->
	lager:info("Welcome Requested"),
	%{Value, Req2} = cowboy_req:headers(Req),
	%lager:info("~p, ~n", [Value]),
	Body = <<"{\"message\": \"welcome\", \"server\": \"adveda\", \"version\": \"0.1.0\"}">>,
	{Body, Req, State}.
