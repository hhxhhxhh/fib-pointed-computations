(* Exact certificate for the explicit two-dimensional R_n-modules. *)

ClearAll[t, phi, p, r, A, B, X, m, alpha];
phi = (1 + Sqrt[5])/2;
p = (t + 1/phi)/Sqrt[5];
r = 1 + p - p^2;
A = DiagonalMatrix[{phi, -1/phi}];
B = {{p, 1}, {r, 1 - p}};
X = A.B;

assertZero[name_, expr_] :=
  If[FullSimplify[expr] === 0 || FullSimplify[expr] === ConstantArray[0, Dimensions[expr]],
    Print[name <> ": PASS"],
    Print[name <> ": FAIL: ", FullSimplify[expr]]; Exit[1]
  ];

assertZero["A^2=A+I", A.A - A - IdentityMatrix[2]];
assertZero["B^2=B+I", B.B - B - IdentityMatrix[2]];
assertZero["tr(AB)=t", Tr[X] - t];
assertZero["det(AB)=1", Det[X] - 1];
assertZero["ABA-BAB=(t+1)(A-B)", A.B.A - B.A.B - (t + 1) (A - B)];

(* The odd braid coefficient is sin((2m+1) alpha)/sin(alpha). *)
oddIdentity =
   ((2 Cos[2 alpha] + 1) ChebyshevU[m - 1, Cos[2 alpha]] -
      ChebyshevU[m - 2, Cos[2 alpha]]) Sin[alpha] -
    Sin[(2 m + 1) alpha];
assertZero["odd Chebyshev identity",
  FullSimplify[FunctionExpand[oddIdentity],
    Assumptions -> Element[m, Integers] && m >= 1 && 0 < alpha < Pi]];

(* Exact specializations for the surviving small-totient parameters and the
   realized value n=3. *)
Do[
  Do[
    tt = 2 Cos[2 Pi j/n];
    AA = A;
    BB = FullSimplify[B /. t -> tt];
    alt[start_, len_] := Dot @@ Table[
       If[EvenQ[k - 1], If[start === 1, AA, BB], If[start === 1, BB, AA]],
       {k, len}
       ];
    assertZero["braid n=" <> ToString[n] <> ",j=" <> ToString[j],
      RootReduce[alt[1, n] - alt[2, n]]],
    {j, 1, Floor[(n - 1)/2]}
  ],
  {n, {3, 4, 5, 6, 8, 10, 12}}
];

Print["All exact explicit-module checks passed."];
