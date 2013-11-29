%%%-------------------------------------------------------------------
%% @copyright {{copyright_holder}} ({{copyright_year}})
%% @author {{author_name}} <{{author_email}}>
%% @doc {{appid}} OTP application callback module.
%% @end
%%%-------------------------------------------------------------------

-module({{appid}}_app).

-behaviour(application).

-define(APP, {{appid}}).

%% Application callbacks
-export([start_phase/3, start/2, stop/1]).

-export([config/0, config/1, config/2,
         start/0]).

-export([update_dispatch_rules/0]).

%%%===================================================================
%%% Convenience Functions
%%%===================================================================

start() ->
    application:ensure_all_started(?APP, permanent).

config(Key, Default) ->
    case application:get_env(?APP, Key) of
        undefined -> Default;
        {ok, Val} -> Val
    end.

config(Key) ->
    case application:get_env(?APP, Key) of
        undefined -> erlang:error({missing_config, Key});
        {ok, Val} -> Val
    end.

config() ->
    application:get_all_env(?APP).

update_dispatch_rules() ->
    cowboy:set_env(?APP,
                   dispatch,
                   cowboy_router:compile(dispatch_rules())).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    stillir:set_config(?APP, env_specs()),
    {{appid}}_sup:start_link().

stop(_State) ->
    ok.

start_phase(listen, _Type, _Args) ->
    Dispatch = cowboy_router:compile(dispatch_rules()),
    cowboy:start_http(?APP, config(http_acceptors),
                      [{port, config(http_listen_port)}],
                      [{env, [{dispatch, Dispatch}]}]),
    ok.

dispatch_rules() ->
    [{'_',
      [{'_', {{appid}}_http_handler, []}]}
    ].

%%%===================================================================
%%% Internal functions
%%%===================================================================

env_specs() ->
    [{http_listen_port, "PORT", [{transform, integer}]}
     ].
