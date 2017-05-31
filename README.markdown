# Reusable specifications
(similar in spirit to [checkers](http://hackage.haskell.org/package/checkers))

## Check Monoid laws

`shouldSatisfyMonoidLaws` can be used to specify, that a given type should
satisfy the Monoid laws.

```haskell
-- file Spec.hs
import Test.Hspec
import Test.Hspec.Laws

main :: IO ()
main = hspec $ do
  describe "List as a Monoid" $
    shouldSatisfyMonoidLaws (undefined :: [Int])
```

Running this produces a nice spec.

```
$ runhaskell Spec.hs

List as a Monoid
  mempty
    - is a left identity
    - is a right identity

  mappend
    - is associative

Finished in 0.1142 seconds
3 examples, 0 failures
```
