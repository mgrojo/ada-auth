@comment{ $Source: e:\\cvsroot/ARM/Source/pre_standard.mss,v $ }
@comment{ $Revision: 1.4 $ $Date: 2000/04/19 00:07:04 $ $Author: Randy $ }
@Part(predefstandard, Root="ada.mss")

@SetPageHeadingsNoPage{$Date: 2000/04/19 00:07:04 $}

@LabeledClause{The Package Standard}

@begin{Intro}
This clause outlines the specification of the package Standard
containing all predefined identifiers in the language.
@PDefn{unspecified}
The corresponding package body is not specified by the language.

The operators that are predefined for the types declared in the
package Standard are given in comments since they are implicitly
declared.
@Defn2{Term=[italics],Sec=(pseudo-names of anonymous types)}
Italics are used for pseudo-names of anonymous types (such
as @i{root_real}) and for undefined information (such as
@i{implementation-defined}).
@begin{Ramification}
  All of the predefined operators are of convention Intrinsic.
@end{Ramification}

@end{Intro}

@begin{StaticSem}
The  library package Standard has the following declaration:
@ImplDef{The names and characteristics of the numeric subtypes declared in
the visible part of package Standard.}
@begin{Example}
@RootLibUnit{Standard}
@key[package] Standard @key[is]
   @key[pragma] Pure(Standard);

@LangDefType{Package=[Standard],Type=[Boolean]}
   @key[type] Boolean @key[is] (False, True);
@Hinge{}

   --@i{ The predefined relational operators for this type are as follows:}
@Hinge{}

   -- @key[function] "="   (Left, Right : Boolean) @key[return] Boolean;
   -- @key[function] "/="  (Left, Right : Boolean) @key[return] Boolean;
   -- @key[function] "<"   (Left, Right : Boolean) @key[return] Boolean;
   -- @key[function] "<="  (Left, Right : Boolean) @key[return] Boolean;
   -- @key[function] ">"   (Left, Right : Boolean) @key[return] Boolean;
   -- @key[function] ">="  (Left, Right : Boolean) @key[return] Boolean;
@Hinge{}

   --@i{ The predefined logical operators and the predefined logical}
   --@i{ negation operator are as follows:}
@Hinge{}

   -- @key[function] "@key[and]" (Left, Right : Boolean) @key[return] Boolean;
   -- @key[function] "@key[or]"  (Left, Right : Boolean) @key[return] Boolean;
   -- @key[function] "@key[xor]" (Left, Right : Boolean) @key[return] Boolean;
@Hinge{}

   -- @key[function] "@key[not]" (Right : Boolean) @key[return] Boolean;
@Hinge{}

   --@i{ The integer type @i{root_integer} is predefined.}
   --@i{ The corresponding universal type is @i{universal_integer}.}
@Hinge{}

@LangDefType{Package=[Standard],Type=[Integer]}
   @key[type] Integer @key[is] @key{range} @i{implementation-defined};
@Hinge{}

   @key[subtype] Natural  @key[is] Integer @key[range] 0 .. Integer'Last;
   @key[subtype] Positive @key[is] Integer @key[range] 1 .. Integer'Last;
@Hinge{}

   --@i{ The predefined operators for type Integer are as follows:}
