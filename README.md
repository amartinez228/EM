# C and Scheme

This assignment will include material related to the Sheme and the C programming languages.  

In this assignment you are going to run an experiment to compare the speeds of execution of the Scheme and the C programs for computing the Ehrenfeucht-Mycielski sequence.

You should run this experiment in the terminal. You can time runtime in Scheme as follows:
```scheme
(with-timings
  (lambda ()
    (em "010100100110100101010"))
  (lambda (run-time gc-time real-time)
    (write (internal-time/ticks->seconds run-time))
    (write-char #\space)
    (write (internal-time/ticks->seconds gc-time))
    (write-char #\space)
    (write (internal-time/ticks->seconds real-time))
    (newline)))
```
You can time a c program as follows, in the command prompt of the Programming Languages terminal:
```c
time em 25
0100110101110001000011110

real    0m0.001s
user    0m0.001s
sys     0m0.000s
```
where `em` is the executable of `em.c`.  Note that `em.c` computes the _n_-th number in the EM sequence. 

Note that while both `em.scm` and `em.c` compute EM, their outputs are a bit different. `em.scm` outputs the next bit for a given sequence; `em.c` computes the _n_-th string in the sequence. 

The experiment should be run as follows: for each integer _n_ in 10 to 30 find the average running time for each algorithm on 10% of randomly selected strings of length _n_. So you should end up with a table like this:

| n | Scheme | C |
|---|---|---|
|10| $s_{10}$ | $t_{10}$ |
|11| $s_{11}$ | $t_{11}$ |
|12| $s_{12}$ | $t_{12}$ |

where for example $t_{12}$ is the average time of running the C program `em` on strings of length 12 (there are $2^{12}$ such strings, but we only need to look at $0.1\cdot 2^{12}$ of them, i.e., 102 of them).   

Once the table is built, plot it with `matplotlib` in a Jupyter Notebook; use file `solution.ipynb` for that purpose.