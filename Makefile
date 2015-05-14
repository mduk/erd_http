PROJECT = erd_http
DEPS = cowboy resource_discovery erd_dice
dep_cowboy = git https://github.com/ninenines/cowboy master
dep_erd_dice = git https://github.com/mduk/erd_dice master
include erlang.mk