@Hinge{}

   -- @key[function] "="  (Left, Right : Integer'Base) @key[return] Boolean;
   -- @key[function] "/=" (Left, Right : Integer'Base) @key[return] Boolean;
   -- @key[function] "<"  (Left, Right : Integer'Base) @key[return] Boolean;
   -- @key[function] "<=" (Left, Right : Integer'Base) @key[return] Boolean;
   -- @key[function] ">"  (Left, Right : Integer'Base) @key[return] Boolean;
   -- @key[function] ">=" (Left, Right : Integer'Base) @key[return] Boolean;
@Hinge{}

   -- @key[function] "+"   (Right : Integer'Base) @key[return] Integer'Base;
   -- @key[function] "-"   (Right : Integer'Base) @key[return] Integer'Base;
   -- @key[function] "@key[abs]" (Right : Integer'Base) @key[return] Integer'Base;
@Hinge{}

   -- @key[function] "+"   (Left, Right : Integer'Base) @key[return] Integer'Base;
   -- @key[function] "-"   (Left, Right : Integer'Base) @key[return] Integer'Base;
   -- @key[function] "*"   (Left, Right : Integer'Base) @key[return] Integer'Base;
   -- @key[function] "/"   (Left, Right : Integer'Base) @key[return] Integer'Base;
   -- @key[function] "@key[rem]" (Left, Right : Integer'Base) @key[return] Integer'Base;
   -- @key[function] "@key[mod]" (Left, Right : Integer'Base) @key[return] Integer'Base;
@Hinge{}

   -- @key[function] "**"  (Left : Integer'Base; Right : Natural) @key[return] Integer'Base;
@Hinge{}

   --@i{ The specification of each operator for the type}
   --@i{ @i{root_integer}, or for any additional predefined integer}
   --@i{ type, is obtained by replacing Integer by the name of the type}
   --@i{ in the specification of the corresponding operator of the type}
   --@i{ Integer.  The right operand of the exponentiation operator}
   --@i{ remains as subtype Natural.}
@Hinge{}

   --@i{ The floating point type @i{root_real} is predefined.}
   --@i{ The corresponding universal type is @i{universal_real}.}
@Hinge{}

@LangDefType{Package=[Standard],Type=[Float]}
   @key[type] Float @key[is] @key{digits} @i{implementation-defined};
@Hinge{}

   --@i{ The predefined operators for this type are as follows:}
@Hinge{}

   -- @key[function] "="   (Left, Right : Float) @key[return] Boolean;
   -- @key[function] "/="  (Left, Right : Float) @key[return] Boolean;
   -- @key[function] "<"   (Left, Right : Float) @key[return] Boolean;
   -- @key[function] "<="  (Left, Right : Float) @key[return] Boolean;
   -- @key[function] ">"   (Left, Right : Float) @key[return] Boolean;
   -- @key[function] ">="  (Left, Right : Float) @key[return] Boolean;
@Hinge{}

   -- @key[function] "+"   (Right : Float) @key[return] Float;
   -- @key[function] "-"   (Right : Float) @key[return] Float;
   -- @key[function] "@key[abs]" (Right : Float) @key[return] Float;
@Hinge{}

   -- @key[function] "+"   (Left, Right : Float) @key[return] Float;
   -- @key[function] "-"   (Left, Right : Float) @key[return] Float;
   -- @key[function] "*"   (Left, Right : Float) @key[return] Float;
   -- @key[function] "/"   (Left, Right : Float) @key[return] Float;
@Hinge{}

   -- @key[function] "**"  (Left : Float; Right : Integer'Base) @key[return] Float;
@Hinge{}

   --@i{ The specification of each operator for the type  @i{root_real},  or  for}
   --@i{ any  additional  predefined  floating  point  type,  is  obtained  by}
   --@i{ replacing  Float by the name of  the type in the specification of the}
   --@i{ corresponding  operator  of  the  type  Float.}
@Hinge{}

   --@i{ In  addition,  the  following operators are predefined for the root}
   --@i{ numeric types:}
@Hinge{}

   @key[function] "*" (Left : @i{root_integer}; Right : @i{root_real})
     @key[return] @i{root_real};
@Hinge{}

   @key[function] "*" (Left : @i{root_real};    Right : @i{root_integer})
     @key[return] @i{root_real};
@Hinge{}

   @key[function] "/" (Left : @i{root_real};    Right : @i{root_integer})
     @key[return] @i{root_real};
@Hinge{}

   --@i{ The type universal_fixed is predefined.}
   --@i{ The only multiplying operators defined between}
   --@i{ fixed point types are}

   @key[function] "*" (Left : @i[universal_fixed]; Right : @i[universal_fixed])
     @key[return] @i[universal_fixed];

   @key[function] "/" (Left : @i[universal_fixed]; Right : @i[universal_fixed])
     @key[return] @i[universal_fixed];
@Hinge{}
@comment{blank line}
@comment{blank line}
      --@i{ The declaration of type Character is based on the standard ISO 8859-1 character set.}

      --@i{ There are no character literals corresponding to the positions for control characters.}
      --@i{ They are indicated in italics in this definition.  See @refsecnum[Character Types].}
@comment[blank line]
@LangDefType{Package=[Standard],Type=[Character]}
   @key[type] Character @key[is]
@tabclear()
      @^      @^      @^      @^         @^      @^      @^      @^         @^
     (@i[nul], @\@i[soh], @\@i[stx], @\@i[etx], @\@i[eot], @\@i[enq], @\@i[ack], @\@i[bel], @\@Charnote[--@i{0 (16#00#) .. 7 (16#07#)}]
      @i[bs], @\@i[ht], @\@i[lf], @\@i[vt], @\@i[ff], @\@i[cr], @\@i[so], @\@i[si], @\@charnote[--@i{8 (16#08#) .. 15 (16#0F#)}]
@comment{blank line}
      @i[dle], @\@i[dc1], @\@i[dc2], @\@i[dc3], @\@i[dc4], @\@i[nak], @\@i[syn], @\@i[etb], @\@charnote[--@i{16 (16#10#) .. 23 (16#17#)}]
      @i[can], @\@i[em], @\@i[sub], @\@i[esc], @\@i[fs], @\@i[gs], @\@i[rs], @\@i[us], @\@charnote[--@i{24 (16#18#) .. 31 (16#1F#)}]
@comment{blank line}
      ' ',  '!',  '"',  '#',     '$',  '%',  '&',  ''', @\@charnote[--@i{32 (16#20#) .. 39 (16#27#)}]
      '(',  ')',  '*',  '+',     ',',  '-',  '.',  '/', @\@charnote[--@i{40 (16#28#) .. 47 (16#2F#)}]
@comment{blank line}
      '0',  '1',  '2',  '3',     '4',  '5',  '6',  '7', @\@charnote[--@i{48 (16#30#) .. 55 (16#37#)}]
      '8',  '9',  ':',  ';',     '<',  '=',  '>',  '?', @\@charnote[--@i{56 (16#38#) .. 63 (16#3F#)}]
@comment{blank line}
      '@@',  'A',  'B',  'C',     'D',  'E',  'F',  'G', @\@charnote[--@i{64 (16#40#) .. 71 (16#47#)}]
      'H',  'I',  'J',  'K',     'L',  'M',  'N',  'O', @\@charnote[--@i{72 (16#48#) .. 79 (16#4F#)}]
@comment{blank line}
      'P',  'Q',  'R',  'S',     'T',  'U',  'V',  'W', @\@charnote[--@i{80 (16#50#) .. 87 (16#57#)}]
      'X',  'Y',  'Z',  '[',     '\',  ']',  '^',  '_',  @\@charnote[--@i{88 (16#58#) .. 95 (16#5F#)}]
@comment{blank line}
      '`',  'a',  'b',  'c',     'd',  'e',  'f',  'g', @\@charnote[--@i{96 (16#60#) .. 103 (16#67#)}]
      'h',  'i',  'j',  'k',     'l',  'm',  'n',  'o', @\@charnote[--@i{104 (16#68#) .. 111 (16#6F#)}]
@comment{blank line}
      'p',  'q',  'r',  's',     't',  'u',  'v',  'w', @\@charnote[--@i{112 (16#70#) .. 119 (16#77#)}]
      'x',  'y',  'z',  '{',     '|',  '}',  '~',  @i[del], @\@charnote[--@i{120 (16#78#) .. 127 (16#7F#)}]
@Comment{Blank line}

      @i[reserved_128], @\@i[reserved_129], @\@i[bph], @\@i[nbh], @\ @\ @\@charnote[--@i{128 (16#80#) .. 131 (16#83#)}]
      @i[reserved_132], @\@i[nel], @\@i[ssa], @\@i[esa], @\ @\ @\ @\@charnote[--@i{132 (16#84#) .. 135 (16#87#)}]

      @i[hts], @\@i[htj], @\@i[vts], @\@i[pld], @\@i[plu], @\@i[ri], @\@i[ss2], @\@i[ss3], @\@charnote[--@i{136 (16#88#) .. 143 (16#8F#)}]
@comment{blank line}
      @i[dcs], @\@i[pu1], @\@i[pu2], @\@i[sts], @\@i[cch], @\@i[mw], @\@i[spa], @\@i[epa], @\@charnote[--@i{144 (16#90#) .. 151 (16#97#)}]

@case{Device, Postscript=
"      @i[sos], @\@i[reserved_153], @\@i[sci], @\@i[csi], @\ @\ @\",
     else=
"      @i[sos], @i[reserved_153], @i[sci], @i[csi],"}
@\@charnote[--@i{152 (16#98#) .. 155 (16#9B#)}]
      @i[st], @\@i[osc], @\@i[pm], @\@i[apc], @\ @\ @\ @\ @\@charnote[--@i{156 (16#9C#) .. 159 (16#9F#)}]

@comment{blank line}
@case{Device, Postscript=
"      ' ',  '@a9x(A)',  '@a9x(B)',  '@a9x(C)',     '@a9x(D)',  '@a9x(E)',  '@a9x(F)',  '@a9x(G)', @\--@i{160 (16#A0#) .. 167 (16#A7#)}
      '@a9x(H)',  '@a9x(I)',  '@a9x(J)',  '@a9x(K)',     '@a9x(L)',  '@a9x(M)',  '@a9x(N)',  '@a9x(O)', @\--@i{168 (16#A8#) .. 175 (16#AF#)}
@comment{blank line}
      '@a9x(P)',  '@a9x(Q)',  '@a9x(R)',  '@a9x(S)',     '@a9x(T)',  '@a9x(U)',  '@a9x(V)',  '@a9x(W)', @\--@i{176 (16#B0#) .. 183 (16#B7#)}
      '@a9x(X)',  '@a9x(Y)',  '@a9x(Z)',  '@a9x([)',     '@a9x(\)',  '@a9x(q)',  '@a9x(r)',  '@a9x(s)', @\--@i{184 (16#B8#) .. 191 (16#BF#)}
@comment{blank line}
      '@uagr()',  '@uaac()',  '@uacr()',  '@uatl()',     '@uaum()',  '@uarg()',  '@a9x(b)',  '@a9x(u)', @\--@i{192 (16#C0#) .. 199 (16#C7#)}
      '@uegr()',  '@ueac()',  '@uecr()',  '@ueum()',     '@uigr()',  '@uiac()',  '@uicr()',  '@uium()', @\--@i{200 (16#C8#) .. 207 (16#CF#)}
@comment{blank line}
      '@a9x(t)',  '@a9x(a)',  '@uogr()',  '@uoac()',     '@uocr()',  '@uotl()',  '@uoum()',  '@a9x(c)', @\--@i{208 (16#D0#) .. 215 (16#D7#)}
      '@a9x(d)',  '@uugr()',  '@uuac()',  '@uucr()',     '@uuum()',  '@a9x(e)',  '@a9x(f)',  '@a9x(g)', @\--@i{216 (16#D8#) .. 223 (16#DF#)}
@comment{blank line}
      '@agr()',  '@aac()',  '@acr()',  '@atl()',     '@aum()',  '@arg()',  '@a9x(j)',  '@a9x(v)', @\--@i{224 (16#E0#) .. 231 (16#E7#)}
      '@egr()',  '@eac()',  '@ecr()',  '@eum()',     '@igr()',  '@iac()',  '@icr()',  '@ium()', @\--@i{232 (16#E8#) .. 239 (16#EF#)}
@comment{blank line}
      '@a9x(h)',  '@a9x(i)',  '@ogr()',  '@oac()',     '@ocr()',  '@otl()',  '@oum()',  '@a9x(k)', @\--@i{240 (16#F0#) .. 247 (16#F7#)}
      '@a9x(l)',  '@ugr()',  '@uac()',  '@ucr()',     '@uum()',  '@a9x(m)',  '@a9x(n)',  '@a9x(o)'); @\--@i{248 (16#F8#) .. 255 (16#FF#)}",
else="... );"}
@begin{Comment}
We can get some of the Latin-1 characters out of Scribe:

@@Q(aA)
@@q(Aa)
   @Aac(),       A acute
   @arg(),  a ring
   @agr(),    a grave
   @acr(),    a circumflex
   @atl(),    a tilde
   @aum(),    a umlaut

   @ccd(),    c cedilla

   @eac(),    e acute
   @ecr(),    e circumflex
   @egr(),    e grave
   @eum(),    e umlaut
   @iac(),    i acute
   @icr(),    i circumflex
   @ium(),    i umlaut
   @ntl(),    n tilde
   @oac(),    o acute
   @ocr(),    o circumflex
   @otl(),    o tilde
   @oum(),    o umlaut

   @scr(),    s circumflex
   @uac(),    u acute
   @ugr(),    u grave
   @ucr(),    u circumflex
   @uum(),    u umlaut
@end{Comment}
@Hinge{}

   --@i{ The predefined operators for the type Character are the  same  as  for}
   --@i{ any enumeration type.}
@Hinge{}
@comment[blank line]
@comment[blank line]
   --@i{ The declaration of type Wide_Character is based on the standard ISO 10646 BMP character set.}
   --@i{ The first 256 positions have the same contents as type Character.  See @refsecnum[Character types].}
@comment[blank line]
@LangDefType{Package=[Standard],Type=[Wide_Character]}
   @key[type] Wide_Character @key[is] (@i[nul], @i[soh] ... @i[FFFE], @i[FFFF]);
@comment[blank line]
@comment[blank line]
   @key[package] ASCII @key[is] ... @key[end] ASCII;  @i{--Obsolescent; see @RefSecNum[ASCII]}
@Defn2{Term=[ASCII], Sec=(package physically nested within the declaration of Standard)}
@Hinge{}
@comment[blank line]
@comment[blank line]
   --@i{ Predefined string types:}

@LangDefType{Package=[Standard],Type=[String]}
   @key[type] String @key[is] @key[array](Positive @key[range] <>) @key[of] Character;
   @key[pragma] Pack(String);

   --@i{ The predefined operators for this type are as follows:}

   --     @key[function] "="  (Left, Right: String) @key[return] Boolean;
   --     @key[function] "/=" (Left, Right: String) @key[return] Boolean;
@Hinge{}
   --     @key[function] "<"  (Left, Right: String) @key[return] Boolean;
   --     @key[function] "<=" (Left, Right: String) @key[return] Boolean;
   --     @key[function] ">"  (Left, Right: String) @key[return] Boolean;
   --     @key[function] ">=" (Left, Right: String) @key[return] Boolean;
@Hinge{}

   --     @key[function] "&" (Left: String;    Right: String)    @key[return] String;
   --     @key[function] "&" (Left: Character; Right: String)    @key[return] String;
   --     @key[function] "&" (Left: String;    Right: Character) @key[return] String;
   --     @key[function] "&" (Left: Character; Right: Character) @key[return] String;
@Hinge{}

@LangDefType{Package=[Standard],Type=[Wide_String]}
   @key[type] Wide_String @key[is] @key[array](Positive @key[range] <>) @key[of] Wide_Character;
   @key[pragma] Pack(Wide_String);

   --@i{ The predefined operators for this type correspond to those for String}
@Hinge{}

@LangDefType{Package=[Standard],Type=[Duration]}
   @key[type] Duration @key[is] @key[delta] @i{implementation-defined} @key[range] @i{implementation-defined};

      --@i{ The  predefined  operators for the type Duration are the same as for}
      --@i{ any fixed point type.}
@Hinge{}

   --@i{ The predefined exceptions:}

   Constraint_Error: @key[exception];
   Program_Error   : @key[exception];
   Storage_Error   : @key[exception];
   Tasking_Error   : @key[exception];

@key[end] Standard;
@end{Example}

Standard has no private part.
@Reason{This is important for portability.  All library packages
are children of Standard, and if Standard had a private part then
it would be visible to all of them.}

In each of the types Character and Wide_Character,
the character literals for the space character (position 32)
and the non-breaking
space character (position 160)
correspond to different values. Unless
indicated otherwise, each occurrence of
the character literal
' ' in this International Standard
refers to the space character.
Similarly, the character literals
for hyphen (position 45)
and soft hyphen (position 173) correspond to different values.
Unless indicated otherwise, each occurrence of
the character literal
'-' in this International Standard
refers to the hyphen character.
@end{StaticSem}

@begin{RunTime}
@PDefn2{Term=[elaboration], Sec=(package_body of Standard)}
Elaboration of the body of Standard has no effect.
@begin{Discussion}
Note that the language does not define where
this body appears in the environment @nt{declarative_part}
@em @lSeeSec{Program Structure and Compilation Issues}.
@end{Discussion}
@end{RunTime}

@begin{ImplPerm}
 An implementation may provide additional predefined integer
 types and additional predefined floating point types.
  Not all of these types need have names.
@begin{Honest}

  An implementation may add representation items to package Standard, for
  example to specify the internal codes of type Boolean,
  or the Small of type Duration.

@end{Honest}
@end{ImplPerm}

@begin{ImplAdvice}
If an implementation provides additional named predefined integer types,
then  the names should end with ``Integer'' as in ``Long_Integer''.
If an implementation provides additional named predefined
floating point types,
then  the names should end with ``Float'' as in ``Long_Float''.
@end{ImplAdvice}

@begin{NotesNotes}
Certain aspects of the predefined entities cannot be completely
described in the language itself.  For example, although the
enumeration type Boolean can be written showing the two enumeration
literals False and True, the short-circuit control forms cannot be
expressed in the language.

As explained in @RefSec{Declarative Region}
and @RefSec{The Compilation Process},
the declarative region of the package Standard encloses every
library unit and consequently the main subprogram;
the declaration of every library unit is assumed to occur
within this declarative region.
@nt{Library_item}s
are assumed to be ordered in such a way that there are no forward
semantic dependences.
However, as explained in @RefSec{Visibility}, the only library units that are
visible within a given compilation unit are
the library units named by all @nt{with_clauses} that
apply to the given unit,
and moreover, within the declarative region of a given library unit,
that library unit itself.

If all @nt{block_statement}s of a program are named, then the name
of each program unit can always be written as an expanded name
starting with Standard (unless Standard is itself hidden).
The name of a library unit cannot be a homograph of a name (such as
Integer) that is already declared in Standard.

The exception Standard.Numeric_Error is defined in @RefSecNum{Numeric_Error}.
@begin{Discussion}
The declaration of Natural needs to appear between the declaration of
Integer and the (implicit) declaration of the "**" operator for Integer,
because a formal parameter of "**" is of subtype Natural.
This would be impossible in normal code, because the implicit
declarations for a type occur immediately after the type declaration,
with no possibility of intervening explicit declarations.
But we're in Standard, and Standard is somewhat magic anyway.

Using Natural as the subtype of the formal of "**" seems natural;
it would be silly to have a textual rule about Constraint_Error being
raised when there is a perfectly good subtype that means just that.
Furthermore, by not using Integer for that formal, it helps remind the
reader that the exponent remains Natural even when the left operand is
replaced with the derivative of Integer.
It doesn't logically imply that, but it's still useful as a reminder.

In any case, declaring these general-purpose subtypes of Integer close
to Integer seems more readable than declaring them much later.
@end{Discussion}
@end{NotesNotes}

@begin{Extend83}
Package Standard is declared to be pure.
@begin{discussion}
The introduction of the types Wide_Character and Wide_String is not
an Ada 9X extension to Ada 83, since ISO WG9 has approved these as an
authorized extension of the original Ada 83 standard that is part
of that standard.
@end{discussion}
@end{Extend83}

@begin{DiffWord83}
Numeric_Error is made obsolescent.

The declarations of Natural and Positive are moved to just after the
declaration of Integer, so that "**" can refer to Natural without a
forward reference.
There's no real need to move Positive, too @em it just came along for
the ride.
@end{DiffWord83}
