# Run Man(ager)
Run Man (`runman`) is a humble wrapper around [task-spooler](http://viric.name/soft/ts/) (`tsp`) for easily scheduling and managing jobs in any multicore Linux node. Basically, it's nothing but a poor and lazy man's workload manager. If [SLURM](https://slurm.schedmd.com/documentation.html), [PBS](https://www.openpbs.org/) and the likes seem like an overkill for your multiprocessing needs, and vanilla `tsp` seems too low-level, then `runman` might be your thing.

### Features
- User submits [`.job`](/example.job) file that lists her requirements such as  
    - command/script/executable to be run
    - number of processors needed
    - paths to store STDOUT and/or STDERR
    - max. execution time (wall clock)
    - working directory
    - dependency on a previous job
- User is notified via [Telegram](https://telegram.org/) on job completion by a [bot](https://github.com/fabianonline/telegram.sh).
- Usual job management tools such as - status query, abort/removal, prioritization.

### Installation
```bash
# Download
curl -LO https://raw.githubusercontent.com/SomajitDey/runman/main/runman

# Set permission
chmod a+rx ./runman

# Install at PATH
sudo install ./runman /usr/local/bin/

# Local installation (for non-sudoers).
export PATH="${HOME}/.bin:${PATH}" # Put this in ~/.bashrc.
install -D -t "${HOME}"/.bin/ ./runman
```
Also install [`tsp`](https://command-not-found.com/tsp), [`telegram`](https://github.com/fabianonline/telegram.sh#installation--configuration) and [`curl`](https://command-not-found.com/curl).

### Usage
```bash
runman help
```