@Part(06, Root="ada.mss")

@Comment{$Date: 2011/08/06 05:45:23 $}
@LabeledSection{Subprograms}

@Comment{$Source: e:\\cvsroot/ARM/Source/06.mss,v $}
@Comment{$Revision: 1.114 $}

@begin{Intro}
@Defn{subprogram}
@Defn{procedure}
@Defn{function}
A subprogram is a program unit or intrinsic operation whose execution
is invoked by a subprogram call.
There are two forms of subprogram: procedures and functions.
A procedure call is a @nt{statement}; a function call is an expression and
returns a value.
The definition of a subprogram can be given in two parts:
a subprogram declaration defining its interface,
and a @nt{subprogram_body} defining its execution.
@Redundant[Operators and enumeration literals are functions.]
@begin{Honest}
  A function call is an expression, but more specifically it is a @nt<name>.
@end{Honest}
@ChgToGlossary{Version=[2],Kind=[AddedNormal],Term=<Subprogram>,
Text=<@ChgAdded{Version=[2],Text=[A subprogram is a section of a program that
can be executed in various contexts. It is invoked by a subprogram call that
may qualify the effect of the subprogram through the passing of parameters.
There are two forms of subprograms: functions, which return values, and
procedures, which do not.]}>}
@ChgToGlossary{Version=[2],Kind=[AddedNormal],Term=<Function>,
Text=<@ChgAdded{Version=[2],Text=[A function is a form of subprogram that
returns a result and can be called as part of an expression.]}>}
@ChgToGlossary{Version=[2],Kind=[AddedNormal],Term=<Procedure>,
Text=<@ChgAdded{Version=[2],Text=[A procedure is a form of subprogram that
does not return a result and can only be called by a @nt{statement}.]}>}

@Defn{callable entity}
A @i(callable entity) is a subprogram or entry (see Section 9).
@Defn{call}
A callable entity is invoked by a @i{call};
that is, a subprogram call or entry call.
@Defn{callable construct}
A @i(callable construct) is a construct
that defines the action of a call upon a callable entity:
a @nt{subprogram_body},
@nt{entry_body}, or @nt{accept_statement}.
@begin{Ramification}
Note that @lquotes@;callable entity@rquotes@;
includes predefined operators, enumeration literals,
and abstract subprograms.
@lquotes@;Call@rquotes@; includes calls of these things.
They do not have callable constructs,
since they don't have completions.
@end{Ramification}
@end{Intro}

@LabeledClause{Subprogram Declarations}

@begin{Intro}
@Redundant[A @nt{subprogram_declaration} declares a procedure or
function.]
@end{Intro}

@begin{Syntax}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00218-03]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0183-1]}
@Syn{lhs=<subprogram_declaration>,rhs="@Chg{Version=[2],New=<
    [@Syn2{overriding_indicator}]
    >,Old=<>}@Syn2{subprogram_specification}@Chg{Version=[3],New=<
        [@Syn2{aspect_specification}]>,Old=[]};"}

@ChgRef{Version=[2],Kind=[Deleted],ARef=[AI95-00348-01]}
@DeletedSyn{Version=[2],lhs=<@Chg{Version=[2],New=<>,Old=<abstract_subprogram_declaration>}>,
rhs="@Chg{Version=[2],New=<>,Old=<@Syn2{subprogram_specification} @key{is} @key{abstract};>}"}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00348-01]}
@Syn{lhs=<subprogram_specification>,rhs="@Chg{Version=[2],New=[
    @Syn2{procedure_specification}
  | @Syn2{function_specification}],Old=[
    @key{procedure} @Syn2{defining_program_unit_name} @Syn2{parameter_profile}
  | @key{function} @Syn2{defining_designator} @Syn2{parameter_and_result_profile}]}"}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00348-01]}
@AddedSyn{Version=[2],lhs=<@Chg{Version=[2],New=<procedure_specification>,Old=<>}>,
rhs="@Chg{Version=[2],New=<@key{procedure} @Syn2{defining_program_unit_name} @Syn2{parameter_profile}>,Old=<>}"}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00348-01]}
@AddedSyn{Version=[2],lhs=<@Chg{Version=[2],New=<function_specification>,Old=<>}>,
rhs="@Chg{Version=[2],New=<@key{function} @Syn2{defining_designator} @Syn2{parameter_and_result_profile}>,Old=<>}"}

@Syn{lhs=<designator>,rhs="[@Syn2{parent_unit_name} . ]@Syn2{identifier} | @Syn2{operator_symbol}"}

@Syn{lhs=<defining_designator>,
   rhs="@Syn2{defining_program_unit_name} | @Syn2{defining_operator_symbol}"}

@Syn{lhs=<defining_program_unit_name>,rhs="[@Syn2{parent_unit_name} . ]@Syn2{defining_identifier}"}

@begin{SyntaxText}
@Redundant[The optional @nt{parent_unit_name} is only allowed for
library units (see @RefSecNum{Compilation Units - Library Units}).]
@end{SyntaxText}

@Syn{lhs=<operator_symbol>,rhs="@Syn2{string_literal}"}

@begin{SyntaxText}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00395-01]}
The sequence of characters in an @nt{operator_symbol} shall @Chg{Version=[2],
New=[form a reserved
word, a delimiter, or compound delimiter that corresponds],Old=[correspond]} to
an operator belonging to one of the six @Chg{Version=[2],New=[categories],
Old=[classes]} of operators
defined in clause @RefSecNum{Operators and Expression Evaluation}@Chg{Version=[2],
New=[],Old=[(spaces are not allowed and the case of letters
is not significant)]}.

@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00395-01]}
  @ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0090-1]}
  @ChgAdded{Version=[2],Text=[The @ldquote@;sequence of characters@rdquote
  of the string literal of the operator is a technical term (see
  @RefSecNum{String Literals}), and does not include the surrounding quote
  characters. As defined in @RefSecNum{Lexical Elements, Separators, and Delimiters},
  lexical elements are @lquotes@;formed@rquotes from a sequence of characters.
  Spaces are not allowed, and upper and lower case is
  not significant.@Chg{Version=[3],New=[],Old=[ See
  @RefSecNum{Lexical Elements, Separators, and Delimiters} and
  @RefSecNum{Reserved Words} for rules related to the use of @ntf{other_format}
  characters in delimiters and reserved words.]}]}
@end{Reason}

@end{SyntaxText}

@Syn{lhs=<defining_operator_symbol>,rhs="@Syn2{operator_symbol}"}

@Syn{lhs=<parameter_profile>,rhs="[@Syn2{formal_part}]"}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00231-01],ARef=[AI95-00318-02]}
@Syn{lhs=<parameter_and_result_profile>,rhs="@Chg{Version=[2],New=[
    ],Old=[]}[@Syn2{formal_part}] @key{return}@Chg{Version=[2],New=< [@Syn2{null_exclusion}]>,Old=<>} @Syn2{subtype_mark}@Chg{Version=[2],New=<
  | [@Syn2{formal_part}] @key{return} @Syn2{access_definition}>,Old=<>}"}

@Syn{lhs=<formal_part>,rhs="
   (@Syn2{parameter_specification} {; @Syn2{parameter_specification}})"}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00231-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0142-4]}
@Syn{lhs=<parameter_specification>,rhs="
    @Syn2{defining_identifier_list} : @Chg{Version=[3],New=<[@key[aliased]]>,Old=<>}@Syn2{mode} @Chg{Version=[2],New=<[@Syn2{null_exclusion}]>,Old=<>} @Syn2{subtype_mark} [:= @Syn2{default_expression}]
  | @Syn2{defining_identifier_list} : @Syn2{access_definition} [:= @Syn2{default_expression}]"}

@Syn{lhs=<mode>,rhs="[@key{in}] | @key{in} @key{out} | @key{out}"}
@end{Syntax}

@begin{Resolution}
@Defn2{Term=[formal parameter], Sec=(of a subprogram)}
A @i(formal parameter) is an object
@Redundant[directly visible within a @nt{subprogram_body}]
that represents the actual parameter passed to the subprogram in a
call;
it is declared by a @nt{parameter_specification}.
@PDefn2{Term=[expected type],
  Sec=(parameter @nt{default_expression})}
For a formal parameter,
the expected type for its @nt<default_expression>,
if any, is that of the formal parameter.
@IndexSee{Term=[parameter],See=[formal parameter]}
@end{Resolution}

@begin{Legality}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0143-1]}
@Defn{parameter mode}
The @i(parameter mode) of a formal parameter conveys the direction of
information transfer with the actual parameter:
@key(in), @key(in out), or @key(out).
Mode @key(in) is the default,
and is the mode of a parameter defined by an
@nt{access_definition}.@Chg{Version=[3],New=[],Old=[ The formal parameters
of a function, if any, shall have the mode @key(in).]}
@begin{Ramification}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0143-1]}
@ChgDeleted{Version=[3],Text=[Access parameters are permitted.
This restriction to @b(in) parameters is primarily a methodological
restriction, though it also simplifies implementation for some compiler
technologies.]}
@end{Ramification}

A @nt{default_expression} is only allowed in a @nt{parameter_specification}
for a formal parameter of mode @key(in).

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00348-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0177-1]}
@PDefn2{Term=[requires a completion], Sec=(@nt{subprogram_declaration})}
@PDefn2{Term=[requires a completion], Sec=(@nt{generic_subprogram_declaration})}
A @nt{subprogram_declaration}
or a @nt{generic_subprogram_declaration}
requires a completion:
@Redundant[a body, a @nt<renaming_declaration>
(see @RefSecNum(Renaming Declarations)), or a @Chg{Version=[2],New=[@nt{pragma}],
Old=[@key(pragma)]} Import (see @RefSecNum{Interfacing Aspects})].
@Redundant[A completion is not allowed
for an @nt<abstract_subprogram_declaration>@Chg{Version=[2],New=[ (see
@RefSecNum{Abstract Types and Subprograms})@Chg{Version=[3],New=[,],Old=[ or]} a
@nt{null_procedure_declaration} (see @RefSecNum{Null Procedures})@Chg{Version=[3],New=[,
or an @nt{expression_function_declaration} (see @RefSecNum{Expression Functions})],Old=[]}],Old=[]}.]
@begin(Ramification)
  @ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00348-01]}
  @ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0177-1]}
  Abstract subprograms @Chg{Version=[2],New=[@Chg{Version=[3],New=[,],Old=[and]}
  null procedures@Chg{Version=[3],New=[, and expression functions],Old=[]} ],Old=[]}are
  not declared by @nt{subprogram_declaration}s, and so do not require
  completion@Chg{Version=[3],New=[ (although the latter two can @i<be> completions)],Old=[]}.
  Protected subprograms are declared by @nt{subprogram_declaration}s,
  and so require completion.
  Note that an abstract subprogram is a subprogram,
  and a protected subprogram is a subprogram,
  but a generic subprogram is not a subprogram.
@end(Ramification)

A @nt{name} that denotes a formal parameter
is not allowed within the @nt{formal_part} in which it is declared,
nor within the @nt{formal_part} of a corresponding body or
@nt{accept_statement}.
@begin{Ramification}
By contrast,
@nt<generic_formal_parameter_declaration>s are visible to subsequent
declarations in the same @nt<generic_formal_part>.
@end{Ramification}
@end{Legality}

@begin{StaticSem}
@Defn{profile}
The @i(profile) of (a view of) a callable entity
is either a @nt{parameter_profile} or
@nt{parameter_and_result_profile}@Redundant[;
it embodies information about
the interface to that entity @em for example, the profile includes
information about parameters passed to the callable entity.
All callable entities have a profile @em enumeration literals,
other subprograms, and entries.
An access-to-subprogram type has a designated profile.]
Associated with a profile is a calling convention.
A @nt<subprogram_declaration> declares a procedure or a function, as
indicated by the initial reserved word, with name and profile as given by
its specification.

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00231-01],ARef=[AI95-00318-02]}
@PDefn2{Term=[nominal subtype], Sec=(of a formal parameter)}
The nominal subtype of a formal parameter is
the subtype @Chg{Version=[2],New=[determined],Old=[denoted]} by
@Chg{Version=[2],New=[the optional @nt{null_exclusion} and ], Old=[]}the
@nt{subtype_mark}, or defined by the @nt{access_definition}, in the
@nt{parameter_specification}.@Chg{Version=[2],New=[ The nominal
subtype of a function result is the subtype
determined by the optional @nt{null_exclusion} and the @nt{subtype_mark}, or
defined by the @nt{access_definition}, in the
@nt{parameter_and_result_profile}.
@PDefn2{Term=[nominal subtype], Sec=(of a function result)}], Old=[]}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0142-4]}
@ChgAdded{Version=[3],Text=[@Defn{explicitly aliased parameter}@Defn2{Term=[parameter],Sec=(explicitly aliased)}An
@i(explicitly aliased parameter) is a formal parameter whose
@nt{parameter_specification} includes the reserved word @key[aliased].]}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00231-01],ARef=[AI95-00254-01],ARef=[AI95-00318-02]}
@Defn{access parameter}
An @i(access parameter) is a formal @key[in] parameter
specified by an @nt{access_definition}.
@Defn{access result type}
@Chg{Version=[2],New=[An @i(access result type) is a function result type specified by
an @nt{access_definition}.],Old=[]}
An access parameter @Chg{Version=[2],New=[or result type ],Old=[]}is of an
anonymous
@Chg{Version=[2],New=[access],Old=[general access-to-variable]} type (see
@RefSecNum{Access Types}). @Redundant[Access parameters
@Chg{Version=[2],New=[of an access-to-object type],Old=[]} allow dispatching
calls to be controlled by access values.@Chg{Version=[2],New=[ Access
parameters of an access-to-subprogram type permit calls to subprograms passed
as parameters irrespective of their accessibility level.],Old=[]}]

@begin{Discussion}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
@ChgAdded{Version=[2],Text=[Access result types have normal accessibility and
thus don't have any special properties worth noting here.]}
@end{Discussion}

@leading@keepnext@Defn2{Term=[subtypes], Sec=(of a profile)}
The @i(subtypes of a profile) are:
@begin{Itemize}
  For any non-access parameters, the nominal subtype of the parameter.

  @ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00254-01]}
  For any access parameters@Chg{Version=[2],New=[ of an access-to-object type],Old=[]},
  the designated subtype of the parameter type.

  @ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00254-01]}
  @ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0164-1]}
  @ChgAdded{Version=[2],Text=[For any access parameters of an access-to-subprogram
  type, the subtypes of the @Chg{Version=[3],New=[designated ],Old=[]}profile
  of the parameter type.]}

  @ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00231-01],ARef=[AI95-00318-02]}
  @Chg{Version=[2],New=[For any non-access result, the nominal subtype of the
  function result.],Old=[For any result, the result subtype.]}

  @ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
  @Chg{Version=[2],New=[For any access result type of an access-to-object type,
  the designated subtype of the result type.],Old=[]}

  @ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
  @ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0164-1]}
  @Chg{Version=[2],New=[For any access result type of an access-to-subprogram
  type, the subtypes of the @Chg{Version=[3],New=[designated ],Old=[]}profile
  of the result type.],Old=[]}

@end{Itemize}

@Redundant[@Defn2{Term=[types], Sec=(of a profile)}
The @i{types of a profile} are the types of those subtypes.]

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00348-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0177-1]}
@Redundant[A subprogram declared by an
@nt<abstract_subprogram_declaration>
is abstract; a subprogram declared by a @nt<subprogram_declaration>
is not. See @RefSec{Abstract Types and Subprograms}.@Chg{Version=[2],New=[
Similarly, a procedure defined by a
@nt{null_procedure_declaration} is a null procedure; a procedure declared by
a @nt{subprogram_declaration} is not. See @RefSec{Null Procedures}.@Chg{Version=[3],New=[
Finally, a function defined by an @nt{expression_function_declaration} is
an expression function; a function declared by
a @nt{subprogram_declaration} is not. See @RefSec{Expression Functions}.],Old=[]}],Old=[]}]

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00218-03]}
@ChgAdded{Version=[2],Text=[@Redundant[An @nt{overriding_indicator} is used to
indicate whether overriding is intended. See @RefSec{Overriding Indicators}.]]}
@end{StaticSem}

@begin{RunTime}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00348-01]}
@PDefn2{Term=[elaboration], Sec=(subprogram_declaration)}@Chg{Version=[2],New=[],Old=[
@PDefn2{Term=[elaboration], Sec=(abstract_subprogram_declaration)}]}
The elaboration of a @nt{subprogram_declaration}@Chg{Version=[2],New=[],Old=[
or an @nt{abstract_subprogram_declaration}]} has no effect.
@end{RunTime}

@begin{Notes}
A @nt{parameter_specification} with several identifiers is equivalent
to a sequence of single @nt{parameter_specification}s, as explained
in @RefSecNum{Objects and Named Numbers}.

Abstract subprograms do not have bodies, and cannot be used
in a nondispatching call (see @RefSec{Abstract Types and Subprograms}).

The evaluation of @nt<default_expression>s is caused by certain
calls, as described in @RefSecNum{Parameter Associations}.
They are not evaluated during the elaboration of
the subprogram declaration.

Subprograms can be called recursively and can be called
concurrently from multiple tasks.
@end{Notes}

@begin{Examples}
@leading@keepnext@i{Examples of subprogram declarations:}
@begin{Example}
@key[procedure] Traverse_Tree;
@key[procedure] Increment(X : @key[in] @key[out] Integer);
@key[procedure] Right_Indent(Margin : @key[out] Line_Size);          --@RI{  see @RefSecNum{Integer Types}}
@key[procedure] Switch(From, To : @key[in] @key[out] Link);                --@RI{  see @RefSecNum{Incomplete Type Declarations}}

@key[function] Random @key[return] Probability;                      --@RI{  see @RefSecNum{Floating Point Types}}

@key[function] Min_Cell(X : Link) @key[return] Cell;                 --@RI{  see @RefSecNum{Incomplete Type Declarations}}
@key[function] Next_Frame(K : Positive) @key[return] Frame;          --@RI{  see @RefSecNum{Access Types}}
@key[function] Dot_Product(Left, Right : Vector) @key[return] Real;  --@RI{  see @RefSecNum{Array Types}}

@key[function] "*"(Left, Right : Matrix) @key[return] Matrix;        --@RI{  see @RefSecNum{Array Types}}
@end{Example}

@begin{WideAbove}
@leading@keepnext@i{Examples of @key[in] parameters with default expressions:}
@end{WideAbove}
@begin{Example}
@key[procedure] Print_Header(Pages  : @key[in] Natural;
            Header : @key[in] Line    :=  (1 .. Line'Last => ' ');  --@RI{  see @RefSecNum{Array Types}}
            Center : @key[in] Boolean := True);
@end{Example}
@end{Examples}

@begin{Extend83}
@Defn{extensions to Ada 83}
The syntax for @nt{abstract_subprogram_declaration} is added.
The syntax for @nt{parameter_specification} is revised to allow
for access parameters (see @RefSecNum{Access Types})

Program units that are library units may have
a @nt{parent_unit_name} to indicate the parent of a child
(see Section 10).
@end{Extend83}

@begin{DiffWord83}
We have incorporated the rules from
RM83-6.5, @lquotes@;Function Subprograms@rquotes@; here and in
@RefSec{Subprogram Bodies}

We have incorporated the definitions of RM83-6.6, @lquotes@;Parameter and Result
Type Profile - Overloading of Subprograms@rquotes@; here.

The syntax rule for @nt{defining_operator_symbol} is new.
It is used for the defining occurrence of an @nt{operator_symbol},
analogously to @nt{defining_identifier}.
Usage occurrences use the @nt{direct_name} or @nt{selector_name}
syntactic categories.
The syntax rules for @nt{defining_designator} and
@nt{defining_program_unit_name} are new.
@end{DiffWord83}

@begin{Extend95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00218-03]}
  @ChgAdded{Version=[2],Text=[@Defn{extensions to Ada 95}
  Subprograms now allow @nt{overriding_indicator}s for better error checking
  of overriding.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00231-01]}
  @ChgAdded{Version=[2],Text=[An optional @nt{null_exclusion} can be used in a
  formal parameter declaration. Similarly, an optional @nt{null_exclusion} can
  be used in a function result.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[The return type of a function can be an
  anonymous access type.]}
@end{Extend95}

@begin{DiffWord95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00254-01]}
  @ChgAdded{Version=[2],Text=[A description of the purpose of anonymous
  access-to-subprogram parameters and the definition of the profile of
  subprograms containing them was added.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
  @ChgAdded{Version=[2],Text=[Split the production for
  @nt{subprogram_specification} in order to make the declaration
  of null procedures (see @RefSecNum{Null Procedures}) easier.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
  @ChgAdded{Version=[2],Text=[Moved the @SyntaxTitle and
  @RuntimeTitle for @nt{abstract_subprogram_declaration} to
  @RefSecNum{Abstract Types and Subprograms}, so that the syntax
  and semantics are together. This also keeps abstract and null
  subprograms similar.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00395-01]}
  @ChgAdded{Version=[2],Text=[Revised to allow @ntf{other_format} characters
  in @nt{operator_symbol}s in the same way as the underlying constructs.]}
@end{DiffWord95}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0142-4]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}Parameters can
  now be explicitly aliased, allowing parts of function results to
  designate parameters and forcing by-reference parameter passing.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0143-1]}
  @ChgAdded{Version=[3],Text=[The parameters
  of a function can now have any mode.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0183-1]}
  @ChgAdded{Version=[3],Text=[An optional @nt{aspect_specification} can be
  used in a @nt{subprogram_declaration}.
  This is described in @RefSecNum{Aspect Specifications}.]}
@end{Extend2005}

@begin{DiffWord2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
  @ChgAdded{Version=[3],Text=[Added expression functions (see
  @RefSecNum{Expression Functions}) to the wording.]}
@end{DiffWord2005}


@LabeledAddedSubClause{Version=[3],Name=[Preconditions and Postconditions]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0247-1]}
@ChgAdded{Version=[3],Type=[Leading],Text=[For a subprogram or entry, the
following language-defined aspects may be specified with an
@nt{aspect_specification} (see @RefSecNum{Aspect Specifications}):]}

@begin{Description}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[Pre@\This aspect
  specifies a specific precondition for a callable entity; it shall
  be specified by an @nt{expression}, called a
  @i<specific precondition
  expression>.@Defn{specific precondition expression}@Defn2{Term=[precondition expression],Sec=[specific]}
  If not specified for an entity, the specific precondition
  expression for the entity is the enumeration literal True.]}

@begin{Honest}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[In this and the following rules, we are talking
  about the enumeration literal True declared in package Standard (see
  @RefSecNum{The Package Standard}), and not some
  other value or identifier True. That matters as some rules depend on full
  conformance of these experessions, which depends on the specific declarations
  involved.]}
