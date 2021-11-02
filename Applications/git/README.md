# Git Application test

This test tests a file-system's performance creating and manipulating small files by cloning the Spack repository.

Slow file-systems time out while doing this.  

The test is simple:

```console
$ time git clone https://github.com/spack/spack.git
Cloning into 'spack'...
remote: Enumerating objects: 325196, done.
remote: Counting objects: 100% (525/525), done.
remote: Compressing objects: 100% (321/321), done.
remote: Total 325196 (delta 207), reused 376 (delta 120), pack-reused 324671
Receiving objects: 100% (325196/325196), 134.56 MiB | 3.37 MiB/s, done.
Resolving deltas: 100% (140857/140857), done.
Updating files: 100% (8707/8707), done.

real	11m42.167s
user	0m27.791s
sys	0m7.893s
```

This test is pass/fail.