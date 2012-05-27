-- | Reusable specifications.
module Test.Hspec.Laws (
  Type (..)
, shouldSatisfyMonoidLaws
) where

import           Prelude hiding (asTypeOf)
import           Data.Monoid
import           Test.QuickCheck
import           Test.Hspec.ShouldBe

data Type a = Type

asTypeOf :: a -> Type a -> a
asTypeOf = const

shouldSatisfyMonoidLaws :: (Eq a, Show a, Monoid a, Arbitrary a) => Type a -> Specs
shouldSatisfyMonoidLaws t = do
  describe "mappend" $ do
    it "is associative" $
      property $ \x y z ->
        (x `mappend` y) `mappend` z == x `mappend` (y `mappend` z) `asTypeOf` t

  describe "mempty" $ do
    it "mempty is a left identity" $
      property $ \x ->
        mempty `mappend` x == x `asTypeOf` t

    it "mempty is a right identity" $
      property $ \x ->
        x `mappend` mempty == x `asTypeOf` t
