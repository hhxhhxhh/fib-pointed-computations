(* Exact scalar certificate for the n=2 and n=3 jellyfish tables in
   Section 5 and their two Q(Sqrt[5])-specializations in Section 11.  This
   checks coefficients, index permutations, the integer circle counts for
   diagonal train closures, and the nonvanishing scalar denominators for
   both Galois-conjugate roots.  Planar reductions, train independence,
   tadpole vanishing, and categorical descent remain diagrammatic. *)

ClearAll[tau, omega, sigma, assertTrue, assertZero, vectorZeroQ];

assertTrue[name_, condition_] :=
  If[TrueQ[condition], Print[name <> ": PASS"],
    Print[name <> ": FAIL: ", condition]; Exit[1]];

assertZero[name_, expression_] :=
  assertTrue[name, TrueQ[FullSimplify[expression] === 0]];

vectorZeroQ[vector_] := And @@ (TrueQ[FullSimplify[#] === 0] & /@ vector);

tauRoots = {(1 - Sqrt[5])/2, (1 + Sqrt[5])/2};
assertTrue["conjugate Fibonacci scalars",
  And @@ (TrueQ[FullSimplify[#^2 - # - 1 == 0]] & /@ tauRoots)];
assertTrue["conjugate presentation denominators",
  And @@ (TrueQ[FullSimplify[# != 0]] & /@
    Flatten[Table[r^m, {r, tauRoots}, {m, 1, 3}]])];
assertTrue["conjugate Gram diagonals",
  And @@ (TrueQ[FullSimplify[# != 0]] & /@
    Flatten[Table[r^m, {r, tauRoots}, {m, 1, 6}]])];

tau = tauRoots[[2]];
assertZero["Fibonacci scalar", tau^2 - tau - 1];

left2 = {1/(tau^2 omega), 1/(tau sigma), 1/tau, 1};
rawRight2 = {omega/tau^2, omega/tau, sigma/tau, sigma};
permutation2 = {1, 3, 2, 4};
right2 = ConstantArray[0, 4];
Do[right2[[permutation2[[i]]]] = rawRight2[[i]], {i, 1, 4}];
expectedRight2 = {omega/tau^2, sigma/tau, omega/tau, sigma};

assertTrue["n=2 conjugation permutation", right2 === expectedRight2];
assertZero["n=2 C2 forces omega", tau (left2[[3]] - right2[[3]]) - (1 - omega)];
assertZero["n=2 C3 forces sigma", left2[[4]] - right2[[4]] - (1 - sigma)];
assertTrue["n=2 coefficient equality at omega=sigma=1",
  vectorZeroQ[(left2 - right2) /. {omega -> 1, sigma -> 1}]];

initialLeft3 = {omega/tau^2, omega/tau, sigma/tau, sigma};
leftBranches3 = {
  {omega/tau, sigma}, {1/tau, 1}, {1/tau, 1},
  {1/tau, 1/tau, -1/tau}};
left3FromBranches = Flatten[
  MapThread[#1 #2 &, {initialLeft3, leftBranches3}]];
left3 = {omega^2/tau^3, omega sigma/tau^2, omega/tau^2,
  omega/tau, sigma/tau^2, sigma/tau, sigma/tau, sigma/tau,
  -sigma/tau};
assertTrue["n=3 four branch expansion",
  vectorZeroQ[left3FromBranches - left3]];

rawRight3 = {1/(tau^3 omega), 1/(tau^2 omega),
  1/(tau^2 sigma), 1/(tau sigma), 1/tau^2, 1/tau, 1/tau,
  1/tau, -1/tau};
permutation3 = {1, 5, 3, 8, 2, 7, 6, 4, 9};
right3 = ConstantArray[0, 9];
Do[right3[[permutation3[[i]]]] = rawRight3[[i]], {i, 1, 9}];
expectedRight3 = {1/(tau^3 omega), 1/tau^2, 1/(tau^2 sigma),
  1/tau, 1/(tau^2 omega), 1/tau, 1/tau, 1/(tau sigma),
  -1/tau};

assertTrue["n=3 conjugation permutation", right3 === expectedRight3];
assertZero["n=3 B3 forces omega",
  tau (left3[[4]] - right3[[4]]) - (omega - 1)];
assertZero["n=3 B5 forces sigma",
  tau (left3[[6]] - right3[[6]]) - (sigma - 1)];
assertTrue["n=3 coefficient equality at omega=sigma=1",
  vectorZeroQ[(left3 - right3) /. {omega -> 1, sigma -> 1}]];

trainExponent[n_Integer, d_Integer, gaps_List] :=
  n + d + Total[(n - 1) - gaps];
n2GramExponents = Prepend[
  trainExponent[2, #[[1]], #[[2]]] & /@
    {{1, {1}}, {0, {0}}, {0, {1, 1, 1}}}, 4];
n3GramExponents = Prepend[
  trainExponent[3, #[[1]], #[[2]]] & /@
    {{2, {2}}, {1, {1}}, {1, {2, 2, 2}}, {0, {0}},
     {0, {2, 1, 2}}, {0, {1, 2, 2}}, {0, {2, 2, 1}},
     {0, {2, 2, 2, 2, 2}}}, 6];
assertTrue["n=2 Gram exponents",
  n2GramExponents === {4, 3, 3, 2}];
assertTrue["n=3 Gram exponents",
  n3GramExponents === {6, 5, 5, 4, 5, 4, 4, 4, 3}];

Print["All exact jellyfish coefficient checks passed."];
