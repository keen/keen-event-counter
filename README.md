# Count events 
Use this little ruby script to figure out which of your Keen event collections are collecting the most events.
Given a project specified in .env, the script runs a count for each collection in the project. 
At the end of the script, the counts will be outputted to a csv with a format like this:

project id | collection | count
--- | --- | ---
53dda0af3831aaaaa2000000 | BoughtProduct | 650
53dda0af3831aaaaa2000000 | GameCompletion | 11960
53dda0af3831aaaaa2000000 | UserStats | 154
53dda0af3831aaaaa2000000 | PauseGame | 4190
53dda0af3831aaaaa2000000 | PlayButton | 1224
53dda0af3831aaaaa2000000 | TutorialButton | 328

# Requirements
There are two packages required in order to run the counter.rb command. The first is the [Keen Command Line Interface](https://github.com/keen/keen-cli) which can be installed through the terminal via `gem install keen-cli`. The second is [dotenv](https://www.npmjs.com/package/dotenv) which can be also installed via the terminal w/ npm `npm install dotenv`


# Steps
1. Download counter.rb
2. In same folder as counter.rb, create .env file with the following variables:
  
   ```
   KEEN_PROJECT_ID=aaaaaaaaaaaaaaaa
   KEEN_READ_KEY=bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.....
   KEEN_MASTER_KEY=CCCCCCCCCCCCCCCCC
   ```
   
3. In terminal in same folder, run the command `ruby counter.rb previous_7_days`
4. You can modify the timeframe to be `previous_8_hours`, `previous_2_weeks`, or whatever timeframe you like.
5. Check the console output to see event totals for each collection as they come in. After the script is completed, you can also find the results in a csv file in the same folder. It should be named `event_counts_project_id_timeframe.csv`
