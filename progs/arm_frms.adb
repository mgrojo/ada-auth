    --
    -- Ada reference manual formatter.
    --
    -- This subprogram is part of the command processor.
    --
    -- We use dispatching calls to call the formatter, so the details of
    -- formatting are insulated from the code that reads the source and
    -- determines the details of the text.
    --
    -- ---------------------------------------
    -- Copyright 2000, 2002, 2004, 2005, 2006  AXE Consultants.
    -- P.O. Box 1512, Madison WI  53701
    -- E-Mail: randy@rrsoftware.com
    --
    -- AXE Consultants grants to all users the right to use/modify this
    -- formatting tool for non-commercial purposes. (ISO/IEC JTC 1 SC 22 WG 9
    -- activities are explicitly included as "non-commercial purposes".)
    -- Commercial uses of this software and its source code, including but not
    -- limited to documents for sale and sales of modified versions of this
    -- tool, are prohibited without the prior written permission of
    -- AXE Consultants. All rights not explicitly granted above are reserved
    -- by AXE Consultants.
    --
    -- You use this tool and/or its source code on the condition that you indemnify and hold harmless
    -- AXE Consultants, its agents, and employees, from any and all liability
    -- or damages to yourself or your hardware or software, or third parties,
    -- including attorneys' fees, court costs, and other related costs and
    -- expenses, arising out of your use of this tool and/or source code irrespective of the
    -- cause of said liability.
    --
    -- AXE CONSULTANTS MAKES THIS TOOL AND SOURCE CODE AVAILABLE ON AN "AS IS"
    -- BASIS AND MAKES NO WARRANTY, EXPRESS OR IMPLIED, AS TO THE ACCURACY,
    -- CAPABILITY, EFFICIENCY, MERCHANTABILITY, OR FUNCTIONING OF THIS TOOL.
    -- IN NO EVENT WILL AXE CONSULTANTS BE LIABLE FOR ANY GENERAL,
    -- CONSEQUENTIAL, INDIRECT, INCIDENTAL, EXEMPLARY, OR SPECIAL DAMAGES,
    -- EVEN IF AXE CONSULTANTS HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
    -- DAMAGES.
    -- ---------------------------------------
    --
    -- Edit History:
    --
    --  2/10/06 - RLB - Split from base package.

separate(ARM_Format)
procedure Scan (Format_Object : in out Format_Type;
	        File_Name : in String;
	        Section_Number : in ARM_Contents.Section_Number_Type;
	        Starts_New_Section : in Boolean) is
    -- Scans the contents for File_Name, determining the table of contents
    -- for the section. The results are written to the contents package.
    -- Starts_New_Section is True if the file starts a new section.
    -- Section_Number is the number (or letter) of the section.

    type Items is record
        Command : Command_Type;
        Close_Char : Character; -- Ought to be }, ], >, or ).
    end record;
    Nesting_Stack : array (1 .. 60) of Items;
    Nesting_Stack_Ptr : Natural := 0;
    Saw_a_Section_Header : Boolean := False;

    Input_Object : ARM_File.File_Input_Type;

    procedure Set_Nesting_for_Command (Command : in Command_Type;
				       Param_Ch : in Character) is
        -- Push the command onto the nesting stack.
    begin
        if Nesting_Stack_Ptr < Nesting_Stack'Last then
	    Nesting_Stack_Ptr := Nesting_Stack_Ptr + 1;
	    Nesting_Stack (Nesting_Stack_Ptr) :=
	        (Command => Command,
		 Close_Char => ARM_Input.Get_Close_Char (Param_Ch));
