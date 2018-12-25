# Ruby Concurrent Execution Queue
A queue with synchronous and asynchronous tasks between the server and the clients implemented in Ruby

## Steps

1. Install [ruby](https://rubyinstaller.org/)
2. Download the executables (server_queue.rb and client_queue.rb)
3. First open the server 'server_queue.rb' and then the client 'client_queue.rb' or 
open both using the console of commands.

```bash
ruby server_queue.rb
ruby client_queue.rb
```
## How it works
At the beginning you must place your nickname for logging and then the server send you an options...
```bash
--------Options--------
Enter 1 - Synchronous Job
Enter 2 - Enqueue a Job
Enter 3 - Enqueue a Job in X Seconds
```
Option 1 to do a synchronous job and the server notifies you with...
```bash
Job Synchronous Completed 'Hello Josue'
```
Option 2 to enqueue a job in this moment and the server sends you an unique identifier for this job.
```bash
Enqueue Job id: 26760260
```
Option 3 to enqueue a job in X seconds that you want and the server sends you an unique identifier for this job.
```bash
Enqueue Job id: 26760920
```
# Extras
This works through TCP connections only on localhost on port 3000 and supports multi-connections of clients.
The server print the result of each job in a server log called 'server_log'

Enjoy it!
