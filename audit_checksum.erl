-module(audit_checksum).

-export([main/1,pass/2]).

main(A) ->
	{ok, List} = file:consult(A),
		case List of
			[] ->
				io:format("~n List is empty ~n");				
			_ ->
				Chunk=list_to_binary(List),
				List1=binary:split(Chunk, <<"\n">>, [global]),
				pass(List1,[])
		end.		

pass([],Final_List) ->
	Final_List1=lists:flatten(Final_List),
	file:write_file("/home/user/path7.txt", io_lib:fwrite("~p.\n", [Final_List1])),
	io:format("~n List is ~p \n List is over ~n Byeee ~n",[Final_List1]);
	
pass([H|T],Acc) ->
	L1=binary_to_list(H),
	Split1=re:replace(L1, " ", "\n", [global, {return, list}]),
	L2=list_to_binary(Split1),
	[Value,Key]=binary:split(L2, <<"\n">>, [global]),
	Len=string:len(binary_to_list(Key)),
	Split_value=binary:part(Key,0,Len-5),
	Split_value1=binary_to_list(Split_value),
	Acc1={list_to_atom(Split_value1),[{cksum,binary_to_list(Value)}]},
	pass(T,[Acc,Acc1]).

	
	
	
	
	
	
	
	
	
	