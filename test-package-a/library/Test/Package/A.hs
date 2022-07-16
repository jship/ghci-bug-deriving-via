{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Test.Package.A
  ( FooT(..)
  ) where

import Control.Monad.Trans.Reader (ReaderT(ReaderT))

newtype FooT m a = FooT
  { runFooT :: ReaderT Int m a
  } deriving newtype (Functor)
