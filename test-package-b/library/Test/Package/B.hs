{-# LANGUAGE DerivingVia #-}
module Test.Package.B
  ( FooT(..)
  ) where

import Control.Monad.Trans.Reader (ReaderT(ReaderT))

newtype FooT m a = FooT
  { runFooT :: ReaderT Int m a
  } deriving (Functor) via (ReaderT Int m)
