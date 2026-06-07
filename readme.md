# Building the LaTeX document

Just run `make`.

## Using Docker

1.  First, you need to build the `texlive-dev` docker image. To do so, clone [github:sharmaeklavya2/tex-from-docker](https://github.com/sharmaeklavya2/tex-from-docker) and run `docker build -t texlive-dev docker` in that repository.
2.  Then run `docker run -it -v $(pwd):/workspace texlive-dev` in this paper's repository. This will start a docker container, install the latex packages in `texlive-packages.txt` using `tlmgr`, and drop you into a bash shell in the container.
3.  From the bash shell, run `make`. You can view the build log in `build/fimp.log`.
