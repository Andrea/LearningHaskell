Learning Haskell
===============

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Andrea/LearningHaskell?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

These notes are personal, not sure how much sense they would make to anyone else. i.e read at your own risk :d
#### Language basic things that I might forget (according to me )

* if needs else
* if is an expression 
* an expression is code that returns a value
* valid in functions name, usually used a non lazy function (strict)
* Functions names start with lowercase 
* When a function doesn't take any parameters, we usually say it's a definition (or a name). Because we can't change what names (and functions) mean once we've defined them
* not sure how I feel about throwing exceptions

### File Parser

#### Project setup with Cabal

* Use *cabal sandbox init*
* Use *cabal init*
* Use *cabal build*
 

```Haskell 
data Config = Config
{ value1 :: String
, value2 :: Int
} deriving(Show)
``` 

Using Show , Show is a typeclass

Applicative are functors

```Haskell 
import Control.Monad
import Data.Maybe

<*> --apply method
<$> -- fmap

liftM2
fromMaybe
forceEither
```

#### Check out

* Stackage
