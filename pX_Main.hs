{-|
Module      : main
Description : The following program will read input from the command line and present a greeting
License     : GPL-3
Maintainer  : ojd2@st-andrews.ac.uk
Stability   : experimental / tutorial
Portability : POSIX

Program Notes & Concepts: 

	- Type declarations in Haskell are open and accessible: the GHC figures and identifies type 
	  declarations automatically, and only throws errors if the type declaration is different 
	  from what's been declared.
	
	- The following IO type, you will come across very often. The IO is an instance of the Monad 
	  class (a class of types and type declarations).

	- What is a Monad?

	  - A Monad is a computational structure that specifies an order for a set of actions, 
	    and hides an internal value (which is often, but not necessarily a state). 
	    You start with some default internal value, apply a series of actions and end up with a 
	    final internal value:
	   
	- A1 -> A2 ... -> An

	- or in Haskell
	   
	- A1 >>= A2 ... >>= An

	- Actions normally take an argument and return a result that is passed on to the next action,
	  e.g: inc = get >>= \ n -> put (n+1)

    - You might read a value from some internal state (using get), then pass it on to the 
      second action (as n).

	- The second action updates the internal state (using put).

	- So, if your internal value started at 0, you would end up with 1 internally, 
	  having processed all the actions.

	- The actions themselves, and the composition of actions (e.g. inc) are all pure functions. 
	
	- Nothing happens until you pass some specific initial internal value.

	- With this in mind, any "value attached with (hidden) information" is known as a "Monadic value". 

	- In the program below we begin by passing a void() value, not an [IO String]. 

	- The concept of a Monad comes from category theory. Much of the interest in Monads in functional 
	  programming is the result of recent papers that show how Monads can be used to describe all 
	  kinds of different programming language features (for example, I/O, manipulation of state, 
	  continuations and exceptions) in purely functional languages such as Haskell.
-}

-- First, import the system module using the alias 'main'.
module main where
import System.Enviornment
	-- Next, perform a type declaration of type IO().
	main:: IO() -- IO action carrying along values of unit type () which means void.
	-- Note: Haskell is a functional language: instead of giving the computer a 
	-- predefined sequence of instructions to execute, you use a collection of declarations
	-- and definitions, that tell the machine how to perform every function it might need. 
 	main = do -- Begin our do-block.
	  args <- getArgs -- Capture the argument using getArgs method.

  	  -- Now we could initially use the following: putStrLn ("Hello, " + args !!0).
  	  
	  -- However, we want to make our program read two arguments (args) using the 
	  -- getArgs built in Monad Action and display both arguments using the 
	  -- putStrLn Monad Action. 

	  -- Note: There are two ways to create an I/O action. 

	  -- You can either perform directly within the IO context or call a function from within the 
	  -- IO context:
      	-- 1) 'Lift' an ordinary value into the I/O monad, using the return function.
      	-- 2) OR Combine two existing I/O actions.	
     
      -- To keep things simple, we will combine two existing I/O actions.

	  -- This particular do-block takes the first element of the argument list (at index 0), 
      -- concatenates it onto the end of the string "Hello, ", and finally passes the arg to a 
      -- putStrLn which creates new IO action, participating in the do-block sequencing.
	  putStrLn ("Hello, " ++ args !!0  ++ args !!1) -- Note,'++' concatenation & index values (0,1).

	  -- However, we may wish to water this down and apply some more concrete rules.
	  -- The following do-block above makes use of the getArgs method. In Haskell, there are
	  -- other associative I/O methods that can be operated such as getEnv, getLine, getContents, 
	  -- readFile, writeFile and so on...

	  -- If we were to re-work the following do-loop to be more accurate and wish to 
	  -- retrieve a users name only, we could use the following instance instead:
	  main = do putStrLn "What do they call you darling?"
	  	name <- getLine
	  	putStrLn ("Hello, " ++ name)