@end{Honest}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0254-1],ARef=[AI05-0262-1]}
@ChgAdded{Version=[3],Text=[Pre'Class@\This aspect
  specifies a class-wide precondition for an operation of a tagged type and its
  descendants; it shall be specified by an @nt{expression}, called a
  @i<class-wide precondition expression>.@Defn{class-wide precondition expression}@Defn2{Term=[precondition expression],Sec=[class-wide]}
  If not specified for an entity, then if no other
  class-wide precondition applies to the entity,the class-wide precondition
  expression for the entity is the enumeration literal True.]}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0254-1]}
  @ChgAdded{Version=[3],Text=[If other class-wide preconditions apply to the
  entity and no class-wide precondition is specified, no class-wide precondition
  is defined for the entity; of course, the class-wide preconditions (of
  ancestors) that apply are still going to be checked. We need subprograms that
  don't have ancestors and don't specify a class-wide precondition to have a
  class-wide precondition of True, so that adding such a precondition to a
  descendant has no effect (necessary as a dispatching call through the root
  routine would not check any precondition).]}
@end{Ramification}

@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[Post@\This aspect
  specifies a specific postcondition for a callable entity; it shall be
  specified by an @nt{expression}, called a @i<specific postcondition
  expression>.@Defn{specific postcondition expression}@Defn2{Term=[postcondition expression],Sec=[specific]}
  If not specified for an entity, the specific postcondition
  expression for the entity is the enumeration literal True.]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0262-1]}
@ChgAdded{Version=[3],Text=[Post'Class@\This aspect
  specifies a class-wide postcondition for an operation of a tagged type and its
  descendants; it shall be specified by an @nt{expression}, called a
  @i<class-wide postcondition expression>.@Defn{class-wide postcondition expression}@Defn2{Term=[postcondition expression],Sec=[class-wide]}
  If not specified for an entity, the class-wide postcondition
  expression for the entity is the enumeration literal True.]}
@end{Description}

@begin{Resolution}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Text=[The expected type for a precondition or
postcondition expression is any boolean type.@PDefn2{Term=[expected type],
Sec=(precondition expression)}@PDefn2{Term=[expected type],
Sec=(postcondition expression)}]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Text=[Within the expression for a Pre'Class or Post'Class aspect for a primitive
subprogram of a tagged type @i<T>, a name that denotes a formal parameter of type
@i<T> is interpreted as having type @i<T>'Class. Similarly, a name that denotes a
formal access parameter of type access-to-@i<T> is interpreted as having type
access-to-@i<T>'Class. @Redundant[This ensures the expression is
well-defined for a primitive subprogram of a type descended from @i<T>.]]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Text=[For an attribute_reference with attribute_designator
Old, if the attribute reference has an expected type or shall resolve to a given
type, the same applies to the @nt{prefix}; otherwise the @nt{prefix} shall be
resolved independently of context.]}

@end{Resolution}

@begin{Legality}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0230-1]}
@ChgAdded{Version=[3],Text=[The Pre or Post aspect shall not be specified for an
abstract subprogram or a null procedure. @Redundant[Only the Pre'Class and
Post'Class aspects may be specified for such a subprogram.]]}

@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0183-1]}
  @ChgAdded{Version=[3],Text=[Pre'Class and Post'Class can only be specified
  on primitive routines of tagged types, by a blanket rule found in
  @RefSecNum{Aspect Specifications}.]}
@end{Discussion}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
@ChgAdded{Version=[3],Type=[Leading],Text=[If a type @i<T> has an implicitly
declared subprogram @i<P> inherited from a parent type @i<T1> and
a homograph (see @RefSecNum{Visibility}) of @i<P> from a progenitor type
@i<T2>, and]}

@begin{Itemize}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[the corresponding primitive subprogram @i<P1> of
  type @i<T1> is neither null nor abstract; and]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[the class-wide precondition expression True does
  not apply to @i<P1> (implicitly or explicitly); and]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[there is a class-wide precondition expression that
  applies to the corresponding primitive subprogram @i<P2> of @i<T2> that does
  not fully conform to any class-wide precondition expresion that applies to
  @i<P1>,]}
@end{Itemize}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
@ChgAdded{Version=[3],Type=[Leading],Text=[then:]}

@begin{Itemize}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[If the type @i<T> is abstract the implicitly
  declared subprogram is @i<abstract>.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Otherwise, the subprogram @i{requires overriding}
  and shall be overridden with a nonabstract subprogram.@PDefn{requires overriding}]}

@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[We use the term "requires overriding" here so that
    this rule is taken into account when calculating visibility in
    @RefSecNum{Visibility}; otherwise we would have a mess when this routine is
    overridden.]}
@end{Discussion}
@end{Itemize}

@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Such an inherited subprogram would necessarily
    violate the Liskov Substitutability Principle (LSP) if called via a
    dispatching call from an ancestor other than the one that provides the
    called body. In such a case, the class-wide precondition of the actual body
    is stronger than the class-wide precondition of the ancestor. If we did not
    enforce that precondition for the body, the body could be called when the
    precondition it knows about is False @em such "counterfeiting" of
    preconditions has to be avoided. But enforcing the precondition violates
    LSP. We do not want the language to be implicitly creating bodies that
    violate LSP; the programmer can still write an explicit body that calls the
    appropriate parent subprogram. In that case, the violation of LSP is
    explicitly in the code and obvious to code reviewers (both human and
    automated).]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[We have to say that the subprogram is abstract for
    an abstract type in this case, so that the next concrete type has to
    override it for the reasons above. Otherwise, inserting an extra level of
    abstract types would eliminate the requirement to override (as there is only
    one declared operation for the concrete type), and that would be bad for the
    reasons given above.]}
@end{Reason}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This requires the set of class-wide preconditions that
    that apply to the interface routine to be strictly stronger than those that
    apply to the concrete routine. Since full conformance
    requires each name to denote the same declaration, it is unlikely that
    independently declared preconditions would conform. This rule does allow
    "diamond inheritance" of preconditions, and of course no preconditions at
    all match.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[We considered adopting a rule that would allow
    examples where the expressions would conform after all inheritance has been
    applied, but this is complex and is not likely to be common in practice.
    Since the penalty here is just that an explicit overriding is required, the
    complexity is too much.]}
@end{Ramification}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0247-1]}
@ChgAdded{Version=[3],Text=[If a renaming of a subprogram or entry @i<S1>
overrides an inherited subprogram @i<S2>, then the overriding is illegal unless
each class-wide precondition expression that applies to @i<S1> fully conforms to
some class-wide precondition expression that applies to @i<S2> and each
class-wide precondition expression that applies to @i<S2> fully conforms to some
class-wide precondition expression that applies to @i<S1>.]}

@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Such an overriding subprogram would violate LSP,
    as the precondition of @i<S1> would usually be different (and thus stronger)
    than the one known to a dispatching call through an ancestor routine of @i<S2>.
    This is always OK if the preconditions match, so we always allow that.]}
@end{Reason}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This only applies to primitives of tagged types;
    other routines cannot have class-wide preconditions.]}
@end{Ramification}
@end{Legality}

@begin{StaticSem}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Text=[If a Pre'Class or Post'Class aspect is specified for
a primitive subprogram of a tagged type @i<T>, then the associated expression
also applies to the corresponding primitive subprogram of each descendant of
@i<T>.]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Type=[Leading],Text=[For @PrefixType{a @nt{prefix} X that
denotes an object of a nonlimited type}, the following attribute is defined:]}
@begin(description)
@ChgAttribute{Version=[3],Kind=[AddedNormal],ChginAnnex=[T],
  Leading=<F>, Prefix=<X>, AttrName=<Old>, ARef=[AI05-0145-2],
  Text=[@Chg{Version=[3],New=[Denotes the value of X at the beginning of the
  execution of the subprogram or entry. For each X'Old in a postcondition
  expression that is enabled, a constant is implicitly declared at the beginning
  of the subprogram or entry, of the type of X, initialized to X. The value of
  X'Old in the postcondition expression is the value of this constant. The type
  of X'Old is the type of X. These implicit declarations occur in an arbitrary
  order.@PDefn2{Term=[arbitrary order],Sec=[allowed]}],Old=[]}]}@Comment{End of Annex text here.}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],NoPrefix=[T],Text=[Use of this attribute is allowed only
  within a postcondition expression.]}
@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=<The @nt{prefix} X can be any
  nonlimited object that obeys the syntax for prefix. Useful cases are: the name
  of a formal parameter of mode [@key[in]] @key[out], the name of a global
  variable updated by the subprogram, a function call passing those as
  parameters, a subcomponent of those things, etc.>}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[A qualified expression can be used to make an
  arbitrary expression into a valid prefix, so T'(X + Y)'Old is legal, even
  though (X + Y)'Old is not. The value being saved here is the sum of X and Y (a
  function result is an object). Of course, in this case "+"(X, Y)'Old is also
  legal, but the qualified expression is arguably more readable.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Note that F(X)'Old and F(X'Old) are not
  necessarily equal. The former calls F(X) and saves that value for later use
  during the postcondition. The latter saves the value of X, and during the
  postcondition, passes that saved value to F. In most cases, the former is what
  one wants.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[If X has controlled parts, adjustment and
  finalization are implied by the implicit constant declaration.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[If postconditions are disabled, we want the
  compiler to avoid any overhead associated with saving 'Old values.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=['Old makes no sense for limited types, because its
  implementation involves copying. It might make semantic sense to allow
  build-in-place, but it's not worth the trouble.]}

@end{Discussion}
@end(description)
@EndPrefixType{}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Type=[Leading],Text=[For @PrefixType{a @nt{prefix} F that
denotes a function declaration}, the following attribute is defined:]}
@begin(description)
@ChgAttribute{Version=[3],Kind=[AddedNormal],ChginAnnex=[T],
  Leading=<F>, Prefix=<F>, AttrName=<Result>, ARef=[AI05-0145-2],
  Text=[@Chg{Version=[3],New=[Within a postcondition expression for function F,
  denotes the result object of the function. The type of this attribute is that
  of the function result except within a Post'Class postcondition expression for
  a function with a controlling result or with a controlling access result. For
  a controlling result, the type of the attribute is @i<T>'Class, where @i<T> is
  the function result type. For a controlling access result, the type of the
  attribute is an anonymous access type whose designated type is @i<T>'Class,
  where @i<T> is the designated type of the function result type. Use of this
  attribute is allowed only within a postcondition expression
  for F.],Old=[]}]}@Comment{End of Annex text here.}
@end(description)
@EndPrefixType{}
@end{StaticSem}

@begin{Runtime}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0247-1]}
@ChgAdded{Version=[3],Text=[If the assertion policy (see
@RefSecNum{Pragmas Assert and Assertion_Policy}) in effect at the point of
a subprogram or entry declaration is Check, then upon a call of the
subprogram or entry, after evaluating any actual parameters,
precondition checks are performed as follows:@Defn2{Term=[assertion policy],
  Sec=[precondition check]}@Defn{precondition check}@Defn2{Term=[check, language-defined],
  Sec=[controlled by assertion policy]}]}

@begin{Itemize}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[The specific precondition check begins with the
  evaluation of the specific precondition expression that applies to the
  subprogram or entry; if the expression evaluates to False,
  Assertions.Assertion_Error is raised.@Defn2{Term=(Assertion_Error),
  Sec=(raised by failure of run-time check)}]}

@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[The class-wide precondition check begins with the
  evaluation of any class-wide precondition expressions that apply to the
  subprogram or entry. If and only if all the class-wide precondition
  expressions evaluate to False, Assertions.Assertion_Error is raised.@Defn2{Term=(Assertion_Error),
  Sec=(raised by failure of run-time check)}]}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[The class-wide precondition expressions of the
    entity itself as well as those of any parent or progentitor operations are
    evaluated, as these expressions apply to the corresponding operations
    of all descendants.]}
@end{Ramification}
@end{Itemize}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
@ChgAdded{Version=[3],Text=[The checks are performed in an arbitrary order,
and if any of the class-wide precondition expressions evaluate to True, it is
not specified whether the other class-wide precondition expressions are
evaluated. The precondition checks and any check for elaboration of the
subprogram body are performed in an arbitrary order. It is not
specified whether in a call on a protected operation, the checks are performed
before or after starting the protected action. For a task or protected entry
call, the checks are performed prior to checking whether the entry is open.@PDefn2{Term=(arbitrary order),
  Sec=(allowed)}@PDefn{unspecified}]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
@ChgAdded{Version=[3],Text=[If the assertion policy in effect at the point of a
subprogram or entry declaration is Check, then upon successful return from a
call of the subprogram or entry, prior to copying back any by-copy @key[in out]
or @key[out] parameters, the postcondition check is performed. This consists of
the evaluation of the specific and class-wide postcondition expressions that
apply to the subprogram or entry. If any of the postcondition expressions
evaluate to False, then Ada.Assertions.Assertion_Error is raised. The
postcondition expressions are evaluated in an arbitrary order, and if any
postcondition expression evaluates to False, it is not specified whether any
other postcondition expressions are evaluated. The postcondition check and
constraint checks associated with copying back @key[in out] or @key[out]
parameters are performed in an arbitrary order.@Defn2{Term=[assertion policy],
  Sec=[postcondition check]}@Defn{postcondition check}@Defn2{Term=[check, language-defined],
  Sec=[controlled by assertion policy]}@Defn2{Term=(Assertion_Error),
  Sec=(raised by failure of run-time check)}@PDefn2{Term=(arbitrary order),
  Sec=(allowed)}@PDefn{unspecified}]}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[The class-wide postcondition expressions of the
  entity itself as well as those of any parent or progentitor operations are
  evaluated, as these apply to all descendants; in constrast, only the specific
  postcondition of the entity applies. Postconditions can always be evaluated
  inside the invoked body.]}
@end{Ramification}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Text=[If a precondition or postcondition check fails, the
exception is raised at the point of the call. @Redundant[The exception cannot
be handled inside the called subprogram.]]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
@ChgAdded{Version=[3],Text=[For any subprogram or entry call (including dispatching calls), the checks
that are performed that verify specific precondition expressions and specific
and class-wide postcondition expressions are determined by those for the subprogram
or entry actually invoked. Note that the class-wide postcondition expressions
verified by the postcondition check that is part of a call on a primitive
of type @i<T> includes all class-wide postcondition expressions originating
in any progenitor of @i<T>@Redundant[, even if the primitive called
is inherited from a type @i<T1> and some of the postcondition expressions do
not apply to the corresponding primitive of @i<T1>].]}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This applies to access-to-subprogram calls,
    dispatching calls, and to statically bound calls. We need this rule to cover
    statically bound calls as well, as specific pre- and postconditions are not
    inherited, but the subprogram might be.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[For concrete subprogram, we require the original
    specific postcondition to be evaluated as well as the inherited class-wide
    postconditions in order that the semantics of an explicitly defined wrapper
    that does nothing but call the original subprogram is the same as that of
    an inherited subprogram.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Note that this rule does not apply to class-wide
    preconditions; they have their own rules mentioned below.]}
@end{Ramification}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
@ChgAdded{Version=[3],Text=[The class-wide precondition check for a call to a
subprogram or entry consists solely of checking the class-wide precondition
expressions that apply to the denoted callable entity (not necessarily the one
that is invoked).]}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[For a dispatching call, we are talking about the
    Pre'Class(es) that apply to the subprogram that the dispatching call is
    resolving to, not the Pre'Class(es) for the subprogram that is ultimately
    dispatched to. The class-wide precondition of the resolved call is
    necessarily the same or stronger than that of the invoked call. For a
    statically bound call, these are the same; for an access-to-subprogram,
    (which has no class-wide preconditions of its own), we check the
    class-wide preconditions of the invoked routine.]}
@end{Ramification}

@begin{ImplNote}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[These rules imply that logically, class-wide
    preconditions of routines must be checked at the point of call (other
    than for access-to-subprogram calls, which must be checked in the body,
    probably using a wrapper). Specific preconditions that might be called with
    a dispatching call or via an access-to-subprogram value must be checked
    inside of the subprogram body. In contrast, the postcondition checks always
    need to be checked inside the body of the routine. Of course, an
    implementation can evaluate all of these at the point of call for statically
    bound calls if the implementation uses wrappers for dispatching bodies and
    for 'Access values.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[There is no requirement for an implementation
    to generate special code for routines that are imported from outside of
    the Ada program. That's because there is a requirement on the programmer
    that the use of interfacing aspects do not violate Ada semantics (see
    B.1). That includes making pre- and postcondition checks. For instance,
    if the implementation expects routines to make their own postcondition
    checks in the body before returning, C code can be assumed to do this
    (even though that is highly unlikely). That's even though the formal
    definition of those checks is that they are evaluated at the call site.
    Note that pre- and postconditions can be very useful for verification
    tools (even if they aren't checked), because they tell the tool about the
    expectations on the foreign code that it most likely cannot analyze.]}
@end{ImplNote}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
@ChgAdded{Version=[3],Text=[For a call via an access-to-subprogram value, all
precondition and postcondition checks performed are determined by the subprogram
or entry denoted by the prefix of the Access attribute reference that produced
the value.]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Text=[If the assertion policy in effect at the point of a
subprogram or entry declaration is Ignore, then no precondition or postcondition
check is performed on a call on that subprogram or entry. If the
assertion policy in effect at the point of a subprogram or entry declaration is
Check, then preconditions and postconditions are considered to be @i<enabled>
for that subprogram or entry.@Defn2{Term=[enabled],Sec=[precondition]}@Defn2{Term=[enabled],Sec=[postcondition]}]}
@end{Runtime}

@begin{Bounded}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
@ChgAdded{Version=[3],Text=[@PDefn2{Term=(bounded error),Sec=(cause)}
It is a bounded error to invoke a potentially blocking operation (see
@RefSecNum{Protected Subprograms and Protected Actions}) during the evaluation
of a precondition or postcondition expression. If the bounded error is detected,
Program_Error is raised. If not detected, execution proceeds normally, but if it
is invoked within a protected action, it might result in deadlock or a (nested)
protected action.]}
@end{Bounded}

@begin{Notes}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2]}
  @ChgAdded{Version=[3],Text=[A precondition is checked just before the call. If
  another task can change any value that the precondition expression depends on,
  the precondition may not hold within the subprogram or entry body.]}
@end{Notes}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0145-2],ARef=[AI05-0230-1],ARef=[AI05-0247-1],ARef=[AI05-0254-1]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}
  Pre and Post aspects are new.]}
@end{Extend2005}



@LabeledClause{Formal Parameter Modes}

@begin{Intro}
@Redundant[A @nt{parameter_specification} declares a formal parameter of
mode @key[in], @key[in out], or @key[out].]
@end{Intro}

@begin{StaticSem}
@Defn{pass by copy}
@Defn{by copy parameter passing}
@Defn{copy parameter passing}
@Defn{pass by reference}
@Defn{by reference parameter passing}
@Defn{reference parameter passing}
A parameter is passed either @i{by copy} or @i{by reference}.
@Redundant[When a parameter is passed by copy,
the formal parameter denotes a separate object from the
actual parameter, and any information transfer between the two occurs
only before and after executing the subprogram.
When a parameter is passed by reference,
the formal parameter denotes (a view of) the object denoted by the
actual parameter; reads and updates of the formal parameter directly
reference the actual parameter object.]

@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0142-4]}
@Defn{by-copy type}
A type is a @i(by-copy type) if it is an elementary type,
or if it is a descendant of a private type whose full type is a
by-copy type. A parameter of a by-copy type @Chg{Version=[3],New=[that is not
explicitly aliased ],Old=[]}is passed by copy.

@leading@keepnext@Defn{by-reference type}
A type is a @i(by-reference type) if it
is a descendant of one of the following:
@begin(itemize)
  a tagged type;

  a task or protected type;

@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0096-1]}
  @Chg{Version=[3],New=[an explicitly limited record type],Old=[a
  nonprivate type with the reserved word @key[limited] in its declaration]};
@begin{Ramification}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0096-1]}
  @ChgDeleted{Version=[3],Text=[A limited private type is by-reference
  only if it falls under one of the other categories.]}
@end{Ramification}

  a composite type with a subcomponent of a by-reference type;

  a private type
  whose full type is a by-reference type.
@end(itemize)

@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0142-4],ARef=[AI05-0188-1]}
A parameter of a by-reference type is passed by reference@Chg{Version=[3],New=[, as is an explicitly aliased parameter
of any type],Old=[]}.
@Defn2{Term=[associated object], Sec=(of a value of a by-reference type)}
Each value of a by-reference type has an associated object.
For a parenthesized expression, @nt{qualified_expression},
or @nt{type_conversion}, this object is the one associated with the
operand.@Chg{Version=[3],New=[ For a
@nt{conditional_expression}, this object is the one associated
with the evaluated @Syni{dependent_}@nt{expression}.],Old=[]}

@begin{Ramification}
By-reference parameter passing makes sense only if there is an
object to reference; hence, we define such an object for each
case.

Since tagged types are by-reference types, this implies that every value
of a tagged type has an associated object. This simplifies things,
because we can define the tag to be a property of the object, and not of
the value of the object, which makes it clearer that object tags never
change.

We considered simplifying things even more by making every value (and
therefore every expression) have an associated object. After all,
there is little semantic difference between a constant object and a
value.
However, this would cause problems for untagged types.
In particular, we would have to do a constraint check on every read of a
type conversion (or a renaming thereof) in certain cases.

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
We do not want this definition to depend on the view of the type;
privateness is essentially ignored for this definition.
Otherwise, things would be confusing (does the rule apply at the call
site, at the site of the declaration of the subprogram,
at the site of the
@Chg{Version=[2],New=[return statement],Old=[@nt{return_statement}]}?),
and requiring different calls to use different mechanisms would be an
implementation burden.

@RefSec{Shared Variable Control} says that a composite type with an
atomic or volatile subcomponent is a by-reference type,
among other things.

@Defn2{Term=[associated object], Sec=(of a value of a limited type)}
Every value of a limited by-reference type is the value of
one and only one limited object.
The @i{associated object} of a value of a limited by-reference type is
the object whose value it represents.
@Defn2{Term=[same value], Sec=(for a limited type)}
Two values of a limited by-reference type are the @i{same}
if and only if they represent the value of the same object.

We say @lquotes@;by-reference@rquotes@; above because
these statements are not always true for limited private types
whose underlying type is nonlimited (unfortunately).
@end{Ramification}

@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0240-1]}
@PDefn{unspecified}
For @Chg{Version=[3],New=[other ],Old=[]}parameters@Chg{Version=[3],New=[],Old=[ of other types]},
it is unspecified whether the parameter
is passed by copy or by reference.
@begin{Discussion}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0005-1]}
  There is no need to incorporate the discussion of AI83-00178,
  which requires pass-by-copy for certain kinds of actual parameters,
  while allowing pass-by-reference for others.
  This is because we explicitly indicate that a function
  creates an anonymous constant object for its result@Chg{Version=[3],New=[],Old=[,
  unless the type is a return-by-reference type]}
  (see @RefSecNum{Return Statements}).
  We also provide a special dispensation for
  instances of Unchecked_Conversion to return by reference@Chg{Version=[3],New=[],Old=[, even
  if the result type is not a return-by-reference type]}
  (see @RefSecNum{Unchecked Type Conversions}).
