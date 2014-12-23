import Text.ParserCombinators.Parsec
import Control.Monad
import Data.Maybe

data Config = Config
	{ value1 :: String
	, value2 :: Int
	} deriving(Show)


type DictionaryItem = (String, String)
type Dictionary = [DictionaryItem]

config :: GenParser Char a Dictionary
config = endBy line eol

line :: GenParser Char a DictionaryItem
line = liftM2 (,) word (char '=' >> word)

word :: GenParser Char a String
word = many (noneOf "=\n")


eol = try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"

configValue1 :: Dictionary -> String
configValue1 = fromMaybe "" . lookup "value1"

configValue2 :: Dictionary -> Int
configValue2 = maybe 0 read .lookup "value2"

buildConfig :: String ->  Either ParseError Config 
buildConfig text = do
	dict <- parse config "" text
	return $ Config (configValue1 dict) (configValue2 dict)

main :: IO ()
main = do
	text <- readFile "config.txt"
	either print
		   (\cfg -> do
           putStrLn $ "The first value is: " ++ (value1 cfg)
           putStrLn $ "The second value is: " ++ (show (value2 cfg))
		   )
		   (buildConfig text)
		