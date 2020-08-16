# /vg/ ss40k
[![forinfinityandbyond](https://user-images.githubusercontent.com/5211576/29499758-4efff304-85e6-11e7-8267-62919c3688a9.gif)](https://www.reddit.com/r/SS13/comments/5oplxp/what_is_the_main_problem_with_byond_as_an_engine/dclbu1a)

Forked from /vg/station.

Discord: https://discord.gg/5F9sQDF



---

### SQL Setup
To use the SQLite preferences, rename players2_empty.sqlite to players2.sqlite

The SQL backend for the library and stats tracking requires a MySQL server.  (Linux servers will need to put libmysql.so into the same directory as vgstation13.dme.)  Your server details go in /config/dbconfig.txt.

The database is automatically installed during server startup, but you need to ensure the database and user are present and have necessary permissions.
