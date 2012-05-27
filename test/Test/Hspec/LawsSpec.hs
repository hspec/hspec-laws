{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Test.Hspec.LawsSpec (main, spec) where

import           Test.Hspec.ShouldBe
import           Test.QuickCheck

import           Data.Monoid
import           Test.Hspec.Laws

main :: IO ()
main = hspecX spec

newtype Minus = Minus Int
  deriving (Eq, Show, Num, Arbitrary)

instance Monoid Minus where
  mempty  = 0
  mappend = (-)

spec :: Specs
spec = do
  describe "shouldSatisfyMonoidLaws" $ do
    it "succeeds for a valid Monoid instance" $ do
      hspecB (shouldSatisfyMonoidLaws (Type :: Type [Int])) `shouldReturn` True

    it "fails for a broken Monoid instance" $ do
      hspecB (shouldSatisfyMonoidLaws (Type :: Type Minus)) `shouldReturn` False
