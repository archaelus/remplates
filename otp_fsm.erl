%%%-------------------------------------------------------------------
%% @copyright {{copyright_holder}} ({{copyright_year}})
%% @author {{author_name}} <{{author_email}}>
%% @doc {{appid}} {{fsmid}} OTP FSM.
%% @end
%%%-------------------------------------------------------------------

-module({{appid}}_{{fsmid}}).

-behaviour(gen_fsm).

-include("{{appid}}_log.hrl").

%% API
-export([start_link/0
        ]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-export([disconnected/2
        ,disconnected/3
        ]).

-record(state, {replaceme}).

%%====================================================================
%% API
%%====================================================================
start_link() ->
    gen_fsm:start_link(?MODULE, [], []).

%%====================================================================
%% gen_fsm callbacks
%%====================================================================

%% gen_fsm init/1 callback
%% @private
init([]) ->
    {ok, disconnected, #state{}}.

%% state event handler functions.
%% @private
disconnected(Event, State) ->
    ?WARN("[state: disconnected] Unhandled event: ~p", [Event]),
    {next_state, disconnected, State}.

%% gen_fsm callbacks
%% @private
handle_event(Event, StateName, State) ->
    ?WARN("[state: ~p] Unhandled event: ~p", [StateName, Event]),
    {next_state, StateName, State}.

%% @private
handle_sync_event(Event, _From, StateName, State) ->
    ?WARN("[state: ~p] Unhandled event: ~p", [StateName, Event]),
    {next_state, StateName, State}.

%% @private
handle_info(Info, StateName, State) ->
    ?INFO("[state: ~p] Unexpected msg: ~p", [StateName, Info]),
    {next_state, StateName, State}.

%% @private
terminate(_Reason, _StateName, _State) ->
    ok.

%% @private
code_change(_OldVsn, StateName, State, _Extra) ->
    {ok, StateName, State}.

%%====================================================================
%% Internal functions
%%====================================================================
