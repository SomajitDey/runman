# Run Man(ager)
Run Man (`runman`) is a humble wrapper around [task-spooler](http://viric.name/soft/ts/) (`tsp`) for easily scheduling and managing jobs in any multicore Linux node. Basically, it's nothing but a poor and lazy man's workload manager. If [SLURM](https://slurm.schedmd.com/documentation.html), [PBS](https://www.openpbs.org/) and the likes seem like an overkill for your multiprocessing needs, and vanilla `tsp` seems too low-level, then `runman` might be your thing.

### Features
- System-wide task-spooler queue with as many slots as number of CPUs in the system.
- `USER` submits [`.job`](/example.job) file that lists her requirements such as  
    - command/script/executable to be run
    - number of processors needed
    - paths to store STDOUT and/or STDERR
    - max. execution time (wall clock)
    - working directory
    - dependency on a previous job
- `USER` is notified via [Telegram](https://telegram.org/) on job completion by a [bot](https://github.com/fabianonline/telegram.sh).
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
Also install [`tsp`](https://command-not-found.com/tsp), [`telegram`](https://github.com/fabianonline/telegram.sh#installation--configuration), [`jq`](https://command-not-found.com/jq) and [`curl`](https://command-not-found.com/curl).

### Usage
```bash
runman help
```

### Pro tip
In a *trusted* environment, the sysadmin may [create](https://github.com/fabianonline/telegram.sh#installation--configuration) a single telegram bot to serve all the `USER`s. The token may be saved in the global config `/etc/telegram.sh.conf` as the key-value pair:
```bash
TELEGRAM_TOKEN='123456:AbcDefGhi-JlkMno'
```
In such a case, all the `USER`s must be sent the Telegram address of the bot: `@<bot_username>` or `https://t.me/<bot_username>` so they can subscribe to the feed using 
```bash
runman tgfeed
```

### Known Issue(s)
- The key value pair `stderr=<path>` provided in `.job` file doesn't work, atleast in Ubuntu 20.04. The underlying reason seems to be a bug in task-spooler itself: `tsp -E` doesn't work as expected.

- `runman` can't kill orphaned processes spawned by a job that has finished. The orphaned processes may consume CPU time at the background unbeknownst to `runman` or its core `tsp`. Hence, until fixed, it's the job of the user to make sure her job doesn't create (resource consuming) orphaned processes. For example, if her shell script spawns processes in background with `&`, she must use the `wait` statement at the end of her script, so that her job finishes only after all her spawned processes have exited.
