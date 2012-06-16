-- | Reusable specifications.
module Test.Hspec.Laws (shouldSatisfyMonoidLaws) where

import           Prelude
import           Data.Monoid
import           Test.QuickCheck
import           Test.Hspec.ShouldBe

shouldSatisfyMonoidLaws :: (Eq a, Show a, Monoid a, Arbitrary a) => a -> Specs
shouldSatisfyMonoidLaws t = do
  describe "mempty" $ do
    it "is a left identity" $ property $ \x ->
      mempty <> x == x `asTypeOf` t

    it "is a right identity" $ property $ \x ->
      x <> mempty == x `asTypeOf` t

  describe "mappend" $ do
    it "is associative" $ property $ \x y z ->
      (x <> y) <> z == x <> (y <> z) `asTypeOf` t
