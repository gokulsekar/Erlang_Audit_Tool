-module(load_beam_for_cid_and_ev).

-export([main/1,pass/2,split/1]).

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
	file:write_file("/home/user/path1.txt", io_lib:fwrite("~p.\n", [List1]));
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
									Version=split(Options),						
									%io:format("\n ~p \t ~p \t ~p \n",[H,Commit_Id,Version]),
									Acc1={H,[{version,Version},{commit_id,Commit_Id}]},
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
	
split([]) ->
	undefined;
		
split([H|T]) ->
		case H of
			{_,_,_} ->
					split(T);
			{_,OTP} ->
					case is_list(OTP) of
						false ->
							case string:rstr(atom_to_list(OTP),"OTP_RELEASE") of	
								1 ->
									atom_to_list(OTP);
								0 ->
									split(T)
							end;
						true ->
							case string:rstr(OTP,"OTP_RELEASE") of	
								1 ->
									OTP;
								0 ->
									split(T)
							end
					end;
			_ ->
				split(T)
		end.




	