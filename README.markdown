# Reusable specifications
(similar in spirit to [checkers](http://hackage.haskell.org/package/checkers))

## Check Monoid laws

`shouldSatisfyMonoidLaws` can be used to specify, that a given type should
satisfy the Monoid laws.

~~~ {.haskell .literate}
import Test.Hspec.Monadic
import Test.Hspec.Laws

main :: IO ()
main = hspecX $ do
  describe "List as a Monoid" $
    shouldSatisfyMonoidLaws (Type :: Type [Int])
~~~