@end{Discussion}
@end{StaticSem}

@begin{Bounded}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0240-1]}
@Defn{distinct access paths}
@Defn2{Term=[access paths],Sec=(distinct)}
@IndexSee{Term=[aliasing],See=(distinct access paths)}
@PDefn2{Term=(bounded error),Sec=(cause)}
If one @nt<name> denotes a part of a formal parameter,
and a second @nt<name> denotes a part of
a distinct formal parameter or an object that is not
part of a formal parameter, then the two @nt<name>s are
considered @i(distinct access paths).
If an object is of a type for which the parameter passing
mechanism is not specified@Chg{Version=[3],New=[ and is not an
explicitly aliased parameter],Old=[]}, then it is a bounded error to
assign to the object via one access path,
and then read the value of the object via a distinct access path,
unless the first access path denotes a part of a formal parameter that
no longer exists at the point of the second access
@Redundant[(due to leaving the corresponding callable construct).]
@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
The possible consequences are that Program_Error is raised,
or the newly assigned value is read, or some old value of the object is read.
@begin{Discussion}
For example, if we call @lquotes@;P(X => Global_Variable, Y => Global_Variable)@rquotes@;,
then within P, the names @lquotes@;X@rquotes@;, @lquotes@;Y@rquotes@;, and @lquotes@;Global_Variable@rquotes@;
are all distinct access paths.
If Global_Variable's type is neither pass-by-copy nor pass-by-reference,
then it is a bounded error to assign to Global_Variable and
then read X or Y, since the language does not specify whether the
old or the new value would be read. On the other hand, if
Global_Variable's type is pass-by-copy, then the old value would
always be read, and there is no error. Similarly, if Global_Variable's
type is defined by the language to be pass-by-reference, then the
new value would always be read, and again there is no error.
@end{Discussion}
@begin{Reason}
We are saying @i(assign) here, not @i(update),
because updating any subcomponent is considered
to update the enclosing object.

The @lquotes@;still exists@rquotes@; part is so that a read after the subprogram returns
is OK.

If the parameter is of a by-copy type,
then there is no issue here
@em the formal is not a view of the actual.
If the parameter is of a by-reference type,
then the programmer may depend on updates through one access path
being visible through some other access path,
just as if the parameter were of an access type.
@end{Reason}
@begin{ImplNote}
The implementation can keep a copy in a register of a parameter
whose parameter-passing mechanism is not specified.
If a different access path is used to update the object (creating
a bounded error situation),
then the implementation can still use the value of the register,
even though the in-memory version of the object has been changed.
However, to keep the error properly bounded,
if the implementation chooses to read the in-memory version,
it has to be consistent -- it cannot then assume that something it has
proven about the register is true of the memory location.
For example, suppose the formal parameter is L,
the value of L(6) is now in a register, and L(6) is used
in an @nt{indexed_component} as in @lquotes@;A(L(6)) := 99;@rquotes@;,
where A has bounds 1..3.
If the implementation can prove that the value for L(6) in the register is in
the range 1..3, then it need not perform the constraint check if it
uses the register value.
However, if the memory value of L(6) has been changed to 4,
and the implementation uses that memory value,
then it had better not alter memory outside of A.

Note that the rule allows the implementation to pass a parameter by
reference and then keep just part of it in a register, or,
equivalently, to pass part of the parameter by reference and another
part by copy.
@end{ImplNote}
@begin{Reason}
@leading@;We do not want to go so far as to say that the mere presence
of aliasing is wrong.
We wish to be able to write the following sorts of things
in standard Ada:
@begin{Example}
@key[procedure] Move ( Source  : @key[in]  String;
                 Target  : @key[out] String;
                 Drop    : @key[in]  Truncation := Error;
                 Justify : @key[in]  Alignment  := Left;
                 Pad     : @key[in]  Character  := Space);
--@RI{ Copies elements from Source to Target (safely if they overlap)}
@end{Example}

This is from the standard string handling package.
It would be embarrassing if this couldn't be written in Ada!

The @lquotes@;then@rquotes@; before @lquotes@;read@rquotes@; in the rule implies that the implementation
can move a read to an earlier place in the code, but not to a later
place after a potentially aliased assignment.
Thus, if the subprogram reads one of its parameters into a local
variable, and then updates another potentially aliased one,
the local copy is safe @em it is known to have the old value.
For example, the above-mentioned Move subprogram can be implemented
by copying Source into a local variable before assigning into Target.

@leading@;For an @nt{assignment_statement} assigning one array parameter to another,
the implementation has to check which direction to copy
at run time, in general, in case the actual parameters are
overlapping slices.
For example:
@begin{Example}
@key[procedure] Copy(X : @key[in out] String; Y: String) @key[is]
@key[begin]
    X := Y;
@key[end] Copy;
@end{Example}

It would be wrong for the compiler to assume that X and Y
do not overlap (unless, of course, it can prove otherwise).
@end{Reason}
@end{Bounded}

@begin{Notes}
A formal parameter of mode @key(in) is a constant
view (see @RefSecNum{Objects and Named Numbers});
it cannot be updated within the @nt{subprogram_body}.
@end{Notes}

@begin{Extend83}
@Defn{extensions to Ada 83}
The value of an @key(out) parameter may be read.
An @key(out) parameter is treated like a declared
variable without an explicit initial expression.
@end{Extend83}

@begin{DiffWord83}
Discussion of copy-in for parts of out parameters is now
covered in @RefSec{Parameter Associations}.

The concept of a by-reference type is new to Ada 95.

We now cover in a general way in @RefSecNum{Operations of Discriminated Types}
the rule regarding erroneous execution when a discriminant
is changed and one of the parameters depends on the discriminant.
@end{DiffWord83}

@begin{DiffWord2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0096-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Corrected so that
  limited derived types are by-reference only if their parent is.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0142-4]}
  @ChgAdded{Version=[3],Text=[Defined that explicitly aliased parameters
  (see @RefSecNum{Subprogram Declarations}) are always passed by reference.]}
@end{DiffWord2005}


@LabeledClause{Subprogram Bodies}

@begin{Intro}
@Redundant[A @nt{subprogram_body} specifies the execution of a
subprogram.]
@end{Intro}

@begin{Syntax}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00218-03]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0183-1]}
@Syn{lhs=<subprogram_body>,rhs="@Chg{Version=[2],New=<
    [@Syn2{overriding_indicator}]>,Old=<>}
    @Syn2{subprogram_specification}@Chg{Version=[3],New=<
       [@Syn2{aspect_specification}]>,Old=[]} @key{is}
       @Syn2{declarative_part}
    @key{begin}
        @Syn2{handled_sequence_of_statements}
    @key{end} [@Syn2{designator}];"}

@begin{SyntaxText}
If a @nt{designator} appears at the end of a @nt{subprogram_body},
it shall repeat the @nt{defining_designator} of the @nt{subprogram_specification}.
@end{SyntaxText}
@end{Syntax}

@begin{Legality}
@Redundant[In contrast to other bodies,]
a @nt{subprogram_body} need not be the completion of a previous
declaration@Redundant[,
in which case the body declares the subprogram].
If the body is a completion, it shall be the completion of a
@nt{subprogram_declaration} or @nt{generic_subprogram_declaration}.
The profile of a @nt{subprogram_body} that completes a declaration
shall conform fully to that of the declaration.
@Defn2{Term=[full conformance],Sec=(required)}
@end{Legality}

@begin{StaticSem}
A @nt{subprogram_body} is considered a declaration.
It can either complete a previous declaration,
or itself be the initial declaration of the subprogram.
@end{StaticSem}

@begin{RunTime}
@PDefn2{Term=[elaboration], Sec=(non-generic subprogram_body)}
The elaboration of a non-generic
@nt{subprogram_body} has no other effect than to establish
that the subprogram can from then on be called without
failing the Elaboration_Check.
@begin{Ramification}
See @RefSecNum{Generic Bodies} for elaboration of a generic body.
Note that protected @ntf{subprogram_bodies} never get elaborated;
the elaboration of the containing @nt{protected_body}
allows them to be called without failing the Elaboration_Check.
@end{Ramification}

@PDefn2{Term=[execution], Sec=(subprogram_body)}
@Redundant[The execution of a @nt{subprogram_body} is invoked by a
subprogram call.]
For this execution the @nt{declarative_part} is elaborated, and the
@nt{handled_sequence_of_statements} is then executed.
@end{RunTime}

@begin{Examples}
@leading@keepnext@i{Example of procedure body:}
@begin{Example}
@key[procedure] Push(E : @key[in] Element_Type; S : @key[in] @key[out] Stack) @key[is]
@key[begin]
   @key[if] S.Index = S.Size @key[then]
      @key[raise] Stack_Overflow;
   @key[else]
      S.Index := S.Index + 1;
      S.Space(S.Index) := E;
   @key[end] @key[if];
@key[end] Push;
@end{Example}

@begin{WideAbove}
@leading@keepnext@i{Example of a function body:}
@end{WideAbove}
@begin{Example}
@key[function] Dot_Product(Left, Right : Vector) @key[return] Real @key[is]
   Sum : Real := 0.0;
@key[begin]
   Check(Left'First = Right'First @key[and] Left'Last = Right'Last);
   @key[for] J @key[in] Left'Range @key[loop]
      Sum := Sum + Left(J)*Right(J);
   @key[end] @key[loop];
   @key[return] Sum;
@key[end] Dot_Product;
@end{Example}
@end{Examples}

@begin{Extend83}
@Defn{extensions to Ada 83}
A @nt{renaming_declaration} may be used instead of a @nt{subprogram_body}.
@end{Extend83}

@begin{DiffWord83}
The syntax rule for @nt{subprogram_body} now uses the syntactic category
@nt{handled_sequence_of_statements}.

The @nt{declarative_part} of a @nt{subprogram_body} is now required;
that doesn't make any real difference,
because a @nt{declarative_part} can be empty.

We have incorporated some rules from RM83-6.5 here.

RM83 forgot to restrict the definition of elaboration of a
@nt{subprogram_body} to non-generics.
@end{DiffWord83}

@begin{DiffWord95}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00218-03]}
@ChgAdded{Version=[2],Text=[@nt{Overriding_indicator} is added to
@nt{subprogram_body}.]}
@end{DiffWord95}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0183-1]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}An optional
  @nt{aspect_specification} can be used in a @nt{subprogram_body}.
  This is described in @RefSecNum{Aspect Specifications}.]}
@end{Extend2005}



@LabeledSubClause{Conformance Rules}

@begin{Intro}
@Defn{conformance}
@SeeAlso{Primary=[conformance],Other=(type conformance)}
@SeeAlso{Primary=[conformance],Other=(mode conformance)}
@SeeAlso{Primary=[conformance],Other=(subtype conformance)}
@SeeAlso{Primary=[conformance],Other=(full conformance)}
@Redundant[When subprogram profiles are given in more than one place,
they are required to conform in one of four ways: type conformance, mode
conformance, subtype conformance, or full conformance.]
@end{Intro}

@begin{StaticSem}
@ChgRef{Version=[1],Kind=[Revised],Ref=[8652/0011],ARef=[AI95-00117-01]}
@leading@Defn{convention}
@Defn{calling convention}
@Redundant[As explained in @RefSec{Interfacing Aspects},
a @i{convention} can be specified for an entity.]
@Chg{New=[Unless this International Standard states otherwise, the default
convention of an entity is Ada.],Old=[]}
@Redundant[For a callable entity or access-to-subprogram type,
the convention is called the @i{calling convention}.]
The following conventions are defined by the language:
@begin{Itemize}
@Defn{Ada calling convention}
@Defn2{Term=[calling convention], Sec=(Ada)}
The default calling convention for any subprogram not listed below is
@i{Ada}.
@Redundant[A @nt{pragma} Convention, Import, or Export may be used to override
the default calling convention (see @RefSecNum{Interfacing Aspects})].
@begin{Ramification}
See also the rule about renamings-as-body
in @RefSecNum{Subprogram Renaming Declarations}.
@end{Ramification}

@leading@Defn{Intrinsic calling convention}
@Defn2{Term=[calling convention], Sec=(Intrinsic)}
The @i{Intrinsic} calling convention represents
subprograms that are @lquotes@;built in@rquotes@; to the compiler.
The default calling convention is Intrinsic for the following:
@begin{InnerItemize}
  an enumeration literal;

  a "/=" operator declared implicitly due to
  the declaration of "=" (see @RefSecNum{Overloading of Operators});

  any other implicitly declared subprogram unless it is
  a dispatching operation of a tagged type;

  an inherited subprogram of a generic formal tagged type
  with unknown discriminants;
@begin{Reason}
@Comment{8652/0011 suggests that the reason for this rule be documented in
         the AARM.}
@ChgRef{Version=[1],Kind=[Added]}
@Chg{New=[Consider:],Old=[]}
@begin{Example}
@ChgRef{Version=[1],Kind=[Added]}
@Chg{New=[@key[package] P @key[is]
    @key[type] Root @key[is tagged null record];
    @key[procedure] Proc(X: Root);
@key[end] P;],Old=[]}

@ChgRef{Version=[1],Kind=[Added]}
@Chg{New=[@key[generic]
    @key[type] Formal(<>) @key[is new] Root @key[with private];
@key[package] G @key[is]
    ...
@key[end] G;],Old=[]}

@ChgRef{Version=[1],Kind=[Added]}
@ChgAdded{Version=[1],Text=[@key[package body] G @key[is]
    ...
    X: Formal := ...;
    ...
    Proc(X); -- @RI[This is a dispatching call in Instance, because]
             -- @RI[the actual type for Formal is class-wide.]
    ...
    -- @RI[Proc'Access would be illegal here, because it is of]
    -- @RI[convention Intrinsic, by the above rule.]
@key[end] G;]}

@ChgRef{Version=[1],Kind=[Added]}
@ChgAdded{Version=[1],Text=[@key[type] Actual @key[is new] Root @key[with] ...;
@key[procedure] Proc(X: Actual);
@key[package] Instance @key[is new] G(Formal => Actual'Class);
    -- @RI[It is legal to pass in a class-wide actual, because Formal]
    -- @RI[has unknown discriminants.]]}
@end{Example}

@ChgRef{Version=[1],Kind=[Added]}
@Chg{New=[Within Instance, all calls to Proc will be dispatching calls, so Proc doesn't
really exist in machine code, so we wish to avoid taking 'Access of it.
This rule applies to those cases where the actual type might be class-wide,
and makes these Intrinsic, thus forbidding 'Access.],Old=[]}
@end{Reason}


  an attribute that is a subprogram;

  @ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00252-01]}
  a subprogram declared immediately
  within a @nt{protected_body}@Chg{Version=[2],New=[;],Old=[.]}

  @ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00252-01],ARef=[AI95-00407-01]}
  @ChgAdded{Version=[2],Text=[any prefixed view of a subprogram (see
  @RefSecNum{Selected Components}).]}
  @begin{Reason}
    @ChgRef{Version=[2],Kind=[AddedNormal]}
    @ChgAdded{Version=[2],Text=[The profile of a prefixed view is
    different than the @lquotes@;real@rquotes profile of the subprogram
    (it doesn't have the first parameter), so we don't want to be able
    to take 'Access of it, as that would require generating a wrapper of
    some sort.]}
  @end{Reason}

@end{InnerItemize}

@NoPrefix@Redundant[The Access attribute is not allowed
for Intrinsic subprograms.]
@begin{Ramification}
  The Intrinsic calling convention really represents any number of
  calling conventions at the machine code level;
  the compiler might have a different instruction sequence for
  each intrinsic.
  That's why the Access attribute is disallowed.
  We do not wish to require the implementation to generate
  an out of line body for an intrinsic.

  Whenever we wish to disallow the Access attribute in order to ease
  implementation, we make the subprogram Intrinsic.
  Several language-defined subprograms have
  @lquotes@;@key[pragma] Convention(Intrinsic, ...);@rquotes@;.
  An implementation might actually implement this
  as @lquotes@;@key[pragma] Import(Intrinsic, ...);@rquotes@;,
  if there is really no body, and the implementation of the subprogram
  is built into the code generator.

  Subprograms declared in @ntf{protected_bodies} will generally have a
  special calling
  convention so as to pass along the identification of the
  current instance of the protected type.
  The convention is not @i(protected) since such local subprograms
  need not contain any @lquotes@;locking@rquotes@; logic since they are
  not callable via @lquotes@;external@rquotes@; calls;
  this rule prevents an access value designating such a subprogram
  from being passed outside the protected unit.

  The @lquotes@;implicitly declared subprogram@rquotes@; above refers to
  predefined operators (other than the "=" of a tagged type) and
  the inherited subprograms of
  untagged types.
@end{Ramification}

@Defn{protected calling convention}
@Defn2{Term=[calling convention], Sec=(protected)}
The default calling convention is @i{protected}
for a protected subprogram,
and for an access-to-subprogram type with
the reserved word @key(protected) in its definition.

@Defn{entry calling convention}
@Defn2{Term=[calling convention], Sec=(entry)}
The default calling convention is @i{entry} for an entry.

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00254-01],ARef=[AI95-00409-01]}
@ChgAdded{Version=[2],Text=[The calling convention for an
anonymous access-to-subprogram parameter
or anonymous access-to-subprogram result is @i<protected> if the reserved
word @key{protected} appears in its definition and otherwise is the convention
of the subprogram that contains the parameter.]}
@begin{Ramification}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[The calling convention for other
  anonymous access-to-subprogram types is Ada.]}
@end{Ramification}

@ChgRef{Version=[1],Kind=[Added],Ref=[8652/0011],ARef=[AI95-00117-01]}
@Chg{Version=[1],New=[@Redundant[If not specified above as Intrinsic, the calling convention for any
inherited or overriding dispatching operation of a tagged type is that of the
corresponding subprogram of the parent type.] The default calling convention
for a new dispatching operation of a tagged type is the convention of the type.],
Old=[]}
@begin{Reason}
@ChgRef{Version=[1],Kind=[Added]}
@ChgAdded{Version=[1],Text=[The first rule is officially stated in
@RefSecNum(Dispatching Operations of Tagged Types). The second is intended
to make interfacing to foreign OOP languages easier, by making the default
be that the type and operations all have the same convention.]}
@end{Reason}
@end{Itemize}

Of these four conventions, only Ada and Intrinsic are
allowed as a @SynI{convention_}@nt{identifier}
in a @nt{pragma} Convention, Import, or Export.
@begin{Discussion}
  The names of the @i{protected} and @i{entry} calling conventions
  cannot be used in the interfacing pragmas.
  Note that @key[protected] and @key[entry] are reserved words.
@end{Discussion}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00409-01]}
@Defn{type conformance}
@Defn2{Term=[profile],Sec=(type conformant)}
Two profiles
are @i{type conformant} if they have the same number of parameters,
and both have a result if either does, and corresponding
parameter and result types are the same,
or, for access parameters@Chg{Version=[2],New=[ or access results],Old=[]},
corresponding designated types are the same@Chg{Version=[2],New=[, or
corresponding designated profiles are type conformant],Old=[]}.
@IndexSee{Term=[type profile],See=(profile, type conformant)}
@begin{Discussion}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00409-01]}
For @Chg{Version=[2],New=[anonymous access-to-object],Old=[access]}
parameters, the designated types have to be the same for type
conformance, not the access types,
since in general each access parameter has its own anonymous access
type, created when the subprogram is called.
Of course, corresponding parameters have to be either both access
parameters or both not access parameters.

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00409-01]}
@ChgAdded{Version=[2],Text=[Similarly, for anonymous access-to-subprogram
parameters, the designated profiles of the types, not the types themselves,
have to be conformant.]}
@end{Discussion}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02],ARef=[AI95-00409-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0142-4]}
@ChgAdded{Version=[3],Type=[Leading],Text=[]}@Comment{Dummy for conditional leading.}
@Defn{mode conformance}
@Defn2{Term=[profile],Sec=(mode conformant)}
Two profiles are @i{mode conformant} if@Chg{Version=[3],New=[:],Old=[ they are
type-conformant, and
corresponding parameters have identical
modes, and, for access
parameters@Chg{Version=[2],New=[ or access result types],Old=[]}, the
designated subtypes statically match@Chg{Version=[2],New=[, or the
designated profiles are subtype conformant.],Old=[]}
@PDefn2{Term=[statically matching],Sec=(required)}]}

@begin{Itemize}
@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0142-4]}
@ChgAdded{Version=[3],Text=[they are type conformant;]}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0142-4]}
@ChgAdded{Version=[3],Text=[corresponding parameters have identical modes and
both or neither are explicitly aliased parameters; and]}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0207-1]}
@ChgAdded{Version=[3],Text=[for corresponding access parameters and any access
result type, the designated subtypes statically match and either both or neither
are access-to-constant, or the designated profiles are subtype conformant.
@PDefn2{Term=[statically matching],Sec=(required)}]}
@end{Itemize}

@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0239-1]}
@Defn{subtype conformance}
@Defn2{Term=[profile],Sec=(subtype conformant)}
Two profiles are @i{subtype conformant} if they are
@Chg{Version=[3],New=[mode conformant],Old=[mode-conformant]},
corresponding subtypes of the profile statically match,
and the associated calling conventions are the same.
The profile of a generic formal subprogram is not
@Chg{Version=[3],New=[subtype conformant],Old=[subtype-conformant]}
with any other profile.
@PDefn2{Term=[statically matching],Sec=(required)}

@begin{Ramification}
@PDefn{generic contract issue}
@end{Ramification}

@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0134-1]}
@ChgAdded{Version=[3],Type=[Leading],Text=[]}@Comment{Dummy for conditional leading.}
@Defn2{Term=[full conformance], Sec=(for profiles)}
@Defn2{Term=[profile],Sec=(fully conformant)}
Two profiles are @i{fully conformant} if they
are @Chg{Version=[3],New=[subtype conformant],Old=[subtype-conformant]},
@Chg{Version=[3],New=[if they have
access-to-subprogram results whose designated profiles are fully
conformant,],Old=[]}and corresponding parameters have@Chg{Version=[3],New=[:],
Old=[ the same names and have @nt<default_expression>s
that are fully conformant with one another.]}
@begin{Itemize}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[the same names; and]}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0046-1]}
@ChgAdded{Version=[3],Text=[both or neither have @nt{null_exclusion}s; and]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[neither have @nt{default_expression}s, or they both
have @nt{default_expression}s that are fully conformant with one another; and]}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0134-1]}
@ChgAdded{Version=[3],Text=[for access-to-subprogram parameters, the designated
profiles are fully conformant.]}
@end{Itemize}
@begin{Ramification}
Full conformance requires subtype conformance,
which requires the same calling conventions.
However, the calling convention of the declaration and body of a
subprogram or entry are always the same by definition.
@end{Ramification}
@begin{Reason}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0046-1]}
@ChgAdded{Version=[3],Text=[The part about @nt{null_exclusion}s is
  necessary to prevent controlling parameters from having different
  exclusions, as such a parameter is defined to exclude
  null whether or not an exclusion is given.]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0134-1]}
