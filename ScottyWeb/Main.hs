{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mconcat)
import System.Directory
import Text.Blaze.Html.Renderer.Text
import Text.Markdown
import Web.Scotty

main = scotty 3000 $ do
  get "/:word" $ do
    beam <- param "word"

    let beam' = renderHtml $ markdown def beam
    html $ mconcat ["<h1>Scotty, ", beam', " me up!</h1>"]
  get "/files" $ do
   	  files <- liftIO $ getDirectoryContents "Datas"
   	  html $ mconcat $ map (\ x -> "<p>"++ x ++"</p>") files
