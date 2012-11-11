module Test.Hspec.Contrib.QuickCheckSpec (main, spec) where

import           Test.Hspec
import           Test.QuickCheck
import           Test.QuickCheck.Property
import           Mock

import           Test.Hspec.Contrib.QuickCheck

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "modifyQuickCheckMaxSuccess" $ do
    it "can be used to modify QuickCheck's maxSuccess" $ do
      m <- newMock
      hspec $ do
        it "foo" $ modifyQuickCheckMaxSuccess (`div` 2) $ morallyDubiousIOProperty $ do
          mockAction m
          return True
      mockCounter m `shouldReturn` 50

  describe "quickCheckExample" $ do
    it "can be used to set custom QuickCheck args" $ do
      m <- newMock
      hspec $ do
        it "foo" $ quickCheckExample stdArgs {maxSuccess = 23} $ morallyDubiousIOProperty $ do
          mockAction m
          return True
      mockCounter m `shouldReturn` 23