@ChgAdded{Version=[3],Text=[The parts about access-to-subprogram parameters
  and results is necessary to prevent such types from having different
  @nt{default_expression}s in the specification and body of a subprogram.
  If that was allowed, it would be undefined which @nt{default_expression}
  was used in a call of an access-to-subprogram parameter.]}
@end{Reason}

@leading@Defn2{Term=[full conformance], Sec=(for expressions)}
Two expressions are @i(fully conformant) if,
@Redundant[after replacing each use of an operator with the equivalent
@nt{function_call}:]
@begin{Itemize}
each constituent construct of one corresponds to an instance of the
same syntactic category in the other,
except that an expanded name may correspond
to a @nt{direct_name}
(or @nt{character_literal})
or to a different expanded name in the other; and

each @nt{direct_name}, @nt{character_literal}, and @nt{selector_name}
that is not part of the @nt{prefix} of an expanded name in one
denotes the same declaration as the corresponding
@nt{direct_name}, @nt{character_literal},
or @nt{selector_name} in the other; and
@begin{Ramification}
Note that it doesn't say @lquotes@;respectively@rquotes@;
because a @nt{direct_name} can correspond to a @nt{selector_name},
and vice-versa, by the previous bullet.
This rule allows the @nt{prefix} of an expanded name to be removed,
or replaced with a different @nt{prefix} that denotes a renaming of the
same entity.
However, it does not allow a @nt{direct_name} or @nt{selector_name} to
be replaced with one denoting a distinct renaming
(except for @nt{direct_name}s and @nt{selector_name}s in @nt{prefix}es
of expanded names).
Note that calls using operator notation
are equivalent to calls using prefix notation.

@leading@keepnext@;Given the following declarations:
@begin{Example}
@key[package] A @key[is]
    @key[function] F(X : Integer := 1) @key[return] Boolean;
@key[end] A;

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0005-1]}
@key[with] A;
@key[package] B @key[is]
    @key[package] A_View @key[renames] A;
    @key[function] F_View(X : Integer := 9999) @key[return] Boolean @key[renames] @Chg{Version=[3],New=[A.],Old=[]}F;
@key[end] B;

@key[with] A, B; @key[use] A, B;
@key[procedure] Main @key[is] ...
@end{Example}

Within Main, the expressions @lquotes@;F@rquotes@;, @lquotes@;A.F@rquotes@;, @lquotes@;B.A_View.F@rquotes@;,
and @lquotes@;A_View.F@rquotes@; are all fully conformant with one another.
However, @lquotes@;F@rquotes@; and @lquotes@;F_View@rquotes@; are not fully conformant.
If they were, it would be bad news, since the two denoted views have
different @nt{default_expression}s.
@end{Ramification}

@ChgRef{Version=[1],Kind=[Added],Ref=[8652/0018],ARef=[AI95-00175-01]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0092-1]}
@ChgAdded{Version=[1],Text=[each @nt{attribute_designator} in one
@Chg{Version=[3],New=[is],Old=[must be]} the same as the
corresponding @nt{attribute_designator} in the other; and]}

each @nt{primary} that is a literal in one
has the same value as the corresponding literal in the other.
@begin{Ramification}
The literals may be written differently.
@end{Ramification}
@end{Itemize}
@begin{Ramification}
Note that the above definition makes full conformance a transitive
relation.
@end{Ramification}

@Defn2{Term=[full conformance], Sec=(for @nt{known_discriminant_part}s)}
Two @nt{known_discriminant_part}s are @i(fully conformant) if they have
the same number of discriminants, and
discriminants in the same positions
have the same names, statically matching subtypes,
and @nt{default_expression}s that are fully conformant with
one another.
@PDefn2{Term=[statically matching],Sec=(required)}

@Defn2{Term=[full conformance], Sec=(for @nt{discrete_subtype_definition}s)}
Two @nt<discrete_subtype_definition>s are @i(fully conformant) if they
are both @nt<subtype_indication>s or are both @nt<range>s,
the @nt<subtype_mark>s (if any) denote the same subtype, and
the corresponding @nt<simple_expression>s of the @nt<range>s (if any)
fully conform.
@begin{Ramification}
  In the @nt{subtype_indication} case, any ranges have to @i{be}
  corresponding; that is, two @nt{subtype_indication}s cannot conform
  unless both or neither has a @nt{range}.
@end{Ramification}
@begin{Discussion}
  This definition is used in @RefSec(Entries and Accept Statements)
  for the conformance required between the @nt<discrete_subtype_definition>s
  of an @nt<entry_declaration> for a family of entries and the
  corresponding @nt<entry_index_specification> of the @nt<entry_body>.
@end{Discussion}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00345-01],ARef=[AI95-00397-01]}
@ChgAdded{Version=[2],Text=[@Defn{prefixed view profile}
The @i<prefixed view profile> of a subprogram is the profile obtained by
omitting the first parameter of that subprogram. There is no prefixed view
profile for a parameterless subprogram. For the purposes of defining subtype
and mode conformance, the convention of a prefixed view profile is considered
to match that of either an entry or a protected operation.]}

@begin{Discussion}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[This definition is used to define how
  primitive subprograms of interfaces match operations in task and
  protected type definitions (see @RefSecNum{Task Units and Task Objects} and
  @RefSecNum{Protected Units and Protected Objects}).]}
@end{Discussion}
@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[The weird rule about conventions is pretty much
  required for synchronized interfaces to make any sense. There will be
  wrappers all over the place for interfaces anyway. Of course, this doesn't
  imply that entries have the same convention as protected operations.]}
@end{Reason}
@end{StaticSem}

@begin{ImplPerm}

An implementation may declare an operator declared in a language-defined
library unit to be intrinsic.

@end{ImplPerm}

@begin{Extend83}
@Defn{extensions to Ada 83}
The rules for full conformance are relaxed @em they are now based on
the structure of constructs, rather than the sequence of lexical
elements. This implies, for example, that "(X, Y: T)"
conforms fully with "(X: T; Y: T)",
and "(X: T)" conforms fully with "(X: @key[in] T)".
@end{Extend83}

@begin{DiffWord95}
  @ChgRef{Version=[2],Kind=[AddedNormal],Ref=[8652/0011],ARef=[AI95-00117-01]}
  @ChgAdded{Version=[2],Text=[@b<Corrigendum:> Clarified that the default
  convention is Ada. Also clarified that the convention of a primitive
  operation of a tagged type is the same as that of the type.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],Ref=[8652/0018],ARef=[AI95-00175-01]}
  @ChgAdded{Version=[2],Text=[@b<Corrigendum:> Added wording to ensure that two
  attributes conform only if they have the same @nt{attribute_designator}.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00252-01],ARef=[AI95-00254-01],ARef=[AI95-00407-01]}
  @ChgAdded{Version=[2],Text=[Defined the calling convention for anonymous
  access-to-subprogram types and for prefixed views of subprograms (see
  @RefSecNum{Selected Components}).]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[Defined the conformance of access result types
  (see @RefSecNum{Subprogram Declarations}).]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00345-01],ARef=[AI95-00397-01]}
  @ChgAdded{Version=[2],Text=[Defined the prefixed view profile of subprograms
  for later use.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00409-01]}
  @ChgAdded{Version=[2],Text=[Defined the conformance of anonymous
  access-to-subprogram parameters.]}
@end{DiffWord95}

@begin{Incompatible2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0046-1]}
  @ChgAdded{Version=[3],Text=[@Defn{incompatibilities with Ada 2005}@b<Correction:> Now require
  @nt{null_exclusion}s to match for full conformance. While this is
  technically incompatible with Ada 2005 as defined by Amendment 1,
  it is a new Ada 2005 feature and it is unlikely that users have
  been intentionally taking advantage of the ability to write mismatching
  exclusions. In any case, it is easy to fix: add a @nt{null_exclusion}
  where needed for conformance.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0134-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Now require
  full conformance of anonynous access-to-subprogram parameters and results
  for full conformance. This is necessary so that there is no confusion about
  the default expression that is used for a call. While this is technically
  incompatible with Ada 2005 as defined by Amendment 1, it is a new Ada 2005
  feature and it is unlikely that users have been intentionally taking advantage
  and writing different default expressions. In any case, it is
  easy to fix: change any default expressions that don't conform so that they
  do conform.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0207-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Now include
  the presence or absence of @key[constant] in access parameters to be
  considered when checking mode conformance. This is necessary to prevent
  modification of constants. While this is technically incompatible with
  Ada 2005 as defined by Amendment 1, it is a new Ada 2005 feature and it
  is unlikely that users have been intentionally taking advantage and writing
  mismatching access types.]}
@end{Incompatible2005}

@begin{Diffword2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0142-4]}
  @ChgAdded{Version=[3],Text=[Explicitly aliased parameters are included
  as part of mode conformance (since it affects the parameter passing
  mechanism).]}
@end{Diffword2005}


@LabeledSubClause{Inline Expansion of Subprograms}

@begin{Intro}
@Redundant[Subprograms may be expanded in line at the call site.]
@end{Intro}

@begin{Syntax}
@begin{SyntaxText}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
@ChgDeleted{Version=[3],Type=[Leading],KeepNext=[T],Text=[@PDefn2{Term=[program unit pragma], Sec=(Inline)}
@PDefn2{Term=[pragma, program unit], Sec=(Inline)}
The form of a @nt{pragma} Inline,
which is a program unit pragma (see @RefSecNum{Pragmas and Program Units}),
is as follows:]}
@end{SyntaxText}