--Ada.Text_IO.Put_Line (" &Stack (" & Command_Type'Image(Command) & "); Close-Char=" &
--  Nesting_Stack(Nesting_Stack_Ptr).Close_Char);
        else
	    Ada.Text_IO.Put_Line ("** Nesting stack overflow on line" & ARM_File.Line_String (Input_Object));
	    for I in reverse Nesting_Stack'range loop
	        Ada.Text_IO.Put_Line ("-- Command at" & Natural'Image(I) & " has a close char of '" &
		    Nesting_Stack (Nesting_Stack_Ptr).Close_Char & "' for " & Command_Type'Image(Nesting_Stack (Nesting_Stack_Ptr).Command));
	    end loop;
	    raise Program_Error;
        end if;
    end Set_Nesting_for_Command;


    procedure Scan_Command_with_Parameter is
        -- Scan the start of a command with a parameter.
        -- The parameter character has been scanned, and
        -- a stack item pushed.
        Title : ARM_Contents.Title_Type;
        Title_Length : Natural;

        procedure Get_Change_Version (Is_First : in Boolean;
				      Version : out ARM_Contents.Change_Version_Type) is
	    -- Get a parameter named "Version", containing a character
	    -- representing the version number.
	    Ch, Close_Ch : Character;
        begin
	    ARM_Input.Check_Parameter_Name (Input_Object,
	        Param_Name => "Version" & (8..ARM_Input.Command_Name_Type'Last => ' '),
	        Is_First => Is_First,
	        Param_Close_Bracket => Close_Ch);
	    if Close_Ch /= ' ' then
	        -- Get the version character:
	        ARM_File.Get_Char (Input_Object, Ch);
	        Version := ARM_Contents.Change_Version_Type(Ch);
	        ARM_File.Get_Char (Input_Object, Ch);
	        if Ch /= Close_Ch then
		    Ada.Text_IO.Put_Line ("  ** Bad close for change version on line " & ARM_File.Line_String (Input_Object));
		    ARM_File.Replace_Char (Input_Object);
	        end if;
	    -- else no parameter. Weird.
	    end if;
        end Get_Change_Version;

    begin
        case Nesting_Stack(Nesting_Stack_Ptr).Command is
	    when Labeled_Section | Labeled_Section_No_Break |
		 Labeled_Informative_Annex |
		 Labeled_Normative_Annex | Labeled_Clause |
		 Labeled_Subclause =>
	        -- Load the title into the Title string:
	        ARM_Input.Copy_to_String_until_Close_Char (
		    Input_Object,
		    Nesting_Stack(Nesting_Stack_Ptr).Close_Char,
		    Title, Title_Length);
	        Title(Title_Length+1 .. Title'Last) :=
		    (others => ' ');
	        if Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Subclause then
		    Format_Object.Subclause := Format_Object.Subclause + 1;
	        elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Clause then
		    Format_Object.Clause := Format_Object.Clause + 1;
		    Format_Object.Subclause := 0;
	        elsif Saw_a_Section_Header then
		    Ada.Text_IO.Put_Line ("  ** Multiple section headers in a file, line " &
			    ARM_File.Line_String (Input_Object));
	        else
		    Saw_a_Section_Header := True;
		    Format_Object.Clause := 0;
		    Format_Object.Subclause := 0;
	        end if;

	        -- Load the title into the contents package:
	        if Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Subclause then
		    ARM_Contents.Add (Title, ARM_Contents.Subclause,
				      Format_Object.Section,
				      Format_Object.Clause,
				      Format_Object.SubClause);
	        elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Clause then
		    ARM_Contents.Add (Title, ARM_Contents.Clause,
				      Format_Object.Section,
				      Format_Object.Clause);
	        elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Section or else
		      Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Section_No_Break then
		    ARM_Contents.Add (Title, ARM_Contents.Section,
				      Format_Object.Section);
	        elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Normative_Annex then
		    ARM_Contents.Add (Title, ARM_Contents.Normative_Annex,
				      Format_Object.Section);
	        else
		    ARM_Contents.Add (Title, ARM_Contents.Informative_Annex,
				      Format_Object.Section);
	        end if;

	        Nesting_Stack_Ptr := Nesting_Stack_Ptr - 1;
--Ada.Text_IO.Put_Line (" &Unstack (Header)");

	    when Unnumbered_Section =>
	        -- Load the title into the Title string:
	        ARM_Input.Copy_to_String_until_Close_Char (
		    Input_Object,
		    Nesting_Stack(Nesting_Stack_Ptr).Close_Char,
		    Title, Title_Length);
	        Title(Title_Length+1 .. Title'Last) :=
		    (others => ' ');
	        Format_Object.Unnumbered_Section :=
		    Format_Object.Unnumbered_Section + 1;
	        -- This section will be numbered 0.Unnumbered_Section:
	        Format_Object.Clause := Format_Object.Unnumbered_Section;
	        Format_Object.Subclause := 0;
	        -- Load the title into the contents package:
	        ARM_Contents.Add (Title, ARM_Contents.Unnumbered_Section,
				  0, -- Section is 0, so there is no number.
				  Format_Object.Clause);

	        Nesting_Stack_Ptr := Nesting_Stack_Ptr - 1;
--Ada.Text_IO.Put_Line (" &Unstack (Header)");

	    when Labeled_Revised_Informative_Annex |
		 Labeled_Revised_Normative_Annex |
		 Labeled_Revised_Clause |
		 Labeled_Revised_Subclause =>
	        declare
		    Old_Title : ARM_Contents.Title_Type;
		    Old_Title_Length : Natural;
		    Ch : Character;
		    Version : ARM_Contents.Change_Version_Type := '0';
	        begin
		    Get_Change_Version (Is_First => True,
				        Version => Version);
		    ARM_Input.Check_Parameter_Name (Input_Object,
		        Param_Name => "New" & (4..ARM_Input.Command_Name_Type'Last => ' '),
		        Is_First => False,
		        Param_Close_Bracket => Ch);
		    if Ch /= ' ' then
		        -- There is a parameter:
		        -- Load the new title into the Title string:
		        ARM_Input.Copy_to_String_until_Close_Char (
			    Input_Object,
			    Ch,
			    Title, Title_Length);
		        Title(Title_Length+1 .. Title'Last) :=
			    (others => ' ');
		        ARM_Input.Check_Parameter_Name (Input_Object,
			    Param_Name => "Old" & (4..ARM_Input.Command_Name_Type'Last => ' '),
			    Is_First => False,
			    Param_Close_Bracket => Ch);
		        if Ch /= ' ' then
			    -- There is a parameter:
			    -- Load the new title into the Title string:
			    ARM_Input.Copy_to_String_until_Close_Char (
			        Input_Object,
			        Ch,
			        Old_Title, Old_Title_Length);
			    Old_Title(Old_Title_Length+1 .. Old_Title'Last) :=
			        (others => ' ');
		        end if;
		    end if;
		    ARM_File.Get_Char (Input_Object, Ch);
		    if Ch /= Nesting_Stack(Nesting_Stack_Ptr).Close_Char then
		        Ada.Text_IO.Put_Line ("  ** Bad close for Labeled_Revised_(SubClause|Annex) on line " & ARM_File.Line_String (Input_Object));
		        ARM_File.Replace_Char (Input_Object);
		    end if;

		    if Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Revised_Subclause then
		        Format_Object.Subclause := Format_Object.Subclause + 1;
		    elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Revised_Clause then
		        Format_Object.Clause := Format_Object.Clause + 1;
		        Format_Object.Subclause := 0;
		    elsif Saw_a_Section_Header then
		        Ada.Text_IO.Put_Line ("  ** Multiple section headers in a file, line " &
			        ARM_File.Line_String (Input_Object));
		    else
		        Saw_a_Section_Header := True;
		        Format_Object.Clause := 0;
		        Format_Object.Subclause := 0;
		    end if;

		    -- Load the title into the contents package:
		    if Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Revised_Subclause then
		        ARM_Contents.Add (Title, ARM_Contents.Subclause,
					  Format_Object.Section,
					  Format_Object.Clause,
					  Format_Object.SubClause,
					  Version => Version);
		        ARM_Contents.Add_Old (Old_Title,
					  ARM_Contents.Subclause,
					  Format_Object.Section,
					  Format_Object.Clause,
					  Format_Object.SubClause);
		    elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Revised_Clause then
		        ARM_Contents.Add (Title, ARM_Contents.Clause,
					  Format_Object.Section,
					  Format_Object.Clause,
					  Version => Version);
		        ARM_Contents.Add_Old (Old_Title,
					  ARM_Contents.Clause,
					  Format_Object.Section,
					  Format_Object.Clause);
		    elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Revised_Normative_Annex then
		        ARM_Contents.Add (Title,
					  ARM_Contents.Normative_Annex,
					  Format_Object.Section,
					  Version => Version);
		        ARM_Contents.Add_Old (Old_Title,
					  ARM_Contents.Normative_Annex,
					  Format_Object.Section);
		    else -- Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Revised_Informative_Annex then
		        ARM_Contents.Add (Title,
					  ARM_Contents.Informative_Annex,
					  Format_Object.Section,
					  Version => Version);
		        ARM_Contents.Add_Old (Old_Title,
					  ARM_Contents.Informative_Annex,
					  Format_Object.Section);
		    end if;

		    Nesting_Stack_Ptr := Nesting_Stack_Ptr - 1;
--Ada.Text_IO.Put_Line (" &Unstack (Header)");
	        end;

	    when Labeled_Added_Informative_Annex |
		 Labeled_Added_Normative_Annex |
		 Labeled_Added_Clause |
		 Labeled_Added_Subclause =>
	        declare
		    Ch : Character;
		    Version : ARM_Contents.Change_Version_Type := '0';
	        begin
		    Get_Change_Version (Is_First => True,
				        Version => Version);
		    ARM_Input.Check_Parameter_Name (Input_Object,
		        Param_Name => "Name" & (5..ARM_Input.Command_Name_Type'Last => ' '),
		        Is_First => False,
		        Param_Close_Bracket => Ch);
		    if Ch /= ' ' then
		        -- There is a parameter:
		        -- Load the new title into the Title string:
		        ARM_Input.Copy_to_String_until_Close_Char (
			    Input_Object,
			    Ch,
			    Title, Title_Length);
		        Title(Title_Length+1 .. Title'Last) :=
			    (others => ' ');
		    end if;
		    ARM_File.Get_Char (Input_Object, Ch);
		    if Ch /= Nesting_Stack(Nesting_Stack_Ptr).Close_Char then
		        Ada.Text_IO.Put_Line ("  ** Bad close for Labeled_Added_(Sub)Clause on line " & ARM_File.Line_String (Input_Object));
		        ARM_File.Replace_Char (Input_Object);
		    end if;

		    -- Load the title into the contents package:
		    if Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Added_Subclause then
		        Format_Object.Subclause := Format_Object.Subclause + 1;
		        ARM_Contents.Add (Title, ARM_Contents.Subclause,
					  Format_Object.Section,
					  Format_Object.Clause,
					  Format_Object.SubClause,
					  Version => Version);
		        ARM_Contents.Add_Old ((others => ' '),
					  ARM_Contents.Subclause,
					  Format_Object.Section,
					  Format_Object.Clause,
					  Format_Object.SubClause);
		    elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Added_Clause then
		        Format_Object.Clause := Format_Object.Clause + 1;
		        Format_Object.Subclause := 0;
		        ARM_Contents.Add (Title, ARM_Contents.Clause,
					  Format_Object.Section,
					  Format_Object.Clause,
					  Version => Version);
		        ARM_Contents.Add_Old ((others => ' '),
					  ARM_Contents.Clause,
					  Format_Object.Section,
					  Format_Object.Clause);
		    elsif Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Added_Normative_Annex then
		        if Saw_a_Section_Header then
			    Ada.Text_IO.Put_Line ("  ** Multiple section headers in a file, line " &
				    ARM_File.Line_String (Input_Object));
		        end if;
		        Saw_a_Section_Header := True;
		        Format_Object.Clause := 0;
		        Format_Object.Subclause := 0;
		        ARM_Contents.Add (Title,
					  ARM_Contents.Normative_Annex,
					  Format_Object.Section,
					  Version => Version);
		        ARM_Contents.Add_Old ((others => ' '),
					  ARM_Contents.Normative_Annex,
					  Format_Object.Section);
		    else -- Nesting_Stack(Nesting_Stack_Ptr).Command = Labeled_Added_Informative_Annex then
		        if Saw_a_Section_Header then
			    Ada.Text_IO.Put_Line ("  ** Multiple section headers in a file, line " &
				    ARM_File.Line_String (Input_Object));
		        end if;
		        Saw_a_Section_Header := True;
		        Format_Object.Clause := 0;
		        Format_Object.Subclause := 0;
		        ARM_Contents.Add (Title,
					  ARM_Contents.Informative_Annex,
					  Format_Object.Section,
					  Version => Version);
		        ARM_Contents.Add_Old ((others => ' '),
					  ARM_Contents.Informative_Annex,
					  Format_Object.Section);
		    end if;

		    Nesting_Stack_Ptr := Nesting_Stack_Ptr - 1;
--Ada.Text_IO.Put_Line (" &Unstack (Header)");
	        end;

	    when Syntax_Rule | Added_Syntax_Rule | Deleted_Syntax_Rule =>
		-- @Syn{[Tabs=<Tabset>, ]LHS=<Non-terminal>, RHS=<Production>}
		-- @AddedSyn{Version=[<Version>],[Tabs=<Tabset>, ]LHS=<Non-terminal>, RHS=<Production>}
		-- @DeletedSyn{Version=[<Version>],[Tabs=<Tabset>, ]LHS=<Non-terminal>, RHS=<Production>}
		-- We need to index the non-terminal, so we can link to it
		-- later. (If we didn't do this here, we wouldn't be able
		-- to handle forward references.)
		-- We only care about the non-terminal, so we skip the other
		-- parts.
		declare
		    Close_Ch, Ch : Character;
		    Seen_First_Param : Boolean := False;
		    Non_Terminal : String (1..120);
		    NT_Len : Natural := 0;
		begin
		    if Nesting_Stack(Nesting_Stack_Ptr).Command /= Syntax_Rule then
			-- Get and skip the Version parameter.
			Seen_First_Param := True;
			Get_Change_Version (Is_First => True,
					    Version => Ch);
		    end if;

		    -- Peek to see if Tabs parmeter is present, and skip it if
		    -- it is:
		    ARM_File.Get_Char (Input_Object, Ch);
		    ARM_File.Replace_Char (Input_Object);
		    if Ch = 'T' or else Ch = 't' then
			ARM_Input.Check_Parameter_Name (Input_Object,
			   Param_Name => "Tabs" & (5..ARM_Input.Command_Name_Type'Last => ' '),
			   Is_First => (not Seen_First_Param),
			   Param_Close_Bracket => Close_Ch);
			Seen_First_Param := True;
			if Close_Ch /= ' ' then
			    -- Grab the tab string:
			    ARM_Input.Skip_until_Close_Char (
			        Input_Object,
			        Close_Ch);
			-- else no parameter. Weird.
			end if;
		    end if;

		    -- Get the LHS parameter and save it:
		    ARM_Input.Check_Parameter_Name (Input_Object,
			Param_Name => "LHS" & (4..ARM_Input.Command_Name_Type'Last => ' '),
			Is_First => (not Seen_First_Param),
		        Param_Close_Bracket => Close_Ch);
		    if Close_Ch /= ' ' then
		        -- Copy over the non-terminal:
		        ARM_Input.Copy_to_String_until_Close_Char (
		            Input_Object,
		            Close_Ch,
		            Non_Terminal,
	                    NT_Len);
		    -- else no parameter. Weird.
		    end if;

		    -- Skip the RHS parameter:
		    ARM_Input.Check_Parameter_Name (Input_Object,
		       Param_Name => "RHS" & (4..ARM_Input.Command_Name_Type'Last => ' '),
		       Is_First => False,
		       Param_Close_Bracket => Close_Ch);
		    Seen_First_Param := True;
		    if Close_Ch /= ' ' then
		        -- Grab the tab string:
		        ARM_Input.Skip_until_Close_Char (
			    Input_Object,
			    Close_Ch);
		    -- else no parameter. Weird.
		    end if;

		    declare
			The_Non_Terminal : constant String :=
			    Ada.Characters.Handling.To_Lower (
				Get_Current_Item (Format_Object, Input_Object,
				    Non_Terminal(1..NT_Len))); -- Handle embedded @Chg.
		    begin
			if Ada.Strings.Fixed.Index (The_Non_Terminal, "@") /= 0 then
			    -- Still embedded commands, do not register.
			    Ada.Text_IO.Put_Line ("** Saw Non-Terminal with embedded commands: " &
				Non_Terminal(1..NT_Len) & " in " & Clause_String (Format_Object));
			elsif The_Non_Terminal = "" then
			    null; -- Delete Non-Terminal, nothing to do.
			else
			    -- Save the non-terminal:
			    declare
			        Link_Target : ARM_Syntax.Target_Type;
			    begin
			         ARM_Syntax.Add_Non_Terminal
			             (NT_Name => The_Non_Terminal,
			              For_Clause => Clause_String (Format_Object),
			              Link_Target => Link_Target);
			    end;
--Ada.Text_IO.Put_Line ("%% Saw simple Non-Terminal: " & The_Non_Terminal & " in "
--   & Clause_String (Format_Object));
			end if;
		    end;
		end;

	    when others =>
	        null; -- Not in scanner.
        end case;
    end Scan_Command_with_Parameter;


    procedure Handle_End_of_Command is
        -- Unstack and handle the end of Commands.
    begin
        case Nesting_Stack(Nesting_Stack_Ptr).Command is
	    when others =>
	        -- No special handling needed.
	        null;
        end case;
--Ada.Text_IO.Put_Line (" &Unstack (Normal-"& Command_Type'Image(Nesting_Stack(Nesting_Stack_Ptr).Command) & ")");
        Nesting_Stack_Ptr := Nesting_Stack_Ptr - 1;
    end Handle_End_of_Command;


    procedure Scan_Special is
        -- Scan a special command/macro/tab.
        -- These all start with '@'.
        -- @xxxx is a command. It may have parameters delimited by
        -- (), {}, [], or <>. There does not appear to be an escape, so
        -- we don't have to worry about '}' being used in {} brackets,
        -- for example. (Must be a pain to write, though.)
        Command_Name : ARM_Input.Command_Name_Type;
        Ch : Character;
    begin
        ARM_File.Get_Char (Input_Object, Ch);
        if Ch = '\' then
	    -- This represents a tab (or the end of centered text). We're
	    -- done here.
	    return;
        elsif Ch = '=' then
	    -- This marks the beginning of centered text.
	    -- We're done here.
	    return;
        elsif Ch = '^' then
	    -- This represented a tab stop (these should have been
	    -- deleted from the input). We're done here.
	    return;
        elsif Ch = '@' then
	    -- This represents @ in the text. We're done here.
	    return;
        elsif Ch = ' ' then
	    -- This represents a hard space in the text. We're done here.
	    return;
        elsif Ch = ';' then
	    -- This seems to be an end of command (or substitution) marker.
	    -- For instance, it is used in Section 1:
	    -- .. the distinction between @ResolutionName@;s and ...
	    -- This converts to:
	    -- .. the distinction between Name Resolution Rules and ...
	    -- Without it, the 's' would append to the command name, and
	    -- we would get the wrong command. Thus, it itself does nothing
	    -- at all, so we're done here.
	    return;
        elsif Ch = '-' then
	    -- This represents a subscript. It has an argument.
	    ARM_File.Get_Char (Input_Object, Ch);
	    if ARM_Input.Is_Open_Char (Ch) then -- Start parameter:
	        Set_Nesting_for_Command
		    (Command  => Unknown,
		     Param_Ch => Ch);
	    else -- No parameter. Weird.
	        ARM_File.Replace_Char (Input_Object);
	    end if;
	    return;
        elsif Ch = '+' then
	    -- This represents a superscript. It has an argument.
	    ARM_File.Get_Char (Input_Object, Ch);
	    if ARM_Input.Is_Open_Char (Ch) then -- Start parameter:
	        Set_Nesting_for_Command
		    (Command  => Unknown,
		     Param_Ch => Ch);
	    else -- No parameter. Weird.
	        ARM_File.Replace_Char (Input_Object);
	    end if;
	    return;
        elsif Ch = ':' then
	    -- This is a period type marker. We're done here.
	    return;
        elsif Ch = '*' then
	    -- This is a line break. We're done here.
	    return;
        elsif Ch = '|' then
	    -- This is a soft line break. We're done here.
	    return;
        elsif Ch = '!' then
	    -- This is a soft hyphen break. We're done here.
	    return;
        elsif Ch = Ascii.LF then
	    -- Stand alone '@'.
	    -- I now believe this is an error. It appears in
	    -- Infosys.MSS, and seems to have something to do with formatting.
	    return;
        end if;
        ARM_File.Replace_Char (Input_Object);
        Arm_Input.Get_Name (Input_Object, Command_Name);

        ARM_File.Get_Char (Input_Object, Ch);
        if ARM_Input.Is_Open_Char (Ch) then -- Start parameter:
	    Set_Nesting_for_Command
	        (Command  => Command (Ada.Characters.Handling.To_Lower (Command_Name)),
		 Param_Ch => Ch);
	    Scan_Command_with_Parameter;
        else
	    ARM_File.Replace_Char (Input_Object);
	    -- We're not interested in commands with no parameters.
        end if;
    end Scan_Special;

begin
    Ada.Text_IO.Put_Line ("-- Scanning " & File_Name);
    begin
        Arm_File.Open (Input_Object, File_Name);
    exception
        when others =>
	    Ada.Text_IO.Put_Line ("** Unable to open file " & File_Name);
	    return;
    end;
    if Starts_New_Section then
        Format_Object.Section := Section_Number;
        Format_Object.Clause := 0;
        Format_Object.Subclause := 0;
    end if;
    loop
        declare
	    Char : Character;
        begin
	    ARM_File.Get_Char (Input_Object, Char);
--Ada.Text_IO.Put_Line("Char=" & Char & " Nesting=" & Natural'Image(Nesting_Stack_Ptr));
	    case Char is
	        when '@' =>
		    Scan_Special;
	        when Ascii.SUB =>
		    exit; -- End of file.
	        when others =>
		    if Nesting_Stack_Ptr /= 0 and then
		       Nesting_Stack (Nesting_Stack_Ptr).Close_Char /= ' ' and then
		       Nesting_Stack (Nesting_Stack_Ptr).Close_Char = Char then
    		        -- Closing a command, remove it from the stack.
		        Handle_End_of_Command;
		    else
		        null; -- Ordinary characters, nothing to do.
		    end if;
	    end case;
        end;
    end loop;
    -- Reached end of the file.
    Ada.Text_IO.Put_Line ("  Lines scanned: " &
		     ARM_File.Line_String (Input_Object));
    ARM_File.Close (Input_Object);
    if Nesting_Stack_Ptr /= 0 then
        Ada.Text_IO.Put_Line ("   ** Unfinished commands detected.");
    end if;
end Scan;

