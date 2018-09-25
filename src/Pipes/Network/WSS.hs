{-# LANGUAGE RankNTypes #-}

-- | This module offers tools to stream from and to WebSocket
-- 'W.Connection's using "Pipes" (both @ws://@ and @wss://@).
--
-- Please refer to "Network.Simple.WSS" for a lower-level API that doesn't use
-- "Pipes".
module Pipes.Network.WSS
 ( fromConnection
 , toConnection
 ) where

import Control.Monad.IO.Class (MonadIO)
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import Data.Function (fix)
import qualified Pipes as P

import qualified Network.Simple.WSS as WSS

--------------------------------------------------------------------------------

-- | Receives bytes from the remote end and sends them downstream.
--
-- The obtailed 'B.ByteString's are never 'B.null'.
--
-- This producer returns when the conection is closed gracefully.
fromConnection
  :: MonadIO m
  => WSS.Connection
  -> P.Producer' B.ByteString m ()  -- ^
{-# INLINABLE fromConnection #-}
fromConnection conn =
  fix $ \k -> do
     bs <- WSS.recv conn
     case B.null bs of
        False -> P.yield bs >> k
        True -> pure ()

-- | Send bytes from upstream to the remote end.
toConnection
  :: MonadIO m
  => WSS.Connection
  -> P.Consumer' B.ByteString m ()  -- ^
{-# INLINABLE toConnection #-}
toConnection conn = P.for P.cat (WSS.send conn . BL.fromStrict)
