# LaTeX Paper on Fair Division Implications

* Paper title: Exploring Relations among Fairness Notions in Discrete Fair Division
* Authors: Jugal Garg, Eklavya Sharma
* Published versions: [arXiv:2502.02815](https://arxiv.org/abs/2502.02815),
  [doi:10.65109/DRAH3963](https://doi.org/10.65109/DRAH3963) (AAMAS'26).

A [github workflow](https://docs.github.com/en/actions) automatically builds
assets for every push to `master`:
[paper.pdf](https://sharmaeklavya2.github.io/fd-impls/paper.pdf),
[texRefs.json](https://sharmaeklavya2.github.io/fd-impls/texRefs.json).

## Building the LaTeX document

To build the PDF, just run `make`.

[`extractTexRefs.py`](https://github.com/sharmaeklavya2/extractTexRefs)
can help map `\label`s in the LaTeX source to numbers and links used in the PDF:

    python3 extractTexRefs.py build/fimp.aux -o texRefs.json

## Building the PDF using Docker

1.  First, you need to build the `texlive-dev` docker image. To do so, clone [github:sharmaeklavya2/tex-from-docker](https://github.com/sharmaeklavya2/tex-from-docker) and run `docker build -t texlive-dev docker` in that repository.
2.  Then run `docker run -it -v $(pwd):/workspace texlive-dev` in this paper's repository. This will start a docker container, install the latex packages in `texlive-packages.txt` using `tlmgr`, and drop you into a bash shell in the container.
3.  From the bash shell, run `make`. You can view the build log in `build/fimp.log`.
