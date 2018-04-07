-module(beam_to_erl).

-export([dirs/1,pass/2,transform/2]).

dirs(F) ->
	{ok, Dir} = file:consult(F),
	L = filelib:wildcard(filename:join(Dir, "*.beam")),
	L1 = [filename:basename(Path) || Path <- L],
	case L1 of
		[] ->
			io:format("Dir is empty");
		_ ->
			{ok, Fd1} = file:open("not_able_to_convert_erl.txt", [append]),
			[Dir1]=Dir,
			file:write(Fd1,io_lib:fwrite("These files are not able to convert from beam to erl of this ~p path \n", [Dir1])),
			pass(L1,Fd1)	
		end.

pass([],_) ->
 io:format("~n");

pass([H|T],Fd1) ->
	H1=string:str(H,"."),
	H2=binary:part(list_to_binary(H),0,H1), 
	H3=lists:append(binary_to_list(H2),"erl"),
	case transform(H,H3) of
	ok ->
		pass(T,Fd1);
	{ok,{Module,[_]}} ->
		file:write(Fd1,io_lib:fwrite("~p \n", [Module])),
		io:format("~n ~p module is no_abstract_code ~n",[Module]),
		pass(T,Fd1);
	Error ->
		Error,
		pass(T,Fd1)
	end.


transform(BeamFName, ErlFName) ->
  case beam_lib:chunks(BeamFName, [abstract_code]) of
    {ok, {_, [{abstract_code, {raw_abstract_v1,Forms1}}]}} ->
	 Forms=ignoring_file(Forms1,[]),
        Src=erl_prettypr:format(erl_syntax:form_list(Forms)),
        {ok, Fd} = file:open(ErlFName, [write]),
        io:fwrite(Fd, "~s~n", [Src]),
        file:close(Fd);
    Error ->
       Error
  end. 


ignoring_file([],Acc) ->
	lists:flatten(Acc);
  
  
ignoring_file([H|T],Acc) ->
	case H of
		{attribute,_,file,_} ->
			ignoring_file(T,Acc);
		{attribute,_,url,_} ->
			ignoring_file(T,Acc);
		{attribute,_,_,_} ->
			ignoring_file(T,[Acc,H]);
		{function,_,_,_,_} ->
			ignoring_file(T,[Acc,H]);
		_ ->
			ignoring_file(T,[Acc,H])
	end.

			
