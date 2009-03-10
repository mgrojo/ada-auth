@Part(environ, root="asis.msm")
@comment{$Source: e:\\cvsroot/ARM/ASIS/environ.mss,v $}
@comment{$Revision: 1.4 $ $Date: 2009/03/07 06:33:31 $}

@LabeledSection{package Asis.Ada_Environments}

@Chg{Version=[1],New=[The library package @ChildUnit{Parent=[Asis],Child=[Ada_Environments]}Asis.Ada_Environments
shall exist. The package
shall provide interfaces equivalent to those described in the
following subclauses.],
Old=[@f{@key[package] @ChildUnit{Parent=[Asis],Child=[Ada_Environments]}Asis.Ada_Environments @key[is]}]}

Asis.Ada_Environments encapsulates a set of queries that map physical Ada
compilation and program execution environments to logical ASIS environments.


@LabeledClause{function Default_Name}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Default_Name} @key[return] Wide_String;
@end{Example}

Returns the default context name. If there is no default context name, a
null string is returned.
@end{DescribeCode}


@LabeledClause{function Default_Parameters}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Default_Parameters} @key[return] Wide_String;
@end{Example}

Returns the default context parameters. If there are no default context
parameters, a null string is returned.
@end{DescribeCode}


@LabeledClause{procedure Associate}

@begin{DescribeCode}
@begin{Example}
@key[procedure] @AdaSubDefn{Associate}
                 (The_Context : @key[in out] Asis.Context;
                  Name        : @key[in]     Wide_String;
                  Parameters  : @key[in]     Wide_String := Default_Parameters);
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context to associate.
Name @Chg{Version=[1],New=[specifies],Old=[     @en Specifies]} the name for the Context association.
Parameters @Chg{Version=[1],New=[specifies],Old=[ @en Specifies]} parameters to use when opening the Context.

Used to give name and parameter associations to a Context. The
Has_Associations query is used to test whether or not a Context has
been given name and parameter associations. The Name and Parameters
queries are used to examine name and parameter associations.

A Context has at most one set of name/parameter values associated with
it at any time. Name and parameter associations cannot be modified while a
Context is open  Previous name and parameters associations for this Context
are replaced by this call.

ASIS implementations are encouraged, but not required, to validate the
Parameters string immediately. It is recognized that some options cannot
be completely validated until the Open is performed. An invalid Parameters
value is reported by raising ASIS_Failed with a Status of Parameter_Error.

Raises ASIS_Inappropriate_Context if The_Context is open.
@end{DescribeCode}


@LabeledClause{procedure Open}

@begin{DescribeCode}
@begin{Example}
@key[procedure] @AdaSubDefn{Open} (The_Context : @key[in] out Asis.Context);
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
to open.

Opens the ASIS Context using the Context's associated name and parameter
values.

Raises ASIS_Inappropriate_Context if The_Context is already open or if it
is uninitialized (does not have associated name and parameter values).

Raises ASIS_Failed if The_Context could not be opened for any reason. The
most likely Status values are Name_Error, Use_Error, Data_Error, and
Parameter_Error. Other possibilities include Storage_Error and
Capacity_Error.
@end{DescribeCode}


@LabeledClause{procedure Close}

@begin{DescribeCode}
@begin{Example}
@key[procedure] @AdaSubDefn{Close} (The_Context : @key[in] out Asis.Context);
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
to close.

Closes the ASIS Context. Any previous Context name and parameter
associations are retained. This allows the same Context to be re-opened
later with the same associations.

All Compilation_Unit and Element values obtained from The_Context become
invalid when it is closed. Subsequent calls to ASIS services using such
invalid Compilation_Unit or Element values are erroneous. ASIS
implementations will attempt to detect such usage and raise ASIS_Failed in
response. Applications should be aware that the ability to detect the use
of such "dangling references" is implementation specific and not all
implementations are able to raise ASIS_Failed at the appropriate
points. Thus, applications that attempt to utilize invalid values may
exhibit unpredictable behavior.

Raises ASIS_Inappropriate_Context if The_Context is not open.
@end{DescribeCode}


@LabeledClause{procedure Dissociate}

@begin{DescribeCode}
@begin{Example}
@key[procedure] @AdaSubDefn{Dissociate} (The_Context : @key[in] out Asis.Context);
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
whose name and parameter associations are to be cleared.

Severs all previous associations for The_Context. A Context that does not
have associations (is uninitialized) is returned unchanged. The
variable The_Context is returned to its uninitialized state.

Contexts that have been given Names and Parameters should be Dissociated
when they are no longer necessary. Some amount of program storage can be
tied up by the stored Name and Parameter strings. This space is only
freed when a Context is Dissociated or when ASIS is Finalized.

This operation has no physical affect on any implementor's Ada environment.

Raises ASIS_Inappropriate_Context if The_Context is open.
@end{DescribeCode}


