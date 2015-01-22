{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mconcat)
import qualified Data.Text.Lazy as LT
import Control.Monad.IO.Class (liftIO)
import System.Directory  
import Text.Blaze.Html.Renderer.Text
import Text.Markdown
import Web.Scotty

main = scotty 3000 $ do
  get "/files" $ do
   	files <- liftIO $ getDirectoryContents "Datas"
   	html $ mconcat $ map (\x -> LT.pack (mconcat ["<p>", x, "</p>"])) files
    
  get "/:word" $ do
    beam <- param "word"

    let beam' = renderHtml $ markdown def beam
    html $ mconcat ["<h1>Scotty, ", beam', " me up!</h1>"]

