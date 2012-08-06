{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Test.Hspec.LawsSpec (main, spec) where

import           Test.Hspec
import           Test.Hspec.Monadic (hspecB)
import           Test.QuickCheck

import           Data.Monoid
import           Test.Hspec.Laws

main :: IO ()
main = hspec spec

newtype Minus = Minus Int
  deriving (Eq, Show, Num, Arbitrary)

instance Monoid Minus where
  mempty  = 0
  mappend = (-)

spec :: Spec
spec = do
  describe "shouldSatisfyMonoidLaws" $ do
    it "succeeds for a valid Monoid instance" $ do
      hspecB (shouldSatisfyMonoidLaws (undefined :: [Int])) `shouldReturn` True

    it "fails for a broken Monoid instance" $ do
      hspecB (shouldSatisfyMonoidLaws (undefined :: Minus)) `shouldReturn` False
