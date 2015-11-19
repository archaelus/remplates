%%%-------------------------------------------------------------------
%% @copyright {{copyright_holder}} ({{copyright_year}})
%% @author {{author_name}} <{{author_email}}>
%% @doc Default Cowboy HTTP handler for {{appid}}.
%% @end
%%%-------------------------------------------------------------------

-module({{appid}}_http_handler).

-behaviour(cowboy_http_handler).
-export([init/2, handle/2, terminate/3]).

-include("{{appid}}_log.hrl").

init(Req, _Opts) ->
    {http, Req, undefined}.

handle(Req, State) ->
    Req2 = cowboy_req:reply(200,
                            [{<<"Content-Type">>, <<"text/plain">>}],
                            <<"Hello world!">>,
                            Req),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.
