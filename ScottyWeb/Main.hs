{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mconcat)
import Text.Blaze.Html.Renderer.Text
import Web.Scotty

main = scotty 3000 $ do
  get "/:word" $ do
    beam <- param "word"

    markdownedBeam <- renderHtml $ markdown def beam
    html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]
