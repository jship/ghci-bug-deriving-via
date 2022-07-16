{-# LANGUAGE DerivingVia #-}
module Test.Package.F
  ( FooT(..)
  ) where

import Control.Monad.Trans.Reader (ReaderT(ReaderT))

newtype FooT m a = FooT
  { runFooT :: Int -> m a
  } deriving (Functor) via (ReaderT Int m)
