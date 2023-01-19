# Underneath: Humans vs. Worm

Humans' view               | Worm's view
:-------------------------:|:-------------------------:
<img src="https://msespos.github.io/portfolio/imgs/underneath%20humans%20screenshot.png" alt="Screenshot of Underneath game, humans' view" width="200"/> | <img src="https://msespos.github.io/portfolio/imgs/underneath%20worm%20screenshot.png" alt="Screenshot of Underneath game, worm's view" width="200"/>

Underneath is a two player online board game, pitting four humans against one subterranean worm. One player controls the humans' movement (on the "surface"), and the other player controls the worm's (below the "surface", and breaking through to the "surface" every four turns). The humans win if at least one human defeats the worm with a bomb when it surfaces. The worm wins if it eats all of the humans over four different turns when it surfaces.

The board is an 8x8 grid. The humans start spread out along one corner of the board, and the worm starts below ground in the opposite corner. During the game, the humans and the worm have different views, so that no player ever sees the complete picture of the other's moves. What each player can see depends on the other's position(s) as well as whether the worm is surfacing that turn. The left image above shows the humans' view at one point in the game, and the right image above shows the worm's view at the same point.

Throughout the game, the humans must position themselves strategically while gathering as many bombs as they can, while they wait for the worm to surface so that they can try to defeat it. The worm must use its vibration sensing abilities to make educated guesses as to where the humans are and try to eat them one by one.

This game was conceived as a fun, weird, unconventional project for ME and AA to collaborate on in order to work on Ruby on Rails and OOP in particular (for ME in particular), as well as learn other technologies. The back end was built by ME with Ruby on Rails, uses Postgres, and was tested with RSpec and Capybara. The front end was built by AA and uses React and Tailwind.

To play the game, visit the following link:

https://floating-scrubland-32569.herokuapp.com/

Please allow a small wait time (typically less than 30 seconds) for Heroku's dyno to wake up.

One player should load a game in one browser window, and the other player should join that game using a separate device. If you want to see both views on the same device, use two different browsers, though it won't be much fun as you'll be able to see both sides of the board.

***Massive thanks to AA for their contributions to this project, in the forms of creating the front end as well as mentoring ME throughout.***
