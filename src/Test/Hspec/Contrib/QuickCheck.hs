module Test.Hspec.Contrib.QuickCheck where

import           Test.Hspec.Core
import           Test.QuickCheck

-- | A custom QuickCheck test to be run by hspec.
data QuickCheckExample = QuickCheckExample Args Property

-- | Runs a QuickCheck property with custom settings. Overrides `paramsQuickCheckArgs`.
-- Example:
--
-- > it "passes 1000 checks" $
-- >   quickCheckExample stdArgs{ maxSuccess = 1000 } myprop
quickCheckExample :: Args -> Property -> QuickCheckExample
quickCheckExample = QuickCheckExample

instance Example QuickCheckExample where
  evaluateExample c (QuickCheckExample args p) =
    evaluateExample c {paramsQuickCheckArgs = args} p
