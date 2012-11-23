%% @copyright Geoff Cant
%% @author Geoff Cant <nem@erlang.geek.nz>
%% @version {@vsn}, {@date} {@time}
%% @doc Default HTTP handler for {{appid}}.
%% @end
-module({{appid}}_http_handler).

-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

init({_Any, http}, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {ok, Req2} = cowboy_http_req:reply(200,
                                       [{'Content-Type', "text/plain"}],
                                       <<"Hello world!">>,
                                       Req),
    {ok, Req2, State}.

terminate(_Req, _State) ->
    ok.
