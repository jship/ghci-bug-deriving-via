# `ghci-bug-deriving-via`

This repo demonstrates a potential `ghci` regression introduced after GHC
8.10.7. The repo has 6 test packages:

| Package Name | GHC version | `stack build`? | `stack ghci`? | Notes
---|---|---|---|---
`test-package-a` | 8.10.7 | ✅ | ✅ | newtype over `ReaderT`, uses newtype-deriving
`test-package-b` | 8.10.7 | ✅ | ✅ | newtype over `ReaderT`, uses `DerivingVia`
`test-package-c` | 8.10.7 | ✅ | ✅ | newtype over function, uses `DerivingVia`
`test-package-d` | 9.2.3 | ✅ | ✅ | newtype over `ReaderT`, uses newtype-deriving
`test-package-e` | 9.2.3 | ✅ | ✅ | newtype over `ReaderT`, uses `DerivingVia`
`test-package-f` | 9.2.3 | ✅ | ❌ | newtype over function, uses `DerivingVia`

The variable being tested across the two groups (A-C and D-F) of packages is the
GHC version. As seen in the table above, all packages build successfully. `stack
ghci` dies for F though, where `DerivingVia` is used with a newtype wrapper for
a function.

The error message from `ghci` is:

```
.../ghci-bug-deriving-via/test-package-f/library/Test/Package/F.hs:10:41: error:ghc-9.2.3: panic! (the 'impossible' happened)
  (GHC version 9.2.3:
        No skolem info:
  [k_a1mj]
  Call stack:
      CallStack (from HasCallStack):
        callStackDoc, called at compiler/GHC/Utils/Panic.hs:181:37 in ghc:GHC.Utils.Panic
        pprPanic, called at compiler/GHC/Tc/Errors.hs:2912:17 in ghc:GHC.Tc.Errors

Please report this as a GHC bug:  https://www.haskell.org/ghc/reportabug


<no location info>: error:
    Could not load module ‘Test.Package.F’
    It is a member of the hidden package ‘test-package-f-0.0.0.0’.
    You can run ‘:set -package test-package-f’ to expose it.
    (Note: this unloads all the modules in the current scope.)
```
