{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mconcat)
import qualified Data.Text.Lazy as LT
import Control.Monad.IO.Class (liftIO)
import Network.HTTP.Types (status404)
import System.Directory  
import Text.Blaze.Html.Renderer.Text
import Text.Markdown
import Web.Scotty as S


main = scotty 3000 $ do
  get"/files/:filename" $ do    
    filename <- param "filename"
    liftIO $ renderMarkdown filename
    -- 25/01 doing the side effect first and then 
    text <- liftIO $ renderMarkdown filename 
    display text
    --html $ "<p>yay! got some stuff, but not really</p>"

--    S.status status404
  get "/files" $ do
    files <- liftIO $ getDirectoryContents "Datas"
-- there must be a nice way to generate html and the strings ?
-- How can I search for it?
    html $ mconcat $ map (\x -> LT.pack (mconcat ["<a>", x, "</a>"])) files
    
  get "/:word" $ do
    beam <- param "word"
    let beam' = renderHtml $ markdown def beam
    html $ mconcat ["<h1>Scotty, ",beam', " me up!</h1>"]

renderMarkdown :: String -> IO (Maybe LT.Text)
renderMarkdown filename = do
  let f = "Datas/" ++ filename
  exists <- doesFileExist f
  if exists 
    then do
      text <- readFile f
      return . return . renderHtml $ markdown def $ LT.pack text
    else
      return Nothing

display :: Maybe LT.Text -> ActionM ()
display Nothing = do
  S.status status404
  html $ "booo 404 for youoo"
display (Just t) = html t

--- create links to the files
--- saves the files
-- private function <- so that you can generate all your pages
