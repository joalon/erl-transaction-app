-module(transparsing).

-export([load_file/1, parse_to_terms/1]).

load_file(Path) ->
	io:format("Reading: ~s ~n", [Path]),
	{ok, IoDevice} = file:open(Path, [read]),
	load_file(file:read_line(IoDevice),[],IoDevice).

load_file(eof, Acc, _IoDevice) ->
	Acc;
load_file({ok, Data}, Acc, IoDevice) ->
	[ _Date1, Date2, Text, Amount, Category ] = string:tokens(Data, ";"),
	load_file(file:read_line(IoDevice),[ { Date2, Text, Amount, string:left(Category, string:len(Category)-1) } | Acc], IoDevice).

parse_to_terms(File) ->
	io:format("~s ~n", [File]).
