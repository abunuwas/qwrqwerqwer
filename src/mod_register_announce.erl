-module(mod_register_announce).

%% Required by ?INFO_MSG macrosls
-include("logger.hrl").

%%-behaviour(gen_mod).

%% gen_mod API callbacks
-export([start/2, stop/1, register_announce_hook/2, register_announce_hook/1, register_announce_hook/4]).

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

%%register_announce_hook(User, Server) ->
%%    ?INFO_MSG("mod_register_announce:register_announce_hook: A user has been registered!!", []),
%%    User, Server.

register_announce_hook(User, Server) ->
    ?INFO_MSG("mod_register_announce:register_announce_hook: A user has been registered!!", []),
    User, Server.

register_announce_hook(User) ->
    ?INFO_MSG("mod_register_announce:register_announce_hook: A user has been registered!!", []),
    User.

register_announce_hook(Something, User, Server, Ha) ->
    ?INFO_MSG("mod_register_announce:register_announce_hook: A user has been registered!!", []),
    User, Server.
