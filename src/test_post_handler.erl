-module(test_post_handler).

-export([init/3]).
-export([allowed_methods/2]).
-export([content_types_accepted/2]).
-export([put_json/2]).
-export([terminate/3]).

%% Init
init(_Transport, _Req, []) ->
	{upgrade, protocol, cowboy_rest}.

allowed_methods(Req, State) ->
    {[ <<"POST">>, <<"PUT">>], Req, State}.


%% Callbacks
content_types_accepted(Req, State) ->
	{[		
		{<<"application/json">>, put_json}	
	], Req, State}.

terminate(_Reason, _Req, _State) ->
	ok.

%% API
put_json(Req, State) ->
	lager:info("JSON Posted"),
	{ok, Value, Req2} = cowboy_req:body(Req),
	case cowboy_req:has_body(Req) of
    true ->
      {ok, Body, Req2} = cowboy_req:body(Req),
      lager:info("~p", [Body]),
      {ok, Req3 } = cowboy_req:reply(201, [{<<"Content-Type">>, <<"application/json">>}, {<<"x-openrtb-version">>,<<"2.1">>}], "{\"message\" : \"posted_a_message\", \"status\" : \"success\" }", Req2 ),
      {halt, Req3, State};
    false ->
      {false, Req, State}
  end.