@LabeledClause{function Is_Equal (context)}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Is_Equal} (Left  : @key[in] Asis.Context;
                   Right : @key[in] Asis.Context) @key[return] Boolean;
@end{Example}

Left @Chg{Version=[1],New=[specifies],Old=[  @en Specifies]} the first Context.
Right @Chg{Version=[1],New=[specifies],Old=[ @en Specifies]} the second Context.

Returns True if Left and Right designate the same set of associated
compilation units. The Context variables may be open or closed.

Unless both Contexts are open, this operation is implemented as a pair of
simple string comparisons between the Name and Parameter associations for
the two Contexts. If both Contexts are open, this operation acts as a
set comparison and returns True if both sets contain the same units (all
unit versions are included in the comparison).
@end{DescribeCode}

@begin{UsageNote}
@leading@;With some implementations, Is_Equal may be True before the Contexts
are opened, but may be False after the Contexts are open.
One possible cause for this is a sequence of events such as:

@begin{Enumerate}
ASIS program A opens the Left Context for READ,

non-ASIS program B opens the Context for UPDATE, and creates a new
version of the implementor Context,

ASIS program A opens the Right Context for READ, and gets the new version.
@end{Enumerate}
@end{UsageNote}


@LabeledClause{function Is_Identical (context)}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Is_Identical} (Left  : @key[in] Asis.Context;
                       Right : @key[in] Asis.Context) @key[return] Boolean;
@end{Example}

Left @Chg{Version=[1],New=[specifies],Old=[  @en Specifies]} the first Context.
Right @Chg{Version=[1],New=[specifies],Old=[ @en Specifies]} the second Context.

Returns True if Left and Right both designate the value associated with
one specific ASIS Context variable.

Returns False otherwise or if either Context is not open.
@end{DescribeCode}

@begin{UsageNote}
No two physically separate open Context variables are ever Is_Identical.
The value associated with an open ASIS Context variable is also directly
associated with every Compilation_Unit or Element derived from that
Context. It is possible to obtain these Context values by way of the
Enclosing_Context and the Enclosing_Compilation_Unit queries. These
Context values can be tested for identity with each other or with
specific Context variables. An open ASIS Context variable and an
Enclosing_Context value are only Is_Identical if the Compilation_Unit in
question was derived specifically from that open ASIS Context variable.
@end{UsageNote}


@LabeledClause{function Exists (context)}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Exists} (The_Context : @key[in] Asis.Context) @key[return] Boolean;
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} a Context
with associated name and parameter values.

Returns True if The_Context is open or if The_Context designates an Ada
environment that can be determined to exist.

Returns False for any uninitialized The_Context variable.
@end{DescribeCode}

@begin{ImplPerm}
No guarantee is made that The_Context is readable or that an Open
operation on The_Context would succeed. The associated
parameter value for The_Context may not be fully validated by this
simple existence check. It may contain information that can only be
verified by an Open.
@end{ImplPerm}


@LabeledClause{function Is_Open}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Is_Open} (The_Context : @key[in] Asis.Context) @key[return] Boolean;
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
to check.

Returns True if The_Context is currently open.
@end{DescribeCode}


@LabeledClause{function Has_Associations}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Has_Associations} (The_Context : @key[in] Asis.Context) @key[return] Boolean;
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
to check.

Returns True if name and parameter values have been associated with
The_Context.

Returns False if The_Context is uninitialized.
@end{DescribeCode}


@LabeledClause{function Name (context)}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Name} (The_Context : @key[in] Asis.Context) @key[return] Wide_String;
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
to check.

Returns the Name value associated with The_Context.

Returns a null string if The_Context is uninitialized.
@end{DescribeCode}


@LabeledClause{function Parameters (context)}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Parameters} (The_Context : @key[in] Asis.Context) @key[return] Wide_String;
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
to check.

Returns the Parameters value associated with The_Context.

Returns a null string if The_Context is uninitialized.
@end{DescribeCode}


@LabeledClause{function Debug_Image (context)}

@begin{DescribeCode}
@begin{Example}
@key[function] @AdaSubDefn{Debug_Image} (The_Context : @key[in] Asis.Context) @key[return] Wide_String;
@end{Example}

The_Context @Chg{Version=[1],New=[specifies],Old=[@en Specifies]} the Context
to represent.

Returns a string value containing implementation-defined debugging
information associated with The_Context.

The return value uses Asis.Text.Delimiter_Image to separate lines in
multi-line results. The return value is not terminated with
Asis.Text.Delimiter_Image.

Returns a null string if The_Context is uninitialized.

These values are intended for two purposes. They are suitable for
inclusion in problem reports sent to the ASIS implementor. They can be
presumed to contain information useful when debugging the implementation
itself. They are also suitable for use by the ASIS application when printing
simple application debugging messages during application development.
They are intended to be, to some worthwhile degree, intelligible to the user.
@end{DescribeCode}

@begin{Example}
@ChgDeleted{Version=[1],Text=[@key[end] Asis.Ada_Environments;]}
@end{Example}
