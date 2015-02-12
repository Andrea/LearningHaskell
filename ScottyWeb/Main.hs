{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mconcat)
import qualified Data.Text.Lazy as LT
import Control.Monad
import Control.Monad.IO.Class (liftIO)
import Network.HTTP.Types (status404)
import System.Directory  
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as HA

import Text.Blaze.Html.Renderer.Text
import Text.Markdown
import qualified Web.Scotty as S


main = S.scotty 3000 $ do
  S.get"/files/:filename" $ do    
    filename <- S.param "filename"
    liftIO $ renderMarkdown filename    
    text <- liftIO $ renderMarkdown filename 
    display text

  S.get "/files" $ do
    files <- liftIO $ getDirectoryContents "Datas"

    S.html . renderHtml $ do
       H.h1 "Files By Name" 
       H.ul $ forM_ files (H.li . (H.a H.! HA.href "screen.css"). H.string )
       		
-- Here I am trying to list all the files however I am not sure how to deal with types, I think 
-- I'll figure it out, but I need to leave it here for today
--      H.ul $ do
--      mconcat $ Prelude.map (\x -> LT.pack (mconcat [H.a, x])) files

  S.get "/:word" $ do
    beam <- S.param "word"
    let beam' = renderHtml $ markdown def beam
    let s = mconcat ["Scotty, ",beam', " me up!"]
    S.html . renderHtml $ do
                    H.body $ do
                        H.h1 $ H.toHtml s -- Not ideal but getting there 
                        -- What would be the way to deliver this without needing to use toHtml (this adds p :( )

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


renderLink :: String -> H.Html
renderLink = undefined
--- create links to the files
--- saves the files
-- private function <- so that you can generate all your pages
