-module(audit_compare).

-export([pass/7,main/5,csv_format/4]).

main(F,L,A,B,Output_Path) ->
	{ok, M} = file:consult(F),
	{ok, M1} = file:consult(L),
	{ok, [List]} = file:consult(A),
	{ok, [List1]} = file:consult(B),
	{ok, Path} = file:consult(Output_Path),
	case List of
		[] ->
			io:format("~p is empty",[A]);
		_ ->
			case List1 of
				[] ->
					io:format("~p is empty",[B]);
				_ ->
					%io:format("\n List is ~p \n \n List1 is ~p",[List,List1]),
					pass(M,M1,List,List1,[],[],Path)
			end
	end.

pass([],_,_,_,Acc,Acc1,Path) ->
		Ac=lists:flatten(Acc),
		Ac1=lists:flatten(Acc1),		
		[Sp|T]=Path,
		[Dp|L]=T,
		[Op|_B]=L,
		{Y1,M1,D1}=date(),
		Y=integer_to_list(Y1),
		M=integer_to_list(M1),
		D=integer_to_list(D1),
		F1=lists:append("_",D),
		F2=lists:append("_",M),
		F3=lists:append("_",Y),
		F4=lists:append(F1,F2),
		F5=lists:append(F4,F3),
		F6=lists:append("/output_in_csv_file",F5),
		F7=lists:append(F6,".csv"),
		F8=lists:append("/output_in_txt_file",F5),
		F9=lists:append(F8,".txt"),
		Output_txt_file=lists:append(atom_to_list(Op),F9),
		Output_csv_file=lists:append(atom_to_list(Op),F7),		
		file:write_file(Output_txt_file, io_lib:fwrite("Files are same\n~p.\n\nFiles are not same\n~p.\n", [Ac,Ac1])),
		io:format("\n These files are same \n They are  \n~p \n\n\n These files are not same \n They are \n~p\n\n",[Ac,Ac1]),
		{ok,FD}=file:open(Output_csv_file,[append]),
		file:write(FD,io_lib:fwrite("Serial_NO Source_Path(~p) Destination_Path(~p) Status\n",[Sp,Dp])),
		csv_format(0,Ac,Ac1,FD);
	
pass([H|T],M1,List,List1,Acc,Acc1,Path) ->
	Cmp=proplists:get_value(H,List),
	Cmp1=proplists:get_value(H,List1),
	%io:format("\n H is ~p \n Cmp ~p \n Cmp1 ~p",[H,Cmp,Cmp1]),
	case Cmp=:=Cmp1 of
		false ->
			pass(T,M1,List,List1,Acc,[Acc1,H],Path);
		true ->
			pass(T,M1,List,List1,[Acc,H],Acc1,Path)
	end.

csv_format(_,[],[],_) ->
	io:format("\nKaala\n");
	
csv_format(I,[],[F|L],FD) ->
	I1=I+1,
	io:format("~p ~p ~p Different ~n",[I1,F,F]),
	file:write(FD,io_lib:fwrite("~p ~p ~p Different\n", [I1,F,F])),
	csv_format(I1,[],L,FD);	

csv_format(I,[H|T],Ac1,FD) ->
	I1=I+1,
	io:format("~p ~p ~p Same ~n",[I1,H,H]),
	file:write(FD,io_lib:fwrite("~p ~p ~p Same\n", [I1,H,H])),
	csv_format(I1,T,Ac1,FD).

					