@ChgRef{Version=[3],Kind=[Deleted]}
@ChgDeleted{Version=[3],Text=[@PragmaSyn`@key{pragma} @prag(Inline)(@Syn2{name} {, @Syn2{name}});']}
@end{Syntax}

@begin{Legality}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
@ChgDeleted{Version=[3],Text=[The @nt{pragma} shall apply to one or more
callable entities or generic subprograms.]}
@end{Legality}

@begin{StaticSem}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0229-1]}
@ChgAdded{Version=[3],Type=[Leading],Text=[]}@ChgNote{Conditional leading}
@Chg{Version=[3],New=[For],Old=[If a @nt{pragma} Inline applies to]}
a callable entity@Chg{Version=[3],New=[ or],Old=[,
this indicates that inline expansion is desired for all calls
to that entity.
If a @nt{pragma} Inline applies to]} a generic subprogram,
@Chg{Version=[3],New=[the following language-defined
representation aspect may be specified:],Old=[this indicates that
inline expansion is desired for all calls to all instances of that
generic subprogram.]}

@begin{Description}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[Inline@\The type of aspect Inline is Boolean. When
aspect Inline is True for a callable entity, inline expansion is desired for all
calls to that entity. When aspect Inline is True for a generic subprogram,
inline expansion is desired for all calls to all instances of that generic
subprogram.]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],NoPrefix=[T],Text=[If directly specified, the
@nt{aspect_definition} shall be a static expression.
@Redundant[This aspect is never inherited;] if not directly specified,
the aspect is False.]}
@end{Description}


@begin{Ramification}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
@ChgDeleted{Version=[3],Type=[Leading],Text=[Note that inline expansion is
desired no matter what name is used in the call. This allows one to request
inlining for only one of several overloaded subprograms as follows:]}
@begin{Example}
@ChgRef{Version=[3],Kind=[Deleted]}
@ChgDeleted{Version=[3],Text=[@key[package] IO @key[is]
   @key[procedure] Put(X : @key[in] Integer);
   @key[procedure] Put(X : @key[in] String);
   @key[procedure] Put(X : @key[in] Character);
@key[private]
   @key[procedure] Character_Put(X : @key[in] Character) @key[renames] Put;
   @key[pragma] Inline(Character_Put);
@key[end] IO;]}

@ChgRef{Version=[3],Kind=[Deleted]}
@ChgDeleted{Version=[3],Text=[@key[with] IO; @key[use] IO;
@key[procedure] Main @key[is]
   I : Integer;
   C : Character;
@key[begin]
   ...
   Put(C); --@Examcom{ Inline expansion is desired.}
   Put(I); --@Examcom{ Inline expansion is NOT desired.}
@key[end] Main;]}
@end{Example}
@end{Ramification}
@begin{Ramification}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0229-1]}
The meaning of a subprogram can be changed by @Chg{Version=[3],New=[inline
expansion as requested by aspect],Old=[a @nt{pragma}]} Inline only
in the presence of failing checks
(see @RefSecNum{Exceptions and Optimization}).
@end{Ramification}
@end{StaticSem}

@begin{ImplPerm}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0229-1]}
For each call,
an implementation is free to follow or to ignore the recommendation
@Chg{Version=[3],New=[determined],Old=[expressed]} by the
@Chg{Version=[3],New=[Inline aspect],Old=[@nt{pragma}]}.
@begin{Ramification}
Note, in particular, that the recommendation
cannot always be followed for a recursive call,
and is often infeasible for entries.
Note also that the implementation can inline calls even
when no such desire was expressed @Chg{Version=[3],New=[via the
Inline aspect],Old=[by a pragma]},
so long as the semantics of the program remains unchanged.
@end{Ramification}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00309-01]}
@ChgRef{Version=[3],Kind=[DeletedAdded],ARef=[AI05-0229-1]}
@ChgDeleted{Version=[3],Text=[@Chg{Version=[2],New=[An implementation may allow
a @nt{pragma} Inline that has an argument which is a @nt{direct_name} denoting a
@nt{subprogram_body} of the same @nt{declarative_part}.],Old=[]}]}
@begin{Reason}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgRef{Version=[3],Kind=[Deleted]}
@ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[],Old=[This is allowed for
Ada 83 compatibility. This is only a permission as this usage is considered
obsolescent.]}]}
@end{Reason}
@begin{Discussion}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgRef{Version=[3],Kind=[Deleted]}
@ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[],Old=[We only need to allow
this in @nt{declarative_part}s, because a body is only allowed in another body,
and these all have @nt{declarative_part}s.]}]}
@end{Discussion}
@end{ImplPerm}

@begin{Notes}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
@ChgDeleted{Version=[3],Text=[The @nt{name} in a @nt{pragma} Inline can denote
more than one entity in the case of overloading.
Such a @nt{pragma} applies to all of the denoted entities.]}
@end{Notes}

@begin{Incompatible83}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00309-01]}
  @ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
  @ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[],Old=[@Defn{incompatibilities with Ada 83}
  A pragma Inline cannot refer to a @nt{subprogram_body} outside of that
  body. The pragma can be given inside of the subprogram body. Ada 2005
  adds an @ImplPermName to allow this usage for compatibility (and
  Ada 95 implementations also can use this permission), but
  implementations do not have to allow such @nt{pragma}s.]}]}
@end{Incompatible83}

@begin{Extend83}
  @ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
  @ChgDeleted{Version=[3],Text=[@Defn{extensions to Ada 83}
  A @nt{pragma} Inline is allowed inside a @nt{subprogram_body} if there
  is no corresponding @nt{subprogram_declaration}.
  This is for uniformity with other program unit pragmas.]}
@end{Extend83}

@begin{Extend95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00309-01]}
  @ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
  @ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[],Old=[@Defn{extensions to Ada 95}
  @b[Amendment Correction:] Implementations are allowed to let @nt{Pragma}
  Inline apply to a @nt{subprogram_body}.]}]}
@end{Extend95}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0229-1]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}
  Aspect Inline is new; @nt{pragma} Inline is now obsolescent.]}
@end{Extend2005}


@Comment{@RMNewPage@Comment{For printed RM Ada 2005 only} - Now Ada 2012}
@LabeledClause{Subprogram Calls}

@begin{Intro}
@Defn{subprogram call}
A @i{subprogram call} is either a @nt{procedure_call_statement}
or a @nt{function_call};
@Redundant[it invokes the execution of the @nt{subprogram_body}.
The call specifies the association of the actual parameters, if any,
with formal parameters of the subprogram.]
@end{Intro}

@begin{Syntax}
@Syn{lhs=<procedure_call_statement>,rhs="
    @SynI{procedure_}@Syn2{name};
  | @SynI{procedure_}@Syn2{prefix} @Syn2{actual_parameter_part};"}


@Syn{lhs=<function_call>,rhs="
    @SynI{function_}@Syn2{name}
  | @SynI{function_}@Syn2{prefix} @Syn2{actual_parameter_part}"}

@begin{Honest}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0005-1]}
@ChgAdded{Version=[3],Text=[For the purpose of non-syntax rules,
infix operator calls are considered @nt{function_call}s.
See @RefSecNum{Overloading of Operators}.]}
@end{Honest}

@Syn{lhs=<actual_parameter_part>,rhs="
    (@Syn2{parameter_association} {, @Syn2{parameter_association}})"}

@Syn{lhs=<parameter_association>,rhs="
   [@SynI{formal_parameter_}@Syn2{selector_name} =>] @Syn2{explicit_actual_parameter}"}

@Syn{lhs=<explicit_actual_parameter>,rhs="@Syn2{expression} | @SynI{variable_}@Syn2{name}"}

@begin{SyntaxText}
@Defn{named association}
@Defn{positional association}
A @nt{parameter_association} is @i{named} or @i{positional}
according to whether or not the
@SynI{formal_@!parameter_}@!@nt{selector_@!name} is specified.
Any positional associations shall precede any named associations.
Named associations are not allowed if the @nt{prefix} in
a subprogram call is an @nt{attribute_@!reference}.
@begin{Ramification}
This means that the formal parameter names used in
describing predefined attributes are
to aid presentation of their semantics, but are not intended
for use in actual calls.
@end{Ramification}
@end{SyntaxText}
@end{Syntax}

@begin{Resolution}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00310-01]}
The @nt{name} or @nt{prefix} given in a @nt{procedure_call_statement}
shall resolve to denote
a callable entity that is a procedure, or an entry renamed
as (viewed as) a procedure.
The @nt{name} or @nt{prefix} given in a @nt{function_call}
shall resolve to denote
a callable entity that is a
function.@Chg{Version=[2],New=[ The @nt{name} or @nt{prefix} shall not
resolve to denote an abstract subprogram unless it is also a
dispatching subprogram.],Old=[]}
@Redundant[When there is an @nt<actual_@!parameter_@!part>, the @nt<prefix>
can be an @nt<implicit_@!dereference> of an access-to-subprogram
value.]
@begin{Discussion}
@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00310-01]}
@ChgAdded{Version=[2],Text=[This rule is talking about dispatching operations
(which is a static concept) and not about dispatching calls (which is a
dynamic concept).]}
@end{Discussion}
@begin{Ramification}
The function can be an operator,
enumeration literal, attribute that is a function, etc.
@end{Ramification}

A subprogram call shall contain at most one association for each
formal parameter.
Each formal parameter without an association shall have a
@nt{default_expression} (in the profile of the view denoted
by the @nt<name> or @nt<prefix>).
@Redundant[This rule is an overloading rule
(see @RefSecNum{The Context of Overload Resolution}).]
@begin{TheProof}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0240-1]}
  @ChgAdded{Version=[3],Text=[All @ResolutionTitle are overloading rules,
  see @RefSecNum{The Context of Overload Resolution}.]}
@end{TheProof}
@end{Resolution}
@begin{RunTime}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00345-01]}
@PDefn2{Term=[execution], Sec=(subprogram call)}
For the execution of a subprogram call,
the @nt{name} or @nt{prefix} of the call is evaluated,
and each @nt{parameter_@!association} is evaluated
(see @RefSecNum{Parameter Associations}).
If a @nt{default_@!expression} is used,
an implicit @nt{parameter_@!association} is assumed for this rule.
These evaluations are done in an arbitrary order.
The @nt{subprogram_@!body} is then executed@Chg{Version=[2],New=[, or a call
on an entry or protected subprogram is performed (see
@RefSecNum{Dispatching Operations of Tagged Types})],Old=[]}.
Finally, if the subprogram completes normally, then after it is left,
any necessary assigning back of formal to actual parameters occurs
(see @RefSecNum{Parameter Associations}).@PDefn2{Term=[arbitrary order],Sec=[allowed]}

@begin{Discussion}
  The implicit association for a default is only for this run-time rule.
  At compile time, the visibility rules are applied to the default at
  the place where it occurs, not at the place of a call.
@end{Discussion}
@begin{Honest}
  If the subprogram is inherited, see @RefSec{Derived Types and Classes}.

  If the subprogram is protected, see @RefSec{Protected Subprograms and Protected Actions}.

  If the subprogram is really a renaming of an entry, see @RefSec{Entry Calls}.

  @ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00345-01]}
  @ChgAdded{Version=[2],Text=[If the subprogram is implemented by an entry or
  protected subprogram, it will be treated as a dispatching call to the
  corresponding entry (see @RefSec{Entry Calls}) or protected subprogram (see
  @RefSec{Protected Subprograms and Protected Actions}).]}

  @ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00348-01]}
  Normally, the @nt{subprogram_body} that is executed by the above rule
  is the one for the subprogram being called.
  For an enumeration literal,
  implicitly declared (but noninherited) subprogram,
  @Chg{Version=[2],New=[null procedure, ],Old=[]}or an attribute that is
  a subprogram, an implicit body is assumed.
  For a dispatching call,
  @RefSec{Dispatching Operations of Tagged Types}
  defines which @nt{subprogram_body} is executed.
@end{Honest}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00407-01]}
@ChgAdded{Version=[2],Text=[If the @nt{name} or @nt{prefix} of a subprogram
call denotes a prefixed view (see @RefSecNum{Selected Components}), the
subprogram call is equivalent to a call on the underlying subprogram, with the
first actual parameter being provided by the @nt{prefix} of the prefixed view
(or the Access attribute of this @nt{prefix} if the first formal parameter is
an access parameter), and the remaining actual parameters given by the
@nt{actual_parameter_part}, if any.]}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
The exception Program_Error is raised at the point of a
@nt{function_call} if the function
completes normally without executing a
@Chg{Version=[2],New=[return statement],Old=[@nt{return_@!statement}]}.
@begin{Discussion}
We are committing to raising the exception at the point
of call, for uniformity @em see AI83-00152.
This happens after the function is left, of course.

Note that there is no name for suppressing this check,
since the check imposes no time overhead and minimal
space overhead (since it can usually be statically eliminated
as dead code).
@end{Discussion}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00231-01]}
A @nt{function_call} denotes a constant, as defined in
@RefSecNum{Return Statements}; the nominal subtype of the constant is
given by the @Chg{Version=[2],New=[nominal],Old=[result]} subtype of the
function@Chg{Version=[2],New=[ result],Old=[]}.
@PDefn2{Term=[nominal subtype], Sec=(of the result of a @nt<function_call>)}
@PDefn2{Term=[constant], Sec=(result of a @nt<function_call>)}
@end{RunTime}

@begin{Examples}
@leading@keepnext@i{Examples of procedure calls:}
@begin{Example}
Traverse_Tree;                                               --@RI{  see @RefSecNum{Subprogram Declarations}}
Print_Header(128, Title, True);                              --@RI{  see @RefSecNum{Subprogram Declarations}}

Switch(From => X, To => Next);                               --@RI{  see @RefSecNum{Subprogram Declarations}}
Print_Header(128, Header => Title, Center => True);          --@RI{  see @RefSecNum{Subprogram Declarations}}
Print_Header(Header => Title, Center => True, Pages => 128); --@RI{  see @RefSecNum{Subprogram Declarations}}
@end{Example}

@begin{WideAbove}
@leading@keepnext@i{Examples of function calls:}
@end{WideAbove}
@begin{Example}
Dot_Product(U, V)   --@RI{  see @RefSecNum{Subprogram Declarations} and @RefSecNum{Subprogram Bodies}}
Clock               --@RI{  see @RefSecNum{Delay Statements, Duration, and Time}}
F.@key[all]               --@RI{  presuming F is of an access-to-subprogram type @em see @RefSecNum{Access Types}}
@end{Example}

@begin{WideAbove}
@leading@keepnext@i{Examples of procedures with default expressions:}
@end{WideAbove}
@begin{Example}
@key[procedure] Activate(Process : @key[in] Process_Name;
                   After   : @key[in] Process_Name := No_Process;
                   Wait    : @key[in] Duration := 0.0;
                   Prior   : @key[in] Boolean := False);

@key[procedure] Pair(Left, Right : @key[in] Person_Name := @key[new] Person);   --@RI{  see @RefSecNum{Incomplete Type Declarations}}
@end{Example}

@begin{WideAbove}
@leading@keepnext@i{Examples of their calls:}
@end{WideAbove}
@begin{Example}
Activate(X);
Activate(X, After => Y);
Activate(X, Wait => 60.0, Prior => True);
Activate(X, Y, 10.0, False);

Pair;
Pair(Left => @key[new] Person, Right => @key[new] Person);
@end{Example}
@end{Examples}

@begin{Notes}
If a @nt{default_expression} is used for two or more parameters in a
multiple @nt{parameter_@!specification}, the @nt{default_@!expression} is
evaluated once for each omitted parameter. Hence in the above
examples, the two calls of Pair are equivalent.
@end{Notes}

@begin{Examples}
@leading@keepnext@i{Examples of overloaded subprograms:}
@begin{Example}
@key[procedure] Put(X : @key[in] Integer);
@key[procedure] Put(X : @key[in] String);

@key[procedure] Set(Tint   : @key[in] Color);
@key[procedure] Set(Signal : @key[in] Light);
@end{Example}

@begin{WideAbove}
@leading@keepnext@i{Examples of their calls:}
@end{WideAbove}
@begin{Example}
Put(28);
Put("no possible ambiguity here");

Set(Tint   => Red);
Set(Signal => Red);
Set(Color'(Red));

--@RI{  Set(Red) would be ambiguous since Red may}
--@RI{  denote a value either of type Color or of type Light}
@end{Example}
@end{Examples}

@begin{DiffWord83}
We have gotten rid of parameters @lquotes@;of the form of a type conversion@rquotes@;
(see RM83-6.4.1(3)).
The new view semantics of @nt{type_conversion}s allows us to use
normal @nt{type_conversion}s instead.

We have moved wording about run-time semantics of parameter associations
to @RefSecNum{Parameter Associations}.

We have moved wording about raising Program_Error for a function
that falls off the end to here from RM83-6.5.
@end{DiffWord83}

@begin{Extend95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00310-01]}
  @ChgAdded{Version=[2],Text=[@Defn{extensions to Ada 95}
  Nondispatching abstract operations are no longer considered when
  resolving a subprogram call. That makes it possible to use @key{abstract}
  to @lquotes@;undefine@rquotes@; a predefined operation for an untagged type.
  That's especially helpful when defining custom arithmetic packages.]}
@end{Extend95}

@begin{DiffWord95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00231-01]}
  @ChgAdded{Version=[2],Text=[Changed the definition of the nominal subtype
  of a @nt{function_call} to use the nominal subtype wording of
  @RefSecNum{Subprogram Declarations}, to take into account
  @nt{null_exclusion}s and access result types.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00345-01]}
  @ChgAdded{Version=[2],Text=[Added wording to clarify that the meaning of
  a call on a subprogram @lquotes@;implemented by@rquotes an entry or
  protected operation is defined by
  @RefSecNum{Dispatching Operations of Tagged Types}.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00407-01]}
  @ChgAdded{Version=[2],Text=[Defined the meaning of a call on a prefixed
  view of a subprogram (see @RefSecNum{Selected Components}).]}
@end{DiffWord95}


@LabeledSubClause{Parameter Associations}

@begin{Intro}
@Redundant[@Defn{parameter passing}
A parameter association defines the association between an
actual parameter and a formal parameter.]
@end{Intro}

@begin{MetaRules}
The parameter passing rules for @b(out) parameters
are designed to ensure that the parts of a type that have
implicit initial values (see @RefSecNum{Object Declarations})
don't become @lquotes@;de-initialized@rquotes@; by
being passed as an @b(out) parameter.

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0142-4]}
@ChgAdded{Version=[3],Text=[For explicitly aliased parameters of functions, we
will ensure at the call site that a part of the parameter can be returned as
part of the function result without creating a dangling pointer. We do this with
accessibility checks at the call site that all actual objects of explicitly
aliased parameters live at least as long as the function result; then we can
allow them to be returned as access discriminants or anonymous access results,
as those have the master of the function result.]}
@end{MetaRules}

@begin{Resolution}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0118-1]}
The @SynI{formal_parameter_}@nt{selector_name} of
a@Chg{Version=[3],New=[ named],Old=[]}
@nt{parameter_@!association} shall resolve to denote a
@nt{parameter_@!specification} of the view being called@Chg{Version=[3],New=[;
@Defn{named association}@Defn{positional association}@Defn{named parameter association}@Defn{positional parameter association}this
is the formal parameter of the association. The formal parameter for a
positional @nt{parameter_@!association} is the parameter with the corresponding
position in the formal part of the view being called],Old=[]}.

@begin{Honest}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0118-1]}
  @ChgAdded{Version=[3],Text=[For positional parameters, the
  @ldquote@;corresponding position@rdquote is calculated after any
  transformation of prefixed views.]}
@end{Honest}

@Defn2{Term=[actual parameter], Sec=(for a formal parameter)}
The @i(actual parameter) is either the @nt<explicit_actual_parameter>
given in a @nt<parameter_association> for a given
formal parameter, or the corresponding @nt<default_expression>
if no @nt<parameter_association> is given for the formal parameter.
@Defn2{Term=[expected type], Sec=(actual parameter)}
The expected type for an actual parameter is the
type of the corresponding formal parameter.
@begin{Honest}
  The corresponding @nt<default_expression> is the one of the
  corresponding formal parameter
  in the profile of the view denoted by the @nt<name> or
  @nt<prefix> of the call.
@end{Honest}

If the mode is @key(in),
the actual is interpreted as an @nt{expression};
otherwise, the actual is interpreted only as a @nt{name}, if possible.
@begin{Ramification}
  This formally resolves the ambiguity present in the syntax rule
  for @nt<explicit_actual_parameter>. Note that we don't actually require
  that the actual be a @nt<name> if the mode is not @key(in);
  we do that below.
@end{Ramification}
@end{Resolution}

@begin{Legality}
If the mode is @key(in out) or @key(out),
the actual shall be a @nt<name> that denotes a variable.
@begin{Discussion}
  We no longer need @lquotes@;or a
  @nt{type_conversion} whose argument is the @nt{name} of a variable,@rquotes@;
  because a @nt{type_conversion} is now a @nt{name}, and a
  @nt{type_conversion} of a variable is a variable.
@end{Discussion}
@begin{Reason}
  @leading@;The requirement that the actual be a (variable) @nt<name> is not
  an overload resolution rule, since
  we don't want the difference between @nt<expression> and
  @nt{name} to be used to resolve overloading.
  For example:
  @begin{Example}
procedure Print(X : @key[in] Integer; Y : @key[in] Boolean := True);
procedure Print(Z : @key[in out] Integer);
. . .
Print(3); --@RI{ Ambiguous!}
  @end{Example}

  The above call to Print is ambiguous even though the call is
  not compatible with the second Print which requires an actual
  that is a (variable) @nt<name> (@lquotes@;3@rquotes@; is an @nt<expression>, not
  a @nt<name>). This requirement is a legality rule, so overload
  resolution fails before it is considered, meaning that the call
  is ambiguous.
@end{Reason}

@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0102-1],ARef=[AI05-0142-4]}
@leading@;@Chg{Version=[3],New=[If the formal parameter is an explicitly aliased
parameter, the type of the actual parameter shall be tagged or the actual
parameter shall be an aliased view of an object. Further, if the formal
parameter subtype @i{F} is untagged:],
Old=[The type of the actual parameter associated with an access parameter
shall be convertible (see @RefSecNum{Type Conversions})
to its anonymous access type.
@PDefn2{Term=[convertible],Sec=(required)}]}

@begin{Itemize}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[the subtype @i{F} shall statically match the nominal
subtype of the actual object; or]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[the subtype @i{F} shall be unconstrained, discriminated
in its full view, and unconstrained in any partial view.]}
@end{Itemize}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Tagged objects (and tagged @nt{aggregate}s for @key[in]
  parameters) do not need to be aliased. This matches the behavior of unaliased
  formal parameters of tagged types, which allow 'Access to be taken of the
  formal parameter regardless of the form of the actual parameter.]}
@end{Ramification}

@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[We need the subtype check on untagged actual
  parameters so that the requirements of 'Access are not lost. 'Access makes its
  checks against the nominal subtype of its prefix, and parameter passing can
  change that subtype. But we don't want this parameter passing to change the
  objects that would be allowed as the prefix of 'Access. This is particularly
  important for arrays, where we don't want to require any additional
  implementation burden.]}
@end{Reason}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0142-4],ARef=[AI05-0234-1]}
@ChgAdded{Version=[3],Text=[In a function call, the accessibility level of the
actual object for each explicitly aliased parameter shall not be statically
deeper than accessibility level of the master of the call
(see @RefSecNum{Operations of Access Types}).]}

@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Since explicitly aliased parameters are either
  tagged or required to be objects, there is always an object (possibly
  anonymous) to talk about. This is discussing the static accessibility level of
  the actual object; it does not depend on any runtime information (for instance
  when the actual object is a formal parameter to another call).]}
@end{Discussion}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This accessibility check (and its dynamic cousin
  as well) can only fail if the function call is used to directly initialize a
  built-in-place object with a master different than that enclosing the call.
  The only place all of those conditions exist is in the initializer of an
  @nt{allocator}; in all other cases this check will always pass.]}
@end{Ramification}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0144-2]}
@ChgAdded{Version=[3],Type=[Leading],Text=[Two @nt{name}s are
@i{known to denote the same object} if:@Defn{known to denote the same object}]}

@begin{Itemize}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[both @nt{name}s statically denote the same
stand-alone object or parameter; or]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[both @nt{name}s are @nt{selected_component}s,
their @nt{prefix}es are known to denote the same object, and their
@nt{selector_name}s denote the same component; or]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[both @nt{name}s are dereferences (implicit or
explicit) and the dereferenced @nt{name}s are known to denote the same object;
or]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[both @nt{name}s are @nt{indexed_component}s, their
@nt{prefix}es are known to denote the same object, and each of the pairs of
corresponding index values are either static expressions with the same value
or @nt{name}s that are known to denote the same object; or]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[both @nt{name}s are @nt{slice}s, their
@nt{prefix}es are known to denote the same object, and the two @nt{slice}s have
statically matching index constraints; or]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[one of the two @nt{name}s statically denotes a
renaming declaration whose renamed @SynI{object_}@nt{name} is known to denote
the same object as the other, the @nt{prefix} of any dereference within
the renamed @SynI{object_}@nt{name} is not a variable, and any @nt{expression}
within the renamed @SynI{object_}@nt{name} contains no references to variables
nor calls on non-static functions.]}
@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Leading],Text=[This exposes known renamings of
  slices, indexing, and so on to this definition. In particular, if we have]}
@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Type=[Leading],Text=[C : Character @key[renames] S(1);]}
@end{Example}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Trailing],Text=[then C and S(1) are known to
  denote the same object.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Leading],Text=[We need the requirement that no
  variables occur in the @nt{prefix}es of dereferences and in (index)
  @nt{expression}s of the renamed object in order to avoid problems from later
  changes to those parts of renamed names. Consider:]}

@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Type=[Leading],Text=[   @key[type] Ref @key[is access] Some_Type;
   Ptr : Ref := @key[new] Some_Type'(...);
   X : Some_Type @key[renames] Ptr.@key[all];
@key[begin]
   Ptr := @key[new] Some_Type'(...);
   P (Func_With_Out_Params (Ptr.@key[all]), X);]}
@end{Example}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Trailing],Text=[X and Ptr.@key[all] should not be
  known to denote the same object, since they denote different allocated objects
  (and this is not an unreasonable thing to do).]}
@end{Reason}

@begin{Honest}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Leading],Text=[The exclusion of variables from
  renamed object_names is not enough to prevent altering the value of the name
  or expression by another access path. For instance, both @key[in] parameters
  passed by reference and access-to-constant values can designate variables. For
  the intended use of "known to be the same object", this is OK; the
  modification via another access path is very tricky and it is OK to reject
  code that would be buggy except for the tricky code. Assuming Element is an
  elementary type, consider the following example:]}
@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[Global : Tagged_Type;]}

@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[@key{procedure} Foo (Param : @key{in} Tagged_Type := Global) @key{is}
   X : Element @key{renames} Some_Global_Array (Param.C);
@key{begin}
   Global.C := Global.C + 1;
   Swap (X, Some_Global_Array (Param.C));]}
@end{Example}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[The rules will flag the call of procedure Swap
  as illegal, since X and Some_Global_Array (Parameter.C) are known to denote
  the same object (even though they will actually represent different objects if
  Param = Global). But this is only incorrect if the parameter actually is
  Global and not some other value; the error could exist for some calls. So this
  flagging seems harmless.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Similar examples can be constructed using
  stand-alone composite constants with controlled or immutably limited
  components, and (as previously noted) with dereferences of access-to-constant
  values. Even when these examples flag a call incorrectly, that call depends
  on very tricky code (modifying the value of a constant); the code is likely
  to confuse future maintainers as well and thus we do not mind rejecting it.]}
@end{Honest}


@end{Itemize}

@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Whether or not @nt{name}s or @nt{prefix}es are
  known to denote the same object is determined statically. If the name
  contains some dynamic portion other than a dereference, @nt{indexed_component}, or
  @nt{slice}, it is not "known to denote the same object".]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[These rules make no attempt to handle slices of
  objects that are known to be the same when the slices have dynamic bounds
  (other than the trivial case of bounds being defined by the same subtype),
  even when the bounds could be proven to be the same, as it is just too complex
  to get right and these rules are intended to be conservative.]}
@end{Discussion}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Leading],Text=["Known to denote the same object"
  is intended to be an equivalence relationship, that is, it is reflexive,
  symmetric, and transitive. We believe this follows from the rules.
  For instance, given the following declarations:]}
@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Type=[Leading],Text=[S   : String(1..10);
ONE : @key[constant] Natural := 1;
R   : Character @key[renames] S(1);]}
@end{Example}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Trailing],Text=[the names R and S(1) are known to
  denote the same object by the sixth bullet, and S(1) and S(ONE) are known to
  denote the same object by the fourth bullet, so using the sixth bullet on
   R and S(ONE), we simply have to test S(1) vs. S(ONE), which we already know
  denote the same object.]}
@end{Ramification}


@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0144-2]}
@ChgAdded{Version=[3],Type=[Leading],Text=[Two @nt{name}s are @i{known to
refer to the same object} if @Defn{known to refer to the same object}]}
@begin{Itemize}
  @ChgRef{Version=[3],Kind=[Added]}
  @ChgAdded{Version=[3],Text=[The two @nt{name}s are known to denote the same object; or]}

  @ChgRef{Version=[3],Kind=[Added]}
  @ChgAdded{Version=[3],Text=[One of the @nt{name}s is a @nt{selected_component},
  @nt{indexed_component}, or @nt{slice} and its @nt{prefix} is known to refer
  to the same object as the other @nt{name}; or]}

  @ChgRef{Version=[3],Kind=[Added]}
  @ChgAdded{Version=[3],Text=[One of the two @nt{name}s statically denotes a
  renaming declaration whose renamed @SynI{object_}@nt{name} is known to refer
  to the same object as the other @nt{name}.]}
@end{Itemize}

@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This ensures that names Prefix.Comp and Prefix are
  known to refer to the same object for the purposes of the rules below. This
  intentionally does not include dereferences; we only want to worry about
  accesses to the same object, and a dereference changes the object in question.
  (There is nothing shared between an access value and the object it
  designates.)]}
@end{Reason}


@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0144-2]}
@ChgAdded{Version=[3],Type=[Leading],Text=[
If a call @i<C> has two or more parameters of mode @key[in out] or @key[out] that
are of an elementary type, then the call is legal only if:]}

@begin{Itemize}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[For each @nt{name} @i<N> that is passed as a parameter of mode @key[in out] or
@key[out] to the call @i<C>, there is no other @nt{name} among the other
parameters of mode @key[in out] or @key[out] to @i<C> that is known to denote the
same object.]}

@begin{Honest}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This means @i{visibly} an elementary type; it does
  not include partial views of elementary types (partial views are always
  composite). That's necessary to avoid having @LegalityTitle depend on the
  contents of the private part.]}
@end{Honest}
@end{Itemize}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0144-2]}
@ChgAdded{Version=[3],Type=[Leading],Text=[If a construct @i<C> has two or more
direct constituents that are @nt{name}s or @nt{expression}s whose evaluation may
occur in an arbitrary order, at least one of which contains a function call with
an @key[in out] or @key[out] parameter, then the construct is legal only if:]}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[All of the places where the language allows an
  arbitrary order can be found by looking in the index under "arbitrary order,
  allowed". Note that this listing includes places that don't involve
  @nt{name}s or @nt{expression}s (such as checks or finalization).]}
@end{Ramification}

@begin{Itemize}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[For each name @i<N> that is passed as a parameter of mode @key[in out] or
@key[out] to some inner function call @i<C2> (not including the construct @i<C>
itself), there is no other @nt{name} anywhere within a direct constituent of the
construct @i<C> other than the one containing @i<C2>, that is known to refer to
the same object.]}
@end{Itemize}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This requirement cannot fail for a procedure
  or entry call alone; there must be at least one function with an @key[in out]
  or @key[out] parameter called as part of a parameter expression of the call in
  order for it to fail.]}
@end{Ramification}

@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[These rules prevent obvious cases of dependence on
  the order of evaluation of @nt{name}s or @nt{expression}s. Such dependence is
  usually a bug, and in any case, is not portable to another implementation (or
  even another optimization setting).]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[In the case that the top-level construct C is a
  call, these rules do not require checks for most @key[in out] parameters, as
  the rules about evaluation of calls prevent problems. Similarly, we do not
  need checks for short circuit operations or other operations with a defined
  order of evaluation. The rules about arbitrary order (see
  @RefSecNum{Method of Description and Syntax Notation}) allow evaluating
  parameters and writing parameters back in an arbitrary order, but not
  interleaving of evaluating
  parameters of one call with writing parameters back from another @em that
  would not correspond to any allowed sequential order.]}
@end{Reason}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0144-2]}
@ChgAdded{Version=[3],Type=[Leading],Text=[For the purposes of checking this rule:]}

@begin{Itemize}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[For an array @nt{aggregate}, an @nt{expression}
associated with a @nt{discrete_choice_list} that has two or more discrete
choices, or that has a nonstatic range, is considered as two or more separate
occurrences of the @nt{expression};]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Type=[Leading],Text=[For a record @nt{aggregate}:]}

@begin{InnerItemize}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[The @nt{expression} of a
@nt{record_component_association} is considered to occur once for each
associated component; and]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[The @nt{default_expression} for each
@nt{record_component_association}
with <> for which the associated component has a @nt{default_expression}
is considered part of the @nt{aggregate};]}
@end{InnerItemize}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[For a call, any @nt{default_expression} evaluated as
part of the call is considered part of the call.]}
@end{Itemize}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[We do not check expressions that are evaluated only because
  of a component initialized by default in an aggregate (via <>).]}
@end{Ramification}
@end{Legality}

@begin{RunTime}
@leading@keepnext@PDefn2{Term=[evaluation], Sec=(parameter_association)}
For the evaluation of a @nt{parameter_association}:
@begin{Itemize}
The actual parameter is first evaluated.

For an access parameter,
the @nt{access_definition} is elaborated,
which creates the anonymous access type.

For a parameter @Redundant[(of any mode)] that is passed by reference
(see @RefSecNum{Formal Parameter Modes}),
a view conversion of the actual parameter to the nominal subtype
of the formal parameter is evaluated,
and the formal parameter denotes that conversion.
@PDefn2{Term=[implicit subtype conversion],Sec=(parameter passing)}
@begin{Discussion}
We are always allowing sliding, even for [@key(in)] @key(out) by-reference
parameters.
@end{Discussion}

@Defn2{Term=[assignment operation], Sec=(during evaluation of a
@nt{parameter_association})}
For an @key(in) or @key(in out) parameter that is passed
by copy (see @RefSecNum{Formal Parameter Modes}),
the formal parameter object is created,
and the value of the actual parameter is converted to the
nominal subtype of the formal parameter
and assigned to the formal.
@PDefn2{Term=[implicit subtype conversion],Sec=(parameter passing)}
@begin{Ramification}
The conversion mentioned here is a value conversion.
@end{Ramification}

@leading@keepnext@;For an @key(out) parameter that is passed by copy,
the formal parameter object is created, and:
@begin(itemize)
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0153-3],ARef=[AI05-0196-1]}
  For an access type, the formal parameter is initialized
  from the value of the actual, without @Chg{Version=[3],New=[checking that the
  value satisfies any constraint, any predicate, or any exclusion of the null
  value],Old=[a constraint check]};
@begin{Reason}
  This preserves the @MetaRulesName that an object of an access type
  is always initialized with a @lquotes@;reasonable@rquotes@; value.
@end{Reason}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0153-3],ARef=[AI05-0228-1]}
@ChgAdded{Version=[3],Text=[For a scalar type that has the Default_Value aspect
specified, the formal parameter is initialized from the value of the actual,
without checking that the value satisfies any constraint or any predicate;]}

@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This preserves the @MetaRulesName that all objects
  of a type with an implicit initial value are initialized. This is important so
  that a programmer can guarantee that all objects of a scalar type have a valid
  value with a carefully chosen Default_Value.]}
@end{Reason}

@begin{ImplNote}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This rule means that @b<out> parameters of a
  subtype @i<T> with a specified Default_Value need to be large enough to
  support any possible value of the base type of @i<T>. In contrast, a type that
  does not have a Default_Value only need support the size of the subtype (since
  no values are passed in).]}
@end{ImplNote}

  For a composite type with discriminants or
  that has implicit initial values for any subcomponents
  (see @RefSecNum{Object Declarations}),
  the behavior is as for an @key[in out] parameter
  passed by copy.
@begin{Reason}
  This ensures that no part of an object of such a type
  can become @lquotes@;de-initialized@rquotes@; by being part of an @b(out)
  parameter.
@end{Reason}
@begin{Ramification}
  This includes an array type whose component type is an access type,
  and a record type with a component that has a @nt{default_expression},
  among other things.
@end{Ramification}

  For any other type, the formal parameter is uninitialized.
  If composite, a view conversion of the actual
  parameter to the nominal subtype of the formal is evaluated
  @Redundant[(which might raise Constraint_Error)],
  and the actual subtype of the formal is that of the
  view conversion. If elementary, the actual subtype of the formal
  is given by its nominal subtype.
@begin{Ramification}
  @ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0228-1]}
  This case covers scalar types@Chg{Version=[3],New=[ that do not have
  Default_Value specified],Old=[]}, and composite types whose
  subcomponent's subtypes do not have any implicit initial values.
  The view conversion for composite types ensures that if the lengths
  don't match between an actual and a formal array parameter,
  the Constraint_Error is raised before the call, rather than after.
@end{Ramification}
@end(itemize)

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0142-4],ARef=[AI05-0234-1]}
@ChgAdded{Version=[3],Text=[In a function call, for each explicitly aliased
parameter, a check is made that the accessibility level of the master of the
actual object is not deeper than that of the  master of the call
(see @RefSecNum{Operations of Access Types}).]}
@begin{Ramification}
  @ChgRef{Version=[3],Kind=[Added]}
  @ChgAdded{Version=[3],Text=[If the actual object to a call @i<C> is a formal
  parameter of some function call @i<F>, no dynamic check against the master of
  the actual parameter of @i<F> is necessary. Any case which could fail the
  dynamic check is already statically illegal (either at the call site of @i<F>,
  or at the call site @i<C>). This is important, as it would require nasty
  distributed overhead to accurately know the dynamic accessibility of a formal
  parameter (all tagged and explicitly aliased parameters would have to carry
  accessibility levels).]}
@end{Ramification}
@end{Itemize}

@PDefn2{Term=[constrained],Sec=(object)}
@PDefn2{Term=[unconstrained],Sec=(object)}
A formal parameter of mode @key[in out] or @key[out] with
discriminants is constrained if either its nominal subtype
or the actual parameter is constrained.

@Defn{parameter copy back}
@Defn{copy back of parameters}
@Defn{parameter assigning back}
@Defn{assigning back of parameters}
@Defn2{Term=[assignment operation], Sec=(during parameter copy back)}
After normal completion and leaving of a subprogram, for each @key(in out)
or @key(out) parameter that is passed by copy,
the value of the formal parameter is converted to
the subtype of the variable given as the actual parameter
and assigned to it.
@PDefn2{Term=[implicit subtype conversion],Sec=(parameter passing)}
These conversions and assignments occur in an arbitrary
order.@PDefn2{Term=[arbitrary order],Sec=[allowed]}
@begin{Ramification}
The conversions mentioned above during parameter passing might raise
Constraint_Error @em (see @RefSecNum{Type Conversions}).
@end{Ramification}
@begin{Ramification}
If any conversion or assignment as part of parameter passing
propagates an exception, the exception is raised at the place
of the subprogram call;
that is, it cannot be handled inside the @nt{subprogram_body}.
@end{Ramification}
@begin{TheProof}
Since these checks happen before or after executing the
@nt{subprogram_body}, the execution of the @nt{subprogram_body} does
not dynamically enclose them, so it can't handle the exceptions.
@end{TheProof}
@begin{Discussion}
The variable we're talking about is the one denoted by the
@i{variable_}@nt{name} given as the @nt{explicit_actual_parameter}.
If this @i{variable_}@nt{name} is a @nt{type_conversion},
then the rules in @RefSecNum{Type Conversions} for assigning to a view
conversion apply.
That is, if X is of subtype S1, and the actual is S2(X),
the above-mentioned conversion will convert to S2,
and the one mentioned in @RefSecNum{Type Conversions} will convert to
S1.
@end{Discussion}
@end{RunTime}

@begin{Erron}
@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0008-1]}
@ChgAdded{Version=[3],Text=[@PDefn2{Term=(erroneous execution),Sec=(cause)}If
the nominal subtype of a formal parameter with discriminants is constrained or
indefinite, and the parameter is passed by reference, then the execution of the
call is erroneous if the value of any discriminant of the actual is changed
while the formal parameter exists (that is, before leaving the corresponding
callable construct).]}
@end{Erron}

@begin{Extend83}
@Defn{extensions to Ada 83}
In Ada 95, a program can rely on the fact that passing an object as
an @key[out] parameter does not @lquotes@;de-initialize@rquotes@; any parts of the
object whose subtypes have implicit initial values.
(This generalizes the RM83 rule that required copy-in for parts that
were discriminants or of an access type.)
@end{Extend83}

@begin{DiffWord83}
We have eliminated the subclause on Default Parameters,
as it is subsumed by earlier clauses and subclauses.
@end{DiffWord83}

@begin{Inconsistent2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0196-1]}
  @ChgAdded{Version=[3],Text=[@Defn{inconsistencies with Ada 2005}
  @b<Correction:> Clarified that
  @key[out] parameters of an access type are not checked for null exclusions
  when they are passed in (which is similar to the behavior for constraints.
  This was unspecified in Ada 2005, so a program which depends on the
  behavior of an implementation which does check the exclusion may
  malfunction. But a program depending on an exception being raised is unlikely.]}
@end{Inconsistent2005}

@begin{Incompatible2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0144-2]}
  @ChgAdded{Version=[3],Text=[@Defn{incompatibilities with Ada 2005}
  Additional rules have been added to make illegal passing the same elementary
  object to more than one @key[in out] or @key[out] parameters of the same
  call. In this case, the result in the object could depend on the compiler
  version, optimization settings, and potentially the phase of the moon, so
  this check will mostly reject programs that are non-portable and could
  fail with any change. Even when the result is expected to be the same in both
  parameters, the code is unnecessarily tricky. Programs which fail this
  new check should be rare and are easily fixed by adding a temporary object.]}
@end{Incompatible2005}

@begin{DiffWord2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0008-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> A missing rule was
  added to cover cases that were missed in Ada 95 and Ada 2005; specifically,
  that an @key[in] parameter passed by reference might have its discriminants
  changed via another path. Such cases are erroneous as requiring compilers
  to detect such errors would be expensive, and requiring such cases to
  work would be a major change of the user model (@key[in] parameters
  with discriminants could no longer be assumed constant). This is not
  an inconsistency, as compilers are not required to change any current
  behavior.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0102-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Moved implicit conversion
  @LegalityName to @RefSecNum{The Context of Overload Resolution}.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0118-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Added a definition for
  positional parameters, as this is missing from Ada 95 and later.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0142-4]}
  @ChgAdded{Version=[3],Text=[Rules have been added defining the legality
  and dynamic checks needed for explicitly aliased parameters (see
  @RefSecNum{Subprogram Declarations}).]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0144-2]}
  @ChgAdded{Version=[3],Text=[Additional rules have been added such
  that passing an object to an @key[in out]
  or @key[out] parameter of a function is illegal if it is used elsewhere in a
  construct which allows evaluation in an arbitrary order. Such calls are
  not portable (since the results may depend on the evaluation order), and
  the results could even vary because of optimization settings and the like.
  Thus they've been banned.]}
@end{DiffWord2005}


@LabeledClause{Return Statements}

@begin{Intro}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
A @Chg{Version=[2],New=[@nt{simple_@!return_@!statement} or
@nt{extended_@!return_@!statement} (collectively called a @i<return statement>)
@Defn{return statement}],Old=[@nt{return_statement}]} is used to
complete the execution of the
innermost enclosing @nt{subprogram_@!body},
@nt{entry_@!body}, or @nt{accept_@!statement}.
@end{Intro}

@begin{Syntax}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@Syn{lhs=<@Chg{Version=[2],New=[simple_return_statement],Old=[return_statement]}>,rhs="@key{return} [@Syn2{expression}];"}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0015-1],ARef=[AI05-0053-1]}
@AddedSyn{Version=[2],lhs=<@Chg{Version=[2],New=[extended_return_statement],Old=[]}>,
rhs="@Chg{Version=[2],New=<
    @key{return} @Syn2{defining_identifier} : [@Chg{Version=[3],New=<@Key{constant}>,Old=[@Key{aliased}]}] @Syn2{return_subtype_indication} [:= @Syn2{expression}] [@Key{do}
        @Syn2{handled_sequence_of_statements}
    @key{end} @key{return}];>,Old=[]}"}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@AddedSyn{Version=[2],lhs=<@Chg{Version=[2],New=[return_subtype_indication],Old=[]}>,
rhs="@Chg{Version=[2],New=<@Syn2{subtype_indication} | @Syn2{access_definition}>,Old=[]}"}

@end{Syntax}

@begin{Resolution}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@Chg{Version=[2],New=[@Defn2{Term=[result subtype], Sec=(of a function)}
The @i<result subtype> of a function is the subtype denoted by the
@nt<subtype_mark>, or defined by the @nt<access_definition>, after the reserved
word @key<return> in the profile of the function.@PDefn2{Term=[expected type],
Sec=(@nt{expression} of @nt<simple_@!return_@!statement>)}],Old=[@Defn{return expression}
The @nt{expression}, if any, of a @nt{return_statement} is called the
@i{return expression}.
@Defn2{Term=[result subtype], Sec=(of a function)}
The @i(result subtype) of a function is the subtype denoted by the
@nt{subtype_mark} after the reserved word @key(return) in the profile
of the function.@PDefn2{Term=[expected type], Sec=(return expression)}]}
The expected type for @Chg{Version=[2],New=[the @nt{expression}, if any, of a
@nt{simple_@!return_@!statement}],Old=[a return expression]} is the result type of
the corresponding function.@Chg{Version=[2],New=[
@PDefn2{Term=[expected type], Sec=(@nt{expression} of @nt{extended_return_statement})}
The expected type for the
@nt{expression} of an @nt{extended_return_statement} is that of the
@nt{return_@!subtype_@!indication}.],Old=[]}
@begin{Honest}
The same applies to generic functions.
@end{Honest}
@end{Resolution}

@begin{Legality}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@Chg{Version=[2],New=[@Defn2{Term=[apply],
Sec=(to a callable construct by a return statement)}],
Old=[@Defn2{Term=[apply], Sec=(to a callable construct by a @nt{return_statement})}]}
A @Chg{Version=[2],New=[return statement],Old=[@nt{return_@!statement}]}
shall be within a callable construct,
and it @i{applies to} the innermost @Chg{Version=[2],New=[callable construct
or @nt{extended_return_statement} that contains it],Old=[one]}.
A @Chg{Version=[2],New=[return statement],Old=[@nt{return_@!statement}]} shall
not be within a body that is within the construct to which the
@Chg{Version=[2],New=[return statement],Old=[@nt{return_@!statement}]} applies.

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0015-1]}
A function body shall contain at least one
@Chg{Version=[2],New=[return statement],Old=[@nt{return_@!statement}]} that
applies to the function body,
unless the function contains @nt{code_statement}s.
A @Chg{Version=[2],New=[@nt{simple_@!return_@!statement}],Old=[@nt{return_@!statement}]} shall
include @Chg{Version=[2],New=[an @nt{expression}],Old=[a return expression]}
if and only if it applies to a function
body.@Chg{Version=[2],New=[ An @nt<extended_return_statement> shall apply to
a function body.],Old=[]}@Chg{Version=[3],New=[ An @nt{extended_return_statement}
with the reserved word @key[constant] shall include an @nt{expression}.],Old=[]}

@begin{Reason}
  @ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
  The requirement that a function body has to have at least one
  @Chg{Version=[2],New=[return statement],Old=[@nt{return_@!statement}]}
  is a @lquotes@;helpful@rquotes@; restriction.
  There @Chg{Version=[2],New=[has],Old=[was]} been some interest in lifting
  this restriction, or allowing a raise statement to substitute for the
  @Chg{Version=[2],New=[return statement],Old=[@nt{return_@!statement}]}.
  However, there was enough interest in leaving it as is
  that we decided not to change it.
@end{Reason}
@begin{Ramification}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[A return statement can apply to an
  @nt{extended_return_statement}, so a @nt{simple_@!return_@!statement} without
  an @nt{expression} can be given in one. However, neither
  @nt{simple_@!return_@!statement} with an @nt{expression} nor an
  @nt{extended_return_statement} can be given inside an
  @nt{extended_return_statement}, as they must apply (directly) to a
  function body.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@ChgAdded{Version=[2],Type=[Leading],Text=[For an
@nt{extended_@!return_@!statement} that applies to a function body:]}

@begin{Itemize}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0032-1],ARef=[AI05-0103-1]}
@ChgAdded{Version=[2],Text=[If the result subtype of the function is defined by a
@nt{subtype_mark}, the @nt{return_@!subtype_@!indication} shall be a
@nt{subtype_indication}. The type of the @nt{subtype_indication}
shall be@Chg{Version=[3],New=[ covered by],Old=[]} the
result type of the function. @Chg{Version=[3],New=[The],Old=[If the result
subtype of the function is constrained, then the]} subtype defined by the
@nt{subtype_indication} shall @Chg{Version=[3],New=[be statically compatible
with the result subtype of the function; if the result type of the
function is elementary, the two subtypes],Old=[also
be constrained and]} shall statically match@Chg{Version=[3],New=[],Old=[ this
result subtype]}.@PDefn2{Term=[statically matching],Sec=(required)}
If the result subtype of the function is @Chg{Version=[3],New=[indefinite],
Old=[unconstrained]}, then the subtype
defined by the @nt{subtype_indication} shall be a definite subtype, or there
shall be an @nt{expression}.]}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@ChgAdded{Version=[2],Text=[If the result subtype of the function is defined
by an @nt{access_definition}, the @nt{return_@!subtype_@!indication} shall be an
@nt{access_definition}. The subtype defined by the @nt{access_definition} shall
statically match the result subtype of the function. The accessibility level of
this anonymous access subtype is that of the result subtype.]}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0032-1]}
@ChgAdded{Version=[3],Text=[If the result subtype of the function is class-wide,
the accessibility level of the type of the subtype defined by the
@nt{return_subtype_indication}
shall not be statically deeper than that of the master that elaborated
the function body.]}
@begin{Reason}
  @ChgRef{Version=[3],Kind=[Added]}
  @ChgAdded{Version=[3],Text=[In this case, the @nt{return_subtype_indication}
  could be a specific type initialized by default; in that case there is no
  @nt{expression} to check.]}
@end{Reason}
@end{Itemize}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0032-1]}@Comment{Paragraph number only change}
@ChgAdded{Version=[2],Type=[Leading],Text=[For any return statement
that applies to a function body:]}

@begin{Itemize}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0188-1]}@Comment{Paragraph number only change}
@ChgAdded{Version=[2],Text=[@Redundant[If the result subtype of the function is limited,
then the @nt{expression} of the return statement (if any) shall @Chg{Version=[3],
New=[meet the restrictions described in @RefSecNum{Limited Types}],Old=[be an
@nt{aggregate}, a function call (or equivalent use of an operator), or a
@nt{qualified_expression} or parenthesized expression whose operand is one of
these]}.]]}
@begin{Discussion}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0188-1]}
  @ChgDeleted{Version=[3],Text=[@Chg{Version=[2],New=[In other words, if limited, the @nt{expression}
  must produce a @lquotes@;new@rquotes@; object, rather than being the name
  of a preexisting object (which would imply copying).],Old=[]}]}
@end{Discussion}

@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00416-01]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0032-1],ARef=[AI05-0051-1]}
@ChgAdded{Version=[2],Text=[If the result subtype of the function is class-wide,
the accessibility level of the type of the @nt{expression}
@Chg{Version=[3],New=[(if any) ],Old=[]}of the return
statement shall not be statically deeper than that of the master that
elaborated the function body.@Chg{Version=[3],New=[],Old=[ If the result subtype
has one or more
unconstrained access discriminants, the accessibility level of the anonymous
access type of each access discriminant, as determined by the
@nt{expression} of the @nt{simple_@!return_@!statement} or the
@nt{return_@!subtype_@!indication}, shall not be
statically deeper than that of the master that elaborated the function body.]}]}

@begin{Discussion}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0032-1],ARef=[AI05-0051-1]}
  @ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[If],Old=[We know that if]}
  the result type is class wide, then there must be an @nt{expression} of the
  return statement@Chg{Version=[3],New=[ unless this is
  an @nt{extended_return_statement} whose @nt{return_subtype_indication} is
  a specific type. We have a separate rule to cover that case. Note that
  if an @nt{extended_return_statement} has an @nt{expression}, then both rules
  must be satisfied],Old=[. Similarly, if
  the result subtype is unconstrained, then either the
  @nt{return_@!subtype_@!indication} (if any) is constrained, or
  there must be an @nt{expression}]}.]}
@end{Discussion}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0051-1]}
@ChgAdded{Version=[3],Text=[If the subtype determined by the @nt{expression} of the
@nt{simple_return_statement} or by the @nt{return_subtype_indication} has
one or more access discriminants, the accessibility level of the anonymous
access type of each access discriminant shall not be statically deeper than that
of the master that elaborated the function body.]}

@begin{Discussion}
@ChgRef{Version=[3],Kind=[Added]}
  @ChgAdded{Version=[3],Text=[We use the type used by the return statement
  rather than from the function return type since we want to check whenever
  the return object has access discriminants, even if the function return type
  doesn't have any (mostly for a class-wide type).]}
@end{Discussion}
@end{Itemize}

@end{Legality}

@begin{StaticSem}
@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0015-1],ARef=[AI05-0144-2]}
@ChgAdded{Version=[2],Text=[@PDefn2{Term=[return object], Sec=(extended_return_statement)}
Within an @nt{extended_return_statement}, the @i{return object} is declared
with the given @nt{defining_identifier}, with the nominal subtype defined by
the @nt{return_@!subtype_@!indication}.@Chg{Version=[3],New=[ An
@nt{extended_return_statement} with the reserved word @key[constant]
is a full constant declaration that declares the return object to be a
constant object.],Old=[]}]}
@end{StaticSem}

@begin{RunTime}
@ChgRef{Version=[2],Kind=[Added],ARef=[AI95-00318-02],ARef=[AI95-00416-01]}
@ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0032-1]}
@ChgAdded{Version=[2],Text=[@PDefn2{Term=[execution], Sec=(extended_return_statement)}
For the execution of an @nt{extended_return_statement}, the
@nt{subtype_indication} or @nt{access_definition} is elaborated. This creates
the nominal subtype of the return object. If there is an @nt{expression}, it
is evaluated and converted to the nominal subtype (which might raise
Constraint_Error @em see @RefSecNum{Type Conversions}@PDefn2{Term=[implicit subtype conversion],Sec=(function return)});
the return object is created and the converted value is assigned to
the return object. Otherwise, the return object is created and initialized
by default as for a stand-alone object of its nominal subtype (see
@RefSecNum{Object Declarations}). If the nominal subtype is indefinite, the
return object is constrained by its initial
value.@PDefn2{Term=[creation],Sec=[of a return object]}@PDefn{constrained by its initial value}@Chg{Version=[3],New=[
A check is made that the value of the return object belongs to the function
result subtype. Constraint_Error is raised if this
check fails.@Defn2{Term=[Constraint_Error],
Sec=(raised by failure of run-time check)}
@IndexCheck{Discriminant_Check}],Old=[]}]}

@begin{Ramification}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[If the result type is controlled or has a
  controlled part, appropriate calls on Initialize or Adjust are performed
  prior to executing the @nt{handled_sequence_of_statements}, except when the
  initial expression is an @nt{aggregate} (which requires build-in-place
  with no call on Adjust).]}

  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0005-1]}
  @ChgAdded{Version=[2],Text=[If the return statement is left without resulting
  in a return (for example, due to an exception propagated from the
  @nt{expression} or the @nt{handled_sequence_of_statements}, or a goto out of
  the @nt{handled_sequence_of_statements}), @Chg{Version=[3],New=[if ],Old=[]}the
  return object @Chg{Version=[3],New=[has been created, it ],Old=[]}is
  finalized prior to leaving the return statement.@Chg{Version=[3],New=[ If
  it has not been created when the return statement is left, it is not
  created or finalized.],Old=[]}]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0032-1]}
  @ChgAdded{Version=[3],Text=[Other rules ensure that the check required by
  this rule cannot fail unless the function has a class-wide result subtype
  where the associated specific subtype is constrained. In other cases,
  either the subtypes have to match or the function's subtype is
  unconstrained and needs no checking.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@Chg{Version=[2],New=[@PDefn2{Term=[execution], Sec=(simple_@!return_@!statement)}],
Old=[@PDefn2{Term=[execution], Sec=(return_statement)}]}
For the execution of a @Chg{Version=[2],New=[@nt{simple_@!return_@!statement}],
Old=[@nt{return_statement}]}, the @nt{expression}
(if any) is first evaluated@Chg{Version=[2],New=[,],Old=[ and]} converted to
the result subtype@Chg{Version=[2],
New=[, and then is assigned to the anonymous @i{return object}.
@PDefn2{Term=[return object], Sec=(simple_@!return_@!statement)}],Old=[.]}
@PDefn2{Term=[implicit subtype conversion],Sec=(function return)}
@begin{Ramification}
The conversion might raise
Constraint_Error @em (see @RefSecNum{Type Conversions}).
@end{Ramification}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02],ARef=[AI95-00416-01]}
@Chg{Version=[2],New=[@Redundant[If the return object has any parts that are tasks, the
activation of those tasks does not occur until after the function returns (see
@RefSecNum{Task Execution - Task Activation}).]],
Old=[If the result type is class-wide, then
the tag of the result is the tag of the value
of the @nt<expression>.]}
@begin{TheProof}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[This is specified by the rules in
  @RefSecNum{Task Execution - Task Activation}.]}
@end{TheProof}
@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[Only the caller can know when task activations
  should take place, as it depends on the context of the call. If the function
  is being used to initialize the component of some larger object, then that
  entire object must be initialized before any task activations. Even after the
  outer object is fully initialized, task activations are still postponed until
  the @key{begin} at the end of the declarative part if the function is being
  used to initialize part of a declared object.]}
@end{Reason}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02],ARef=[AI95-00344-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0024-1],ARef=[AI05-0032-1]}
@ChgDeleted{Version=[2],Type=[Leading],Keepnext=[T],Text=[]}@ChgNote{A dummy
ChgDeleted to get conditional "Leading".}If
the result type @Chg{Version=[2],New=[of a function ],Old=[]}is a specific
tagged type@Chg{Version=[2],New=[, the tag of the return object is that
of the result type. If the result type is class-wide, the tag of the
return object is that of @Chg{Version=[3],New=[the type of the
@nt{subtype_indication} if it is specific, or otherwise that of ],Old=[]}the
value of the @Chg{Version=[3],New=[@nt{expression}],Old=[expression]}.
A check is made that
the @Chg{Version=[3],New=[master],Old=[accessibility level]} of the type
identified by the tag of the result @Chg{Version=[3],New=[includes the
elaboration],Old=[is not deeper than that]} of the master that elaborated
the function body. If
this check fails, Program_Error is raised.@Defn2{Term=[Program_Error],
Sec=(raised by failure of run-time check)}
@IndexCheck{Accessibility_Check}],Old=[:]}

@begin{Ramification}
  @ChgNote{Moved from after paragraph 10}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[The first sentence is true even if the
  tag of the @nt{expression} is different, which
  could happen if the @nt{expression} were a view conversion or a
  dereference of an access value. Note that for a limited type, because
  of the restriction to @nt{aggregate}s and function calls (and no conversions),
  the tag will already match]}.
@end{Ramification}
@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[The first rule ensures
  that a function whose result type is
  a specific tagged type always returns an object whose tag is that of the
  result type. This is important for dispatching on controlling result, and
  allows the caller to allocate the appropriate amount of space to hold
  the value being returned (assuming there are no discriminants).]}

  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgRef{Version=[3],Kind=[Revised]}
  @ChgAdded{Version=[2],Text=[The @Chg{Version=[3],New=[master ],Old=[]}check
  prevents the returned object
  from outliving its type. Note that this check cannot fail for a specific
  tagged type, as the tag represents the function's type, which necessarily
  must be declared outside of the function.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[We can't use the normal accessibility level
    @lquotes@;deeper than@rquotes@; check
    here because we may have @lquotes@;incomparable@rquotes@; levels if
    the masters belong to two different tasks. This can happen when an
    accept statement calls a function declared in the enclosing task body, and
    the function returns an object passed to it from the accept statement, and
    this object was itself a parameter to the accept statement.]}

@end{Reason}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0073-1]}
@ChgAdded{Version=[3],Text=[@IndexCheck{Tag_Check}If the result subtype
of the function is defined by
an @nt{access_definition} designating a specific tagged type @i<T>, a check
is made that the result value is null or the tag of the object designated
by the result value identifies @i<T>.
@Defn2{Term=[Constraint_Error],Sec=(raised by failure of run-time check)}
Constraint_Error is raised if this check fails.]}
@begin{Reason}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This check is needed so that dispatching
  on controlling access results works for tag-indeterminate functions.
  If it was not made, it would be possible for such functions to return
  an access to a decendant type, meaning the function could return
  an object with a tag different than the one assumed by the
  dispatching rules.]}
@end{Reason}

@begin{NotIso}
@ChgAdded{Version=[2],Noprefix=[T],Noparanum=[T],Text=[@Shrink{@i<Paragraphs 9
through 20 were deleted.>}]}@Comment{This message should be deleted if the
paragraphs are ever renumbered.}
@end{NotIso}

@begin(itemize)
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[@IndexCheck{Tag_Check}
  If it is limited, then
  a check is made that the tag of the value of the return expression
  identifies the result type.
  @Defn2{Term=[Constraint_Error],Sec=(raised by failure of run-time check)}
  Constraint_Error is raised if this check fails.]}

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[If it is nonlimited, then
  the tag of the result is that of the result type.]}
@begin{Ramification}
  @ChgNote{These two notes were revised and moved up}
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[This is true even if the
  tag of the return expression is different.]}
@end{Ramification}
@begin{Reason}
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[These rules ensure
  that a function whose result type is
  a specific tagged type always returns an object whose tag is that of the
  result type. This is important for dispatching on controlling result,
  and, if nonlimited,
  allows the caller to allocate the appropriate amount of space to hold
  the value being returned (assuming there are no discriminants).]}
@end{Reason}
@end(itemize)

@ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
@ChgDeleted{Version=[2],Type=[Leading],Keepnext=[T],
Text=[@Defn{return-by-reference type}
A type is a @i(return-by-reference) type if it
is a descendant of one of the following:]}
@begin(itemize)
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[a tagged limited type;]}

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[a task or protected type;]}

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[a nonprivate type with the reserved word
  @b(limited) in its declaration;]}

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[a composite type with a subcomponent
  of a return-by-reference type;]}

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[a private type
  whose full type is a return-by-reference type.]}
@end(itemize)
@begin{Ramification}
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg]}
  @ChgDeleted{Version=[2],Text=[
  The above rules are such that there are no "Ada 83" types other than
  those containing tasks that are return-by-reference. This helps
  to minimize upward incompatibilities relating to return-by-reference.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
@ChgDeleted{Version=[2],Type=[Leading],Text=[@IndexCheck{Accessibility_Check}
If the result type is a return-by-reference type,
then a check is made that the return expression is one of the
following:]}
@begin(itemize)

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[a @nt{name} that denotes an object view
  whose accessibility level is not deeper than that of the master that
  elaborated the function body; or]}
  @begin{Discussion}
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00316-01]}
  @ChgNote{This really wasn't in the previous version, but we don't want it
  in a version without deletions shown...}
  @ChgDeleted{Version=[2],Text=[This rule was unnecessarily confusing, and the
  parenthetical remark "(or a value with an associated object, see 6.2)"
  was added @em and then the entire concept was deleted.]}
  @end{Discussion}

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
  @ChgDeleted{Version=[2],Text=[a parenthesized expression or
  @nt{qualified_expression} whose operand is one of these kinds of expressions.]}

@end(itemize)

@ChgRef{Version=[2],Kind=[DeletedNoDelMsg],ARef=[AI95-00318-02]}
@ChgDeleted{Version=[2],Text=[@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
The exception Program_Error is raised if this check fails.]}
@begin{Discussion}
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg]}
  @ChgDeleted{Version=[2],Text=[Compare the definition of return-by-reference
  with that of by-reference.]}

  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg]}
  @ChgDeleted{Version=[2],Text=[The return-by-reference types are all limited types
  except those that are limited only because of a limited
  private type with a nonlimited untagged full type.]}
@end{Discussion}
@begin{Reason}
  @ChgRef{Version=[2],Kind=[DeletedNoDelMsg]}
  @ChgDeleted{Version=[2],Text=[@PDefn{generic contract issue}
  This check can often be performed at compile time. It is
  defined to be a run-time check to avoid generic contract model
  problems. In a future version of the standard, we anticipate
  that function return of a local variable will be illegal for all
  limited types, eliminating the need for the run-time check
  except for dereferences of an access parameter.]}
@end{Reason}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02],ARef=[AI95-00402-01],ARef=[AI95-00416-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0051-1]}
@Chg{Version=[2],
New=[If @Chg{Version=[3],New=[any part of the specific type of the return object],
Old=[the result subtype]} of a function
@Chg{Version=[3],New=[(or coextension thereof) ],Old=[]}has one or more
@Chg{Version=[3],New=[],Old=[unconstrained ]}access
discriminants@Chg{Version=[3],New=[ whose value is not constrained by the
result subtype of the function],Old=[]},
a check is made that the accessibility level of the anonymous access type
of each access discriminant, as determined by the @nt{expression} or the
@nt{return_@!subtype_@!indication} of the @Chg{Version=[3],New=[return
statement],Old=[function]},
is not deeper than @Chg{Version=[3],New=[the level of the master of the call
(see @RefSecNum{Operations of Access Types})],
Old=[that of the master that elaborated the
function body]}. If this check fails, Program_Error is raised.
@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}
@IndexCheck{Accessibility_Check}],
Old=[For a function with a return-by-reference result type
the result is returned by reference;
that is, the function call denotes a constant view of the
object associated
with the value of the return expression.
@Defn2{Term=[assignment operation], Sec=(during execution of a
@nt{return_statement})}
For any other function, the result is returned by copy;
that is,
the converted value is assigned into an anonymous constant created at
the point of the @nt{return_statement}, and the function call denotes
that object.]}
@begin{Ramification}
  @ChgRef{Version=[2],Kind=[Deleted]}
  @ChgDeleted{Version=[2],Text=[The assignment operation does the necessary
  value adjustment, as described in
  @RefSec{Assignment and Finalization}.
  @RefSecNum{Completion and Finalization}
  describes when the anonymous constant is finalized.]}
@end{Ramification}
@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[The check prevents the returned
  object (for a nonlimited type) from outliving the object designated by one
  of its discriminants. The check is made on the values of the discriminants,
  which may come from the @nt{return_@!subtype_@!indication} (if constrained),
  or the @nt{expression}, but it is never necessary to check both.]}
@end{Reason}
@begin{ImplNote}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0234-1]}
  @ChgAdded{Version=[3],Text=[The reason for saying @ldquote@;any part of
  the specific type@rdquote is to simplify implementation. In the case of
  class-wide result objects this allows the testing of a simple flag in the
  tagged type descriptor that indicates whether specific type has any parts with
  access discriminants. By basing the test on the type of the object rather than
  the object itself, we avoid concerns about whether subcomponents in variant
  parts and of arrays (which might be empty) are present.]}
@end{ImplNote}
@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0234-1]}
  @ChgAdded{Version=[3],Text=[For a function with a class-wide result type, the
   access values that need to be checked are determined by the tag of the return
   object. In order to implement this accessibility check in the case where the
   tag of the result is not known statically at the point of the return
   statement, an implementation may need to somehow associate with the tag of a
   specific tagged type an indication of whether the type has unconstrained
   access discriminants (explicit or inherited) or has any subcomponents with
   such discriminants. If an implementation is already maintaining a statically
   initialized descriptor of some kind for each specific tagged type, then an
   additional Boolean could be added to this descriptor.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[Note that the flag should only be queried in the
   case where any access discriminants which the result object might have
   subtypes with "bad" accessibility levels (as determined by the rules of
   @RefSecNum{Operations of Access Types} for determining the accessibility
   level of the type of of an access discriminant in the @nt{expression} or
   @nt{return_subtype_indication} of a return statement).]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Leading],Text=[Thus, in a case like]}

@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[@key[type] Global @key[is access] T'Class;
@key[function] F (Ptr : Global) @key[return] T'Class @key[is]
@key[begin]
   @key[return] Ptr.@key[all];
@key[end] F;]}
@end{Example}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Trailing],Text=[there is no need for a run-time
    accessibility check. The setting of the bit doesn't matter and there is no
    need to query it.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Leading],Text=[On the other hand, given]}
@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[@key[function] F @key[return] T'Class @key[is]
   Local : T'Class := ... ;
@key[begin]
   @key[return] Local;
@key[end] F;]}
@end{Example}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Trailing],Text=[In this case, a check would
    typically be required.]}

  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Type=[Leading],Text=[The need for including
    subcomponents in this check is illustrated by the following example:]}
@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[X : @key[aliased] Integer;]}

@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[@key[type] Component_Type (Discrim : @key[access] Integer := X'Access)
   @key[is limited null record];]}

@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[@key[type] Undiscriminated @key[is record]
   Fld : Component_Type;
@key[end record];]}

@ChgRef{Version=[3],Kind=[AddedNormal]}
@ChgAdded{Version=[3],Text=[@key[function] F @key[return] Undiscriminated @key[is]
   Local : @key[aliased] Integer;
@key[begin]
   @key[return] X : Undiscriminated := (Fld => (Discrim => Local'Access)) @key[do]
      Foo;
   @key[end return];
   --@Examcom{ raises Program_Error after calling Foo.}
@key[end]} F;]}
@end{Example}
@end{Discussion}
@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0234-1]}
  @ChgAdded{Version=[3],Text=[In the case where the tag of the result is not
  known statically at the point of the return statement and the run-time
  accessibility check is needed, discriminant values and array bounds play no
  role in performing this check. That is, array components are assumed to have
  nonzero length and components declared within variant parts are assumed to be
  present. Thus, the check may be implemented simply by testing the
  aforementioned descriptor bit and conditionally raising Program_Error.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0058-1]}
@Chg{Version=[2],New=[For the execution of an
@nt{extended_@!return_@!statement}, the
@nt{handled_@!sequence_@!of_@!statements} is executed. Within this
@nt{handled_@!sequence_@!of_@!statements}, the execution of a
@nt{simple_@!return_@!statement} that applies to the
@nt{extended_@!return_@!statement} causes a transfer of control that completes
the @nt{extended_@!return_@!statement}. Upon completion
of a return statement that applies to a callable construct@Chg{Version=[3],
New=[ by the normal completion of a @nt{simple_return_statement} or
by reaching the @key[end return] of an @nt{extended_return_statement}],
Old=[]}],Old=[Finally]}, a
transfer of control is performed which completes the execution of the callable
construct@Chg{Version=[2],New=[], Old=[ to which the @nt{return_@!statement}
applies]}, and returns to the caller.

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0058-1]}
  @ChgAdded{Version=[3],Text=[A transfer of control that completes an
  @nt{extended_return_statement} (such as an exit or goto) does not cause
  a return to the caller unless it is caused by @nt{simple_return_statement}
  (that is, triggers the second sentence of this paragraph). The return to
  the caller occurs for the @nt{simple_return_statement} that applies to an
  @nt{extended_return_statement} because the last sentence says
  @ldquote@;the normal completion of a @nt{simple_return_statement}@rdquote@;,
  which includes the one nested in the @nt{extended_return_statement}.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
@ChgAdded{Version=[2],Text=[In the case of a function, the @nt{function_call}
denotes a constant view of the return object.]}
@end{RunTime}

@begin{ImplPerm}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00416-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0050-1]}
@ChgAdded{Version=[3],Type=[Leading],Text=[]}@Comment{This is a fake used to provide a conditional leading.}
@ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[For a function call used to
initialize a composite],Old=[If the result subtype of a function is
unconstrained, and a call on the function is used to provide the initial value
of an]} object with a constrained nominal subtype@Chg{Version=[3],New=[ or
used to initialize a return object that is built in place
into such an object:],Old=[, Constraint_Error may be raised
at the point of the call (after abandoning the execution of the function body)
if, while elaborating the @nt{return_@!subtype_@!indication} or
evaluating the @nt{expression} of a return statement that applies to the
function body, it
is determined that the value of the result will violate the constraint of the
subtype of this object.]}]}

@begin{Itemize}
  @ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0050-1]}
  @ChgAdded{Version=[3],Text=[If the result subtype of the function is
  constrained, and conversion of an object of this subtype to the subtype of the
  object being initialized would raise Constraint_Error, then Constraint_Error
  may be raised before calling the function.]}

  @ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0050-1]}
  @ChgAdded{Version=[3],Text=[If the result subtype of the function is
  unconstrained, and a return statement is executed such that the return object
  is known to be constrained, and conversion of the return object to the subtype
  of the object being initialized would raise Constraint_Error, then
  Constraint_Error may be raised at the point of the call (after abandoning the
  execution of the function body).]}
@end{Itemize}

@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00416-01]}
  @ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0050-1]}
  @ChgAdded{Version=[2],Text=[Without such a permission, it would be very
  difficult to implement
  @lquotes@;@Chg{Version=[3],New=[built-in-place],Old=[build-in-place]}@rquotes semantics.
  @Chg{Version=[3],New=[The intention is that the exception is raised at the
  same point that it would have been raised without the permission; it
  should not change handlers if the implementation switches between
  return-by-copy and built-in-place. This means that the],Old=[Such an]}
  exception is not handleable within the function, because in the
  return-by-copy case, the constraint check to verify that the result satisfies
  the constraints of the object being initialized happens after the function
  returns@Chg{Version=[3],New=[],Old=[, and we want the semantics to change as
  little as possible when switching between return-by-copy and build-in-place]}.
  This implies further that upon detecting such a situation, the implementation
  may need to simulate a goto to a point outside any local exception handlers
  prior to raising the exception.]}
@end{Reason}

@begin{Ramification}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00416-01]}
  @ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0050-1]}
  @Chg{Version=[3],New=[These permissions do not apply in the case of an extended
  return object with mutable discriminants. That's necessary because in that
  case a return object can be created with the @ldquote@;wrong@rdquote
  discriminants and then changed to the @ldquote@;right@rdquote discriminants
  later (but before returning). We don't want this case raising an exception
  when the canonical semantics will not do so.],Old=[@Chg{Version=[2],New=[This
  permission is allowed during the evaluation of the @nt{expression} of an
  @nt{extended_return_statement}, because the @nt{return_@!subtype_@!indication}
  may be unconstrained and the @nt{expression} then would provide the
  constraints.],Old=[]}]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0050-1]}
  @ChgAdded{Version=[3],Text=[It's still possible to write a program that will
  raise an exception using this permission that would not in the canonical
  semantics. That could happen if a return statement with the
  @ldquote@;wrong@rdquote discriminants or bounds is abandoned (via an
  exception, or for an extended_return_statement, via an exit or goto
  statement), and then a return statement with the @ldquote@;right@rdquote
  discrimiants or bounds is executed. The only solution for this problem is to
  not have the permission at all, but this is too unusual of a case to worry about
  the effects of the permission, especially given the implementation
  difficulties for built-in-place objects that this permission is intended to
  ease.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0050-1]}
  @ChgAdded{Version=[3],Text=[Note that the mutable-discriminant case only
  happens when built-in-place initialization is optional. This means that any
  difficulties associated with implementing built-in-place initialization
  without these permissions can be sidestepped by not building in place.]}

@end{Ramification}

@end{ImplPerm}

@begin{Examples}
@leading@keepnext@i{Examples of return statements:}
@begin{Example}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@key[return];                         --@ExamCom{ in a procedure body, }@nt{entry_body}@ExamCom{,}@Chg{Version=[2],New=[
                                -- @nt{accept_statement}@ExamCom{, or }@nt{extended_return_statement}],Old=[@ExamCom{ or }@nt{accept_statement}]}

@key[return] Key_Value(Last_Index);   --@ExamCom{ in a function body}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
@Chg{Version=[2],New=<@key[return] Node : Cell @key{do}           --@ExamCom{ in a function body, see @RefSecNum{Incomplete Type Declarations} for Cell}
   Node.Value := Result;
   Node.Succ := Next_Node;
@key{end} @key{return};>,Old=<>}
@end{Example}
@end{Examples}

@begin{Incompatible83}
@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
@Defn{incompatibilities with Ada 83}
In Ada 95, if the result type of a function has a part that is a task,
then an attempt to return a local variable will raise Program_Error.
@Chg{Version=[2],New=[This is illegal in Ada 2005, see below. ],
Old=[]}In Ada 83, if a function returns a local variable containing a task,
execution is erroneous according to AI83-00867. However,
there are other situations where functions that return tasks
(or that return a variant record only one of whose variants
includes a task)
are correct in Ada 83 but will raise Program_Error according
to the new rules.

The rule change was made because there will be more types (protected types,
limited controlled types) in Ada 95 for which
it will be meaningless to return a local variable, and making
all of these erroneous is unacceptable.
The current rule was felt to be the simplest that kept
upward incompatibilities to situations involving returning tasks,
which are quite rare.
@end{Incompatible83}

@begin{DiffWord83}
This clause has been moved here from chapter 5,
since it has mainly to do with subprograms.

A function now creates an anonymous object.
This is necessary so that controlled types
will work.

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
We have clarified that a
@Chg{Version=[2],New=[return statement],Old=[@nt{return_statement}]}
applies to a callable construct, not to a callable entity.

@ChgRef{Version=[2],Kind=[Revised],ARef=[AI95-00318-02]}
There is no need to mention generics in the rules about where a
@Chg{Version=[2],New=[return statement],Old=[@nt{return_statement}]}
can appear and what it applies to;
the phrase @lquotes@;body of a subprogram or generic subprogram@rquotes@; is
syntactic, and refers exactly to @lquotes@;@nt{subprogram_body}@rquotes@;.
@end{DiffWord83}

@begin{Inconsistent95}
  @ChgRef{Version=[2],Kind=[Added],ARef=[AI95-0416-1]}
  @ChgRef{Version=[3],Kind=[RevisedAdded],ARef=[AI05-0005-1],ARef=[AI05-0050-1]}
  @ChgAdded{Version=[2],Text=[@Defn{inconsistencies with Ada 95}
  Added an @ImplPermName allowing early raising of Constraint_Error if the
  result cannot fit in the ultimate object. This gives implementations more
  flexibility to do built-in-place returns, and is essential for limited types
  (which cannot be built in a temporary). However, it allows
  raising @Chg{Version=[3],New=[],Old=[an ]}
  Constraint_Error in some cases where it would not be raised if the
  permission was not used. @Chg{Version=[3],New=[See @Inconsistent2005Title for
  additional changes. ],Old=[]}This case is potentially inconsistent with Ada 95, but a compiler
  does not have to take advantage of these permissions for any Ada 95 code, so
  there should be little practical impact.]}
@end{Inconsistent95}

@begin{Incompatible95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[@Defn{incompatibilities with Ada 95} The entire
  business about return-by-reference types has been dropped. Instead, the
  @nt{expression} of a return statement of a limited type can only be an
  @nt{aggregate} or @nt{function_call} (see @RefSecNum{Limited Types}). This
  means that returning a global object or @nt{type_conversion}, legal in Ada
  95, is now illegal. Such functions can be converted to use anonymous access
  return types by adding @key{access} in the function definition and return
  statement, adding .@key{all} in uses, and adding @key{aliased} in the object
  declarations. This has the advantage of making the reference return semantics
  much clearer to the casual reader.]}

  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[We changed these rules so that functions,
  combined with the new rules for limited types (@RefSecnum{Limited Types}),
  can be used as build-in-place constructors for limited types. This reduces
  the differences between limited and nonlimited types, which will
  make limited types useful in more circumstances.]}
@end{Incompatible95}

@begin{Extend95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[@Defn{extensions to Ada 95}
  The @nt{extended_return_statement} is new. This provides a name for
  the object being returned, which reduces the copying needed to return
  complex objects (including no copying at all for limited objects). It also
  allows component-by-component construction of the return object.]}
@end{Extend95}

@begin{DiffWord95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[The wording was updated to support anonymous
  access return subtypes.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00318-02]}
  @ChgAdded{Version=[2],Text=[The term @lquotes@;return expression@rquotes@;
  was dropped because reviewers found it confusing when applied to the default
  @nt{expression} of an @nt{extended_return_statement}.]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00344-01],ARef=[AI95-00416-01]}
  @ChgAdded{Version=[2],Text=[Added accessibility checks to class-wide
  return statements. These checks could not fail in Ada 95 (as all of the
  types had to be declared at the same level, so the tagged type would
  necessarily have been at the same level as the type of the
  object).]}

  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00402-01],ARef=[AI95-00416-01]}
  @ChgAdded{Version=[2],Text=[Added accessibility checks to
  return statements for types with access discriminants. Since such
  types have to be limited in Ada 95, the @nt{expression} of a return statement
  would have been illegal in order for this check to fail.]}
@end{DiffWord95}

@begin{Inconsistent2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0050-1]}
  @ChgAdded{Version=[3],Text=[@Defn{inconsistencies with Ada 2005}
  @b<Correction:> The @ImplPermName allowing early raising of Constraint_Error was modified
  to remove the most common of these cases from the permission (returning an
  object with mutuable discriminants, where the return object is created with
  one set of discriminants and then changed to another. (The permission was
  also widened to allow the early check for constrained functions when that
  constraint is wrong.) However, there still is an unlikely case where the
  permission would allow an exception to be raised when none would be raised by the canonical
  semantics (when a return statement is abandoned). These changes can only
  remove the raising of an exception (or change the place where it is raised)
  compared to Ada 2005, so programs that depend on the previous behavior should
  be very rare.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0051-1],ARef=[AI05-0234-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Accessibility checks for
  access discriminants now depend on the master of the call rather than
  the point of declaration of the function. This will result in cases
  that used to raise Program_Error now running without raising any exception.
  This is technically inconsistent with Ada 2005 (as defined by Amendment 1),
  but it is unlikely that any real code depends on the raising of this
  exception.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0073-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:>
  Added a tag check for functions returning anonymous access-to-tagged types,
  so that dispatching of tag-indeterminate function works as expected.
  This is technically inconsistent with Ada 2005 (as defined by Amendment 1),
  but as the feature in question was newly added to Ada 2005, there should
  be little code that depends on the behavior that now raises an exception.]}
@end{Inconsistent2005}

@begin{Incompatible2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0053-1]}
  @ChgAdded{Version=[3],Text=[@Defn{incompatibilities with Ada 2005}@b<Correction:>
  Eliminated the @key{aliased} keyword from the syntax of
  @nt{extended_return_statement}s, as this would provide a way to get
  an aliased view of an object that is not
  necessarily aliased. This is technically incompatible, but since the
  feature was added in Ada 2005 and not widely implemented, it is
  very unlikely that it appears in existing programs.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0103-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Added wording to require
  static matching for unconstrained access types in extended return statements.
  This disallows adding or omitting null exclusions, and adding access
  constraints, in the declaration of the return object. While this is
  incompatible, the incompatible cases in question are either useless (access
  constraints @en the constraint can be given on an @nt{allocator} if necessary,
  and still must be given there even if given on the return object)
  or wrong (null exclusions @en null could be returned from a
  function declared to be null excluding), so we expect them to be extremely
  rare in practice.]}
@end{Incompatible2005}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0015-1],ARef=[AI05-0144-2]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}
  The return object of an @nt{extended_return_statement} can be declared
  constant; this works similarly to a constant object declaration.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0032-1]}
  @ChgAdded{Version=[3],Text=[Added wording to allow
  the @nt{return_subtype_indication} to have a specific type if the return
  subtype of the function is class-wide. Specifying the (specific) type of
  the return object is awkward without this change, and this is consistent
  with the way @nt{allocator}s work.]}
@end{Extend2005}

@begin{DiffWord2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0024-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Corrected the master check
  for tags since the masters may be for different tasks and thus incomparable.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0058-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Corrected the wording
  defining returns for @nt{extended_return_statement}s, since leaving by
  an exit or goto is considered @ldquote@;normal@rdquote completion of the
  statement.]}
@end{DiffWord2005}


@Comment{TBD:---@LabeledAddedRevisedClause{Version=[3],OldVersion=[2],New=[Non-returning Procedures],Old=[Pragma No_Return]}}
@LabeledAddedSubClause{Version=[3],Name=[Non-returning Procedures]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00329-01],ARef=[AI95-00414-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0229-1]}
@ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[Specifying aspect],Old=[A @nt{pragma}]}
No_Return @Chg{Version=[3],New=[to have the value True ],Old=[]}indicates
that a procedure cannot return normally@Redundant[; it may propagate
an exception or loop forever].]}
@begin{Discussion}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgRef{Version=[3],Kind=[Revised]}
@ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[Aspect],Old=[@nt{Pragma}]}
No_Deposit@Defn{No_Deposit aspect} will have to wait for
Ada @Chg{Version=[3],New=[2020],Old=[2017]}. :-)]}
@end{Discussion}

@begin{Syntax}
@begin{SyntaxText}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00329-01],ARef=[AI95-00414-01]}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
@ChgAdded{Version=[2],Type=[Leading],Text=[@Chg{Version=[3],New=[],Old=[The form
of a @nt{pragma} No_Return, which is a
representation pragma (see @RefSecNum{Operational and Representation Items}),
is as follows:]}]}
@end{SyntaxText}

@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgRef{Version=[3],Kind=[Deleted]}
@ChgAdded{Version=[2],Text=`@Chg{Version=[3],New=[],Old=[@AddedPragmaSyn`Version=[2],@key{pragma} @prag<No_Return>(@SynI{procedure_}@Syn2{local_name}{, @SynI{procedure_}@Syn2{local_name}});']}'}
@end{Syntax}

@begin{StaticSem}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0229-1]}
@ChgAdded{Version=[3],Type=[Leading],Text=[For a procedure or generic procedure, the following
language-defined representation aspect may be specified:]}
@begin{Description}
@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],Text=[No_Return@\The type of aspect No_Return is Boolean.
When aspect No_Return is True for an entity, the entity is said to be
@i<non-returning>.@Defn{non-returning}]}

@ChgRef{Version=[3],Kind=[Added]}
@ChgAdded{Version=[3],NoPrefix=[T],Text=[If directly specified, the
@nt{aspect_definition} shall be a static expression. @Redundant[This aspect is
never inherited;] if not directly specified, the aspect is False.]}
@end{Description}

@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0229-1]}@ChgNote{Moved from below}
@ChgAdded{Version=[3],Text=[If a generic procedure is non-returning, then so are
its instances. If a procedure declared within a generic unit is non-returning,
then so are the corresponding copies of that procedure in instances.]}

@end{StaticSem}


@begin{Legality}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00329-01],ARef=[AI95-00414-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0229-1]}
@ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[Aspect No_Return],
Old=[@Defn{non-returning}Each @SynI{procedure_}@nt{local_name} shall denote one
or more procedures or generic procedures; the denoted entities are
@i<non-returning>. The @SynI{procedure_}@nt{local_name}]} shall not
@Chg{Version=[3],New=[be specified for],Old=[denote]} a
null procedure nor an instance of a generic unit.]}

@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[A null procedure cannot have the appropriate
  non-returning semantics, as it does not raise an exception or loop forever.]}
@end{Reason}

@begin{Ramification}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0229-1]}
  @ChgAdded{Version=[2],Text=[The procedure can be abstract.@Chg{Version=[3],New=[],
  Old=[ The denoted declaration can be a @nt{renaming_declaration} if it obeys the usual rules
  for representation pragmas: the renaming has to occur immediately within the
  same declarative region as the renamed subprogram.]} If a non-returning
  procedure is renamed (anywhere) calls through the new name still have the
  non-returning semantics.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00329-01],ARef=[AI95-00414-01]}
@ChgAdded{Version=[2],Text=[A return statement shall not apply to a
non-returning procedure or generic procedure.]}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00414-01]}
@ChgAdded{Version=[2],Text=[A procedure shall be non-returning if it overrides
a dispatching non-returning procedure.
@PDefn{generic contract issue}
In addition to the places where
@LegalityTitle normally apply (see @RefSecNum{Generic Instantiation}),
this rule applies also in the private part of an instance of a generic unit.]}

@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[This ensures that dispatching calls to
  non-returning procedures will, in fact, not return.]}
@end{Reason}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00414-01]}
@ChgAdded{Version=[2],Text=[If a renaming-as-body completes a non-returning
procedure declaration, then the renamed procedure shall be non-returning.]}

@begin{Reason}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[This ensures that no extra code is needed to
  implement the renames (that is, no wrapper is needed) as the body has
  the same property.]}
@end{Reason}

@end{Legality}

@begin{StaticSem}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00329-01],ARef=[AI95-00414-01]}
@ChgRef{Version=[3],Kind=[Deleted],ARef=[AI05-0229-1]}
@ChgAdded{Version=[2],Text=[@Chg{Version=[3],New=[],Old=[If a generic procedure
is non-returning, then so are its instances. If a procedure declared within
a generic unit is non-returning, then so are the corresponding copies of
that procedure in instances.]}]}
@end{StaticSem}

@begin{RunTime}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00329-01],ARef=[AI95-00414-01]}
@ChgAdded{Version=[2],Text=[If the body of a non-returning procedure completes
normally, Program_Error is raised at the point of the call.
@Defn2{Term=[Program_Error],Sec=(raised by failure of run-time check)}]}
@end{RunTime}
@begin{Discussion}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[Note that there is no name for suppressing
  this check, since the check represents a bug, imposes no time overhead,
  and minimal space overhead (since it can usually be statically eliminated
  as dead code).]}
@end{Discussion}
@begin{ImplNote}
  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[If a non-returning procedure tries to return, we
  raise Program_Error. This is stated as happening at the call site, because we
  do not wish to allow the procedure to handle the exception (and then,
  perhaps, try to return again!). However, the expected run-time model is that
  the compiler will generate @key{raise} Program_Error at the end of the
  procedure body (but not handleable by the procedure itself), as opposed to
  doing it at the call site. (This is just like the typical run-time model for
  functions that fall off the end without returning a value). The reason is
  indirect calls: in P.@key{all}(...);, the compiler cannot know whether P
  designates a non-returning procedure or a normal one. Putting the @key{raise}
  Program_Error in the procedure's generated code solves this problem neatly.]}

  @ChgRef{Version=[2],Kind=[AddedNormal]}
  @ChgAdded{Version=[2],Text=[Similarly, if one passes a non-returning
  procedure to a generic formal parameter, the compiler cannot know this at
  call sites (in shared code implementations); the raise-in-body solution
  deals with this neatly.]}
@end{ImplNote}

@begin{Examples}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00433-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0229-1]}
@ChgAdded{Version=[2],Text=[@key(procedure) Fail(Msg : String)@Chg{Version=[3],New=[],Old=[;]}  --@ExamCom[ raises Fatal_Error exception]
@Chg{Version=[3],New=[   @key(with)],Old=[@key(pragma)]} No_Return@Chg{Version=[3],New=[ => True],Old=[(Fail)]};
   --@ExamCom[ Inform compiler and reader that procedure never returns normally]]}
@end{Example}
@end{Examples}

@begin{Extend95}
  @ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00329-01],ARef=[AI95-00414-01]}
  @ChgAdded{Version=[2],Text=[@Defn{extensions to Ada 95}
  @nt{Pragma} No_Return is new.]}
@end{Extend95}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0229-1]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}
  Aspect No_Return is new; @nt{pragma} No_Return is now obsolescent.]}
@end{Extend2005}


@LabeledClause{Overloading of Operators}

@begin{Intro}
@Defn{operator}
@Defn{user-defined operator}
@Defn2{Term=[operator], Sec=(user-defined)}
An @i{operator} is a function whose @nt{designator} is an
@nt<operator_symbol>.
@Redundant[Operators, like other functions, may be overloaded.]
@end{Intro}

@begin{Resolution}
Each use of a unary or binary operator is equivalent to a
@nt{function_call} with @SynI{function_}@nt{prefix} being the
corresponding @nt{operator_symbol}, and with (respectively) one or
two positional actual parameters being the operand(s) of the operator
(in order).
@begin{Honest}
We also use the term operator
(in Section 4 and in @RefSecNum{Subprogram Declarations})
to refer to one of the syntactic categories
defined in @RefSec{Operators and Expression Evaluation}
whose names end with @lquotes@;_operator:@rquotes@;
@nt<logical_@!operator>,
@nt<relational_@!operator>,
@nt<binary_@!adding_@!operator>,
@nt<unary_@!adding_@!operator>,
@nt<multiplying_@!operator>, and
@nt<highest_@!precedence_@!operator>.
@end{Honest}
@begin{Discussion}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0005-1]}
@ChgAdded{Version=[3],Text=[This equivalence extends to uses of
@nt{function_call} in most other language rules. However, as
often happens, the equivalence is not perfect, as operator
calls are not a @nt{name}, while a @nt{function_call} is a
@nt{name}. Thus, operator calls cannot be used in contexts
that require a @nt{name} (such as a rename of an object).
A direct fix for this problem would be very disruptive, and thus
we have not done that. However, qualifying an operator call
can be used as a workaround in contexts that require a @nt{name}.]}
@end{Discussion}
@end{Resolution}

@begin{Legality}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0143-1]}
The @nt{subprogram_specification} of a unary or binary operator shall have
one or two parameters, respectively.@Chg{Version=[3],New=[ The parameters
shall be of mode @key[in].],Old=[]}
A generic function instantiation whose @nt{designator} is an
@nt{operator_symbol} is only allowed if the specification of the
generic function has the corresponding number of
parameters@Chg{Version=[3],New=[ of mode @key[in] and no other
parameters],Old=[]}.

@nt{Default_expression}s are not allowed for the parameters of an operator
(whether the operator is declared with an explicit
@nt{subprogram_specification} or by a @nt{generic_instantiation}).

An explicit declaration of "/=" shall not have a result
type of the predefined type Boolean.
@end{Legality}

@begin{StaticSem}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0128-1]}
@Chg{Version=[3],New=[An explicit],Old=[A]} declaration of "="
whose result type is Boolean implicitly declares
@Chg{Version=[3],New=[an operator],Old=[a declaration of]} "/=" that
gives the complementary result.@Defn{/= operator}
@begin{Discussion}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0128-1]}
@ChgAdded{Version=[3],Text=[A "/=" defined by this rule is considered
user-defined, which means that it will be inherited by a derived type.
@ldquote@;User-defined@rdquote means @ldquote@;not language-defined@rdquote for
the purposes of inheritance, that is anything other than predefined operators.
6.6(6): @Defn{Number of the Beast}]}
@end{Discussion}
@end{StaticSem}

@begin{Notes}
The operators "+" and "@en@;" are both unary and binary operators,
and hence may be overloaded with both one- and two-parameter functions.
@end{Notes}

@begin{Examples}
@leading@keepnext@i{Examples of user-defined operators:}
@begin{Example}
@key[function] "+" (Left, Right : Matrix) @key[return] Matrix;
@key[function] "+" (Left, Right : Vector) @key[return] Vector;
@Comment{Blank line}
--@ExamCom{  assuming that A, B, and C are of the type Vector}
--@ExamCom{  the following two statements are equivalent:}
@Comment{Blank line}
A := B + C;
A := "+"(B, C);
@end{Example}
@end{Examples}

@begin{Extend83}
@Defn{extensions to Ada 83}
Explicit declarations of "=" are now permitted for any
combination of parameter and result types.

Explicit declarations of "/=" are now permitted, so long
as the result type is not Boolean.
@end{Extend83}

@begin{DiffWord2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0128-1]}
  @ChgAdded{Version=[3],Text=[@b<Correction:> Corrected the wording
  so that only explicit declarations of "=" cause an implicit declaration
  of "/="; otherwise, we could get multiple implicit definitions of "/="
  without an obvious way to chose between them.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0143-1]}
  @ChgAdded{Version=[3],Text=[Added wording so that operators only allow
  parameters of mode @key[in]. This was made necessary by the elimination
  elsewhere of the restriction that function parameters be only of
  mode @key[in].]}
@end{DiffWord2005}


@Comment{@RMNewPage@Comment{For printed RM Ada 2005} - Now Ada 2012}
@LabeledAddedClause{Version=[2],Name=[Null Procedures]}

@begin{Intro}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
@ChgAdded{Version=[2],Text=[A @nt<null_procedure_declaration> provides a shorthand
to declare a procedure with an empty body.]}
@end{Intro}

@begin{Syntax}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0183-1]}
@AddedSyn{Version=[2],lhs=<@Chg{Version=[2],New=<null_procedure_declaration>,Old=<>}>,
rhs="@Chg{Version=[2],New=<
   [@Syn2{overriding_indicator}]
   @Syn2{procedure_specification} @key{is} @key{null}@Chg{Version=[3],New=<
       [@Syn2{aspect_specification}]>,Old=[]};>,Old=<>}"}
@end{Syntax}

@begin{Legality}
@ChgRef{Version=[3],Kind=[Added],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[If a @nt{null_procedure_declaration} is a completion,
it shall be the completion of a @nt{subprogram_declaration} or
@nt{generic_subprogram_declaration}. The profile of a
@nt{null_procedure_declaration} that completes a declaration shall
conform fully to that of the declaration.@Defn2{Term=[full conformance],Sec=(required)}]}
@end{Legality}

@begin{StaticSem}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0177-1]}
@ChgAdded{Version=[2],Text=[A @nt<null_procedure_declaration> declares a @i<null
procedure>.@Defn{null procedure}@Defn2{Term=[procedure],Sec=[null]}
A completion is not allowed for a @nt<null_procedure_declaration>@Chg{Version=[3],New=[,
however, a @nt{null_procedure_declaration} can complete a previous declaration],Old=[]}.]}
@begin{Reason}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[There are no null functions because the return
value has to be constructed somehow; a function that always raises
Program_Error doesn't seem very useful or worth the complication.]}
@end{Reason}
@end{StaticSem}

@begin{RunTime}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
@ChgAdded{Version=[2],Text=[The execution of a null procedure is invoked by a subprogram call.
For the execution of a subprogram call on a null procedure, the execution of
the @nt<subprogram_body> has no effect.]}
@begin{Ramification}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[Thus, a null procedure is equivalent to the body]}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[@key{begin}
   @key{null};
@key{end};]}
@end{Example}
@ChgRef{Version=[2],Kind=[AddedNormal]}
@ChgAdded{Version=[2],Text=[with the exception that a null procedure can be used in
place of a procedure specification.]}
@end{Ramification}

@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
@ChgRef{Version=[3],Kind=[Revised],ARef=[AI05-0177-1]}
@ChgAdded{Version=[2],Text=[@PDefn2{Term=[elaboration], Sec=(null_procedure_declaration)}
The elaboration of a @nt{null_procedure_declaration} has no
@Chg{Version=[3],New=[other ],Old=[]}effect@Chg{Version=[3],New=[ than to
establish that the null procedure can be called without failing the
Elaboration_Check],Old=[]}.]}
@end{RunTime}

@begin{Examples}
@begin{Example}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00433-01]}
@ChgAdded{Version=[2],Text=[@key(procedure) Simplify(Expr : @key(in out) Expression) @key(is null); --@ExamCom[ see @RefSecNum{Tagged Types and Type Extensions}]
--@ExamCom[ By default, Simplify does nothing, but it may be overridden in extensions of Expression]]}
@end{Example}
@end{Examples}

@begin{Extend95}
@ChgRef{Version=[2],Kind=[AddedNormal],ARef=[AI95-00348-01]}
@ChgAdded{Version=[2],Text=[@Defn{extensions to Ada 95}
Null procedures are new.]}
@end{Extend95}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}
  A @nt{null_procedure_declaration} can now be a completion.]}

  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0183-1]}
  @ChgAdded{Version=[3],Text=[An optional @nt{aspect_specification}
  can be used in a @nt{null_procedure_declaration}.
  This is described in @RefSecNum{Aspect Specifications}.]}
@end{Extend2005}


@LabeledAddedClause{Version=[3],Name=[Expression Functions]}

@begin{Intro}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[An @nt{expression_function_declaration} provides a
shorthand to declare a function whose body consists of a single return
statement.]}
@end{Intro}

@begin{Syntax}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI95-0177-1]}
@AddedSyn{Version=[3],lhs=<@Chg{Version=[3],New=<expression_function_declaration>,Old=<>}>,
rhs="@Chg{Version=[3],New=<
   [@Syn2{overriding_indicator}]
   @Syn2{function_specification} @key{is}
       (@Syn2{expression})
       [@Syn2{aspect_specification}];>,Old=<>}"}
@end{Syntax}

@begin{Resolution}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[The expected type for the @nt{expression} of an
@nt{expression_@!function_@!declaration} is the result type (see
@RefSecNum{Return Statements}) of the function.@PDefn2{Term=[expected type],
Sec=(expression of expression function)}]}
@end{Resolution}

@begin{Legality}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[If an @nt{expression_@!function_@!declaration} is a
completion, it shall be the completion of a @nt{subprogram_declaration} or
@nt{generic_subprogram_declaration}. The profile of an
@nt{expression_@!function_@!declaration} that completes a declaration
shall conform fully to that of the declaration.@Defn2{Term=[full conformance],Sec=(required)}]}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[If the result subtype has one or more unconstrained
access discriminants, the accessibility level of the anonymous access type of
each access discriminant, as determined by the @nt{expression} of the expression
function, shall not be statically deeper than that of the master that elaborated
the @nt{expression_@!function_@!declaration}.]}

@begin{Ramification}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[This can only fail if the discriminant is an
  access to a part of a non-aliased parameter, as there can be no local
  declarations here.]}
@end{Ramification}

@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[We don't need to repeat any of the other
  @LegalityTitle for return statements since none of them can fail here: the
  implicit return statement has to apply to this function (and isn't nested in
  something), there clearly is a return statement in this function, and the
  static classwide accessibility check cannot fail as a tagged type cannot be
  declared locally in an expression function.]}
@end{Discussion}
@end{Legality}

@begin{StaticSem}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[An @nt{expression_@!function_@!declaration} declares
an @i{expression function}.@Defn{exception function}@Defn2{Term=[function],Sec=[expression]}
A completion
is not allowed for an @nt{expression_@!function_@!declaration}, however an
@nt{expression_@!function_@!declaration} can complete a previous declaration.]}
@end{StaticSem}

@begin{RunTime}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[ The execution of an expression function is invoked
by a subprogram call. For the execution of a subprogram call on an expression
function, the execution of the @nt{subprogram_body} is equivalent to a function
body containing only a @nt{simple_return_statement} whose @nt{expression} is
that of the expression function.]}

@begin{Discussion}
  @ChgRef{Version=[3],Kind=[AddedNormal]}
  @ChgAdded{Version=[3],Text=[The last sentence effectively means that all of
  the dynamic wording in @RefSecNum{Return Statements} applies as needed, and we
  don't have to repeat it here.]}
@end{Discussion}

@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[@PDefn2{Term=[elaboration],
Sec=(expression_function_declaration)}The elaboration of an
@nt{expression_@!function_@!declaration} has no other effect than to establish
that the expression function can be called without failing the
Elaboration_Check.]}
@end{RunTime}

@begin{Examples}
@begin{Example}
@ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
@ChgAdded{Version=[3],Text=[@key(function) Is_Origin (P : @key[in] Point) @key[return] Boolean @key[is] -- @Examcom[see @RefSecNum{Tagged Types and Type Extensions}]
   (P.X = 0.0 @key[and] P.Y = 0.0);]}
@end{Example}
@end{Examples}

@begin{Extend2005}
  @ChgRef{Version=[3],Kind=[AddedNormal],ARef=[AI05-0177-1]}
  @ChgAdded{Version=[3],Text=[@Defn{extensions to Ada 2005}
  Expression functions are new in Ada 2012.]}
@end{Extend2005}

