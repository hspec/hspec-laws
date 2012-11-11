module Test.Hspec.Contrib.QuickCheck where

import           Test.Hspec.Core
import qualified Test.QuickCheck as QC

-- | A wrapper for examples that can be used to modify `Params`.
data ModifyParams = ModifyParams (Params -> IO Result)

instance Example ModifyParams where
  evaluateExample c (ModifyParams e) = e c

modifyParams :: Example e => (Params -> Params) -> e -> ModifyParams
modifyParams f e = ModifyParams $ \c -> evaluateExample (f c) e

modifyQuickCheckArgs :: Example e => (QC.Args -> QC.Args) -> e -> ModifyParams
modifyQuickCheckArgs f = modifyParams $ \c@Params{paramsQuickCheckArgs = args} -> c {paramsQuickCheckArgs = f args}

modifyQuickCheckMaxSuccess :: Example e => (Int -> Int) -> e -> ModifyParams
modifyQuickCheckMaxSuccess f = modifyQuickCheckArgs $ \args -> args {QC.maxSuccess = f (QC.maxSuccess args)}

-- | Runs a QuickCheck property with custom settings. Overrides `paramsQuickCheckArgs`.
-- Example:
--
-- > it "passes 1000 checks" $
-- >   quickCheckExample stdArgs{ maxSuccess = 1000 } myprop
quickCheckExample :: QC.Args -> QC.Property -> ModifyParams
quickCheckExample args = modifyQuickCheckArgs (const args)
