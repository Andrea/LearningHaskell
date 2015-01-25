Remember... this is a brain dump, it probably makes no sense.

### Day 0

Today I m going to stream trying to create a simple website with Haskell

### What we want to achieve
- the website should render markdown files
- we will use Scotty http://hackage.haskell.org/package/scotty
- ideally I would like to deploy this today but ... we'll see how it goes

### What happened 

#### Day 1

* Cabal not up to date
* run `cabal install cabal-install`
* cabal sandbox was still not available so running again from git bash
* sandbox was just not working so I just kept going, probably means that I'm destroying this machine as a development environment but I just wanted to get started doing some stuff
* Kept going changing the cabal file as stated here http://adit.io/posts/2013-04-15-making-a-website-with-haskell.html
* ... downloads the whole internet :D My guess is that this is either the heroku tools or I did something really stupid =) and there I was...wanting to write some haskell ... 

* Just found this http://activedeveloper.info/practical-haskell-converting-markdown-to-html.html

## Day 2 

* Now trying to list all files in a directory 
* The difficulty , I find is not so much on what you think you should do but understand what libs to use when, but maybe I am delusional, one example is I couldn't find what lift I should use (ie what import to use, it was ```import Control.Monad.IO.Class (liftIO)```)

### Another few days

Even tho I saw the ```do``` notation before, because I have to use it, I am starting to understand why this is so good, [this](http://en.wikibooks.org/wiki/Haskell/do_notation) might be useful for context

```Haskell
  do
    text <- readFile f
    return . return . renderHtml $ markdown def $ LT.pack text  
```

This pattern seems to be be pretty common, and that is , I guess because we are always doing stuff with the IO monad.

Really liked how simple is was to compose this 404 too
```Haskell
display Nothing = do
  S.status status404
  html $ "booo 404 for youoo"
```



