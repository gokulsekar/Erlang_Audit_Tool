-module(load_beam_for_cid).

-export([main/1,pass/2]).

main(A) ->
	{ok, List} = file:consult(A),
		case List of
			[] ->
				io:format("~n List is empty ~n");				
			_ ->
				pass(List,[])
		end.		

pass([],List) ->
	List1=lists:flatten(List),
	A=os:cmd("echo $HOME"),
	B=lists:reverse(A),
	C=lists:nthtail(1,B),
	D=lists:reverse(C),
	E=lists:append(D,"/path3.txt"),
	file:write_file(E, io_lib:fwrite("~p.\n", [List1]));
	%io:format("~n List is ~p \n List is over ~n Byeee ~n",[List1]);
	
pass([H|T],Acc) ->
	try case H:module_info() of
		{error,Error} ->
			io:format("~n The error in this ~p file. The Error is ~p",[H,Error]),
			pass(T,Acc);			
		Data ->
			case proplists:get_value(compile, Data) of
				undefined ->
					io:format("\n compile is undefined of ~p\n",[H]),
					pass(T,Acc);					
				Compile ->
					case proplists:get_value(options, Compile) of
						undefined ->
							io:format("\n options is undefined of ~p \n",[H]),
							pass(T,Acc);						
						Options ->
							case Options of
								[] ->
									io:format("\n options is empty of ~p \n",[H]),
									pass(T,Acc);
								_ ->
									H1=lists:append("Git_commit_",atom_to_list(H)),
									H2=lists:append(H1,"_erl"),
									case lists:keyfind(list_to_atom(H2), 2, Options) of
										false ->
											case lists:keyfind('GitCommit', 2, Options) of
												false ->
													Commit_Id=undefined;
												Commit_Value1 ->
													{_,_,Commit_Id}=Commit_Value1
											end;
										Commit_Value ->
											{_,_,Commit_Id}=Commit_Value
									end,
									Acc1={H,[{commit_id,Commit_Id}]},
									pass(T,[Acc,Acc1])
							end
					end
			end									
		end
	catch
		_:undef ->
			pass(T,Acc);	
		_:Error1 ->
			io:format("~n The error in this ~p file. The Error is ~p ~n",[H,Error1]),
			pass(T,Acc)
	end.