{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mconcat)
import qualified Data.Text.Lazy as LT
import Control.Monad.IO.Class (liftIO)
import System.Directory  
import Text.Blaze.Html.Renderer.Text
import Text.Markdown
import Web.Scotty

main = scotty 3000 $ do
  get"/:filename" $ do
  	--(1)I would prefer to use /files/filename, but not sure how to do that?
  	filename <- param "filename"
  	--(2) What is the naming convention ?, and I guess I should know this but how to turn form string to the type alias FilePath?

  	markdownFile <- readFile filename
  	-- (3) use magic to 
  	--  		* check if the file exists , I guess
  	--  		* get html from markdown 
  	html $ "<p>yay! got some stuff, but not really</p>"
  get "/files" $ do
   	files <- liftIO $ getDirectoryContents "Datas"
   	-- there must be a nice way to generate html and the strings ?
   	-- How can I search for it?
   	html $ mconcat $ map (\x -> LT.pack (mconcat ["<a>", x, "</a>"])) files
    
  get "/:word" $ do
    beam <- param "word"

    let beam' = renderHtml $ markdown def beam
    html $ mconcat ["<h1>Scotty, ", beam', " me up!</h1>"]

