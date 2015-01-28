{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mconcat)
import qualified Data.Text.Lazy as LT
import Control.Monad.IO.Class (liftIO)
import Network.HTTP.Types (status404)
import System.Directory  
import Text.Blaze.Html.Renderer.Text
import Text.Markdown
import qualified Web.Scotty as S
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A


main = S.scotty 3000 $ do
  S.get"/files/:filename" $ do    
    filename <- S.param "filename"
    liftIO $ renderMarkdown filename
    -- 25/01 doing the side effect first and then displaying
    text <- liftIO $ renderMarkdown filename 
    display text


--    S.status status404
  S.get "/files" $ do
    files <- liftIO $ getDirectoryContents "Datas"
-- there must be a nice way to generate html and the strings ?
-- How can I search for it?
    S.html $ mconcat $ Prelude.map (\x -> LT.pack (mconcat ["<a>", x, "</a>"])) files
    
  S.get "/:word" $ do
    beam <- S.param "word"
    let beam' = renderHtml $ markdown def beam
    S.html $ mconcat ["<h1>Scotty, ",beam', " me up!</h1>"]

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

display :: Maybe LT.Text -> S.ActionM ()
display Nothing = do
  S.status status404
  S.html $ "boo 404 for you!!"
display (Just t) = S.html t

--- create links to the files
--- saves the files
-- private function <- so that you can generate all your pages
