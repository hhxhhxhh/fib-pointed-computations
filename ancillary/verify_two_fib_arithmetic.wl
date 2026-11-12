(* Exact certificate for the arithmetic identities in Section 4.
   No floating-point arithmetic is used. *)

ClearAll[x, n, j, k, alpha, golden, codegree, characterValue,
  characterCodegree, assertTrue, assertZero];

assertTrue[name_, condition_] :=
  If[TrueQ[condition], Print[name <> ": PASS"],
    Print[name <> ": FAIL: ", condition]; Exit[1]];

assertZero[name_, expression_] :=
  assertTrue[name, TrueQ[RootReduce[FullSimplify[expression]] === 0]];

codegree[n_Integer, j_Integer] :=
  RootReduce[n (1 + 1/(4 Sin[Pi j/n]^2))];

characterValue[n_Integer, j_Integer, k_Integer] :=
  RootReduce[If[EvenQ[k], 2 Cos[Pi j k/n],
    Sin[Pi j k/n]/Sin[Pi j/n]]];

characterCodegree[n_Integer, j_Integer] := RootReduce[
  (4 + 2 Sum[characterValue[n, j, k]^2, {k, 1, n - 1}] +
     characterValue[n, j, n]^2)/2];

Do[
  Do[
    assertZero[
      "character sum n=" <> ToString[n] <> ",j=" <> ToString[j],
      characterCodegree[n, j] - codegree[n, j]],
    {j, 1, Floor[(n - 1)/2]}],
  {n, {3, 4, 5, 6, 8, 10, 12}}];

candidateParameters = {
  {4, 0, 6, x},
  {5, (Sqrt[5] - 1)/2, (15 + Sqrt[5])/2, x^2 + x - 1},
  {6, 1, 12, x - 1},
  {8, Sqrt[2], 16 + 4 Sqrt[2], x^2 - 2},
  {10, (1 + Sqrt[5])/2, 25 + 5 Sqrt[5], x^2 - x - 1},
  {12, Sqrt[3], 36 + 12 Sqrt[3], x^2 - 3}
  };

Do[
  n = row[[1]];
  assertZero["cyclotomic parameter n=" <> ToString[n],
    2 Cos[2 Pi/n] - row[[2]]];
  assertZero["candidate codegree n=" <> ToString[n],
    codegree[n, 1] - row[[3]]];
  assertTrue["real cyclotomic polynomial n=" <> ToString[n],
    Expand[MinimalPolynomial[2 Cos[2 Pi/n], x] - row[[4]]] === 0];
  assertTrue["real cyclotomic degree n=" <> ToString[n],
    Exponent[row[[4]], x] === EulerPhi[n]/2],
  {row, candidateParameters}];

assertZero["Mobius recovery of t",
  (3 n - 2 (n (3 - x)/(2 - x)))/(n - n (3 - x)/(2 - x)) - x];

assertTrue["totient candidates through 1000",
  Select[Range[1, 1000], EulerPhi[#] <= 4 &] ===
    {1, 2, 3, 4, 5, 6, 8, 10, 12}];

assertZero["five-fold codegree n=5", codegree[5, 1] - (15 + Sqrt[5])/2];
assertZero["five-fold codegree n=10", codegree[10, 2] - (15 + Sqrt[5])];

dRatio = RootReduce[(15 + Sqrt[5])/(15 - Sqrt[5])];
dRatioConjugate = dRatio /. Sqrt[5] -> -Sqrt[5];
assertZero["d-number ratio", dRatio - (23 + 3 Sqrt[5])/22];
assertZero["d-number ratio trace", dRatio + dRatioConjugate - 23/11];
assertZero["d-number ratio norm", dRatio dRatioConjugate - 1];
assertTrue["d-number ratio trace is nonintegral",
  ! IntegerQ[RootReduce[dRatio + dRatioConjugate]]];

golden = (1 + Sqrt[5])/2;
DPlus[n_Integer] := RootReduce[Sqrt[5] (golden^(2 n) - 1)];
DMinus[n_Integer] := RootReduce[Sqrt[5] (1 - golden^(-2 n))];

assertZero["D4 plus", DPlus[4] - (105 + 45 Sqrt[5])/2];
assertZero["D4 minus", DMinus[4] - (105 - 45 Sqrt[5])/2];
assertZero["D6 plus", DPlus[6] - (360 + 160 Sqrt[5])];
assertZero["D6 minus", DMinus[6] - (360 - 160 Sqrt[5])];
assertZero["D4 ratio trace", DPlus[4]/6 + DMinus[4]/6 - 35/2];
assertZero["D6 ratio norm", (DPlus[6]/12) (DMinus[6]/12) - 100/9];
assertZero["D4 mixed ratio", (5 4/2)/6 - 5/3];
assertZero["D6 mixed ratio", (5 6/2)/12 - 5/4];

assertTrue["n=2 two-dimensional index set is empty",
  Range[1, Floor[(2 - 1)/2]] === {}];

Print["All exact two-Fibonacci arithmetic checks passed."];
