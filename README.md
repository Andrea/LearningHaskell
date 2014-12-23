Learning Haskell
===============
These notes are personal, not sure how much sense they would make to anyone else. i.e read at your own risk :d

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

Applicatives
```Haskell 
<*>
<$>
```

#### Check out

* Stackage
