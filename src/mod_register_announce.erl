-module(mod_register_announce).

%% Required by ?INFO_MSG macrosls
-include("logger.hrl").

%%-behaviour(gen_mod).

%% gen_mod API callbacks
-export([start/2, stop/1, register_announce_hook/2]).

-ifndef(LAGER).
-define(LAGER, 1).
-endif.

start(_Host, _Opt) -> 
    ejabberd_hooks:add(register_user, <<"use-xmpp-01">>, ?MODULE, register_announce_hook, 10),
    ?INFO_MSG("Registering register_announce_hook...", []),
    ok.

stop(_Host) -> 
    ejabberd_hooks:delete(register_user, _Host, ?MODULE, register_announce_hook, 10),
    ?INFO_MSG("Deregistering register_announce_hook...", []),
    ok.

announce_registration(User, Server) ->
    Packet = {xmlel,
                 <<"presence">>,
                 [{<<"msg">>,<<"account-created">>}],
                 []
                 },
    To = jid:make(<<>>, <<"component.sprue">>, <<>>),
    From = jid:make(User, Server, <<"">>),
    ejabberd_router:route(From, To, Packet).

register_announce_hook(User, Server) ->
    ?INFO_MSG("mod_register_announce:register_announce_hook: An account has been created for the following user: ~p~n", [binary_to_list(User) ++ "@" ++ binary_to_list(Server)]),
    announce_registration(User, Server),
    User, Server.

