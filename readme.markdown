# condavision
## Automatic Python Environment ProVisioning with Conda

[Conda](https://conda.io/docs/index.html) is an environment manager similar to virtualenv, but it features automatic dependency resolution that has made it a joy for me to use. To get a python environment set up with conda, its only a matter of running something like:
```sh
conda --name whateveryouwant python=2.7 a list of modules you need
```
You can then enter this environment at any time by calling `source activate whateveryouwant` and then run scripts from there. 

### So what do I need condavision for?
But what if I don't want to run scripts interactively? I have python scripts that I want to execute as a web API, but they all require different versions of pythons and python packages, so I needed a way to automate creating environments at runtime.
[Conda Execute](https://github.com/conda-tools/conda-execute) aims to solve the same problem, but it introduces a new syntax to declare dependencies as a comment inside python files, and I couldn't get it to recognize that I needed a python less than 3, so I went ahead and wrote a bash script that does the following:

1. Scan through files in PYTHONPATH to get the names of modules that might be defined locally
2. Combine that with a list of modules python includes to get a list of modules I don't want to ask conda to install (`conda create` will throw an error if you say you need the `sys` built in module, for example)
3.  perform regex on the python file I want to execute (and all python scripts in PYTHONPATH) to extract all the modules required
4. compare the results of regex with the list in step 2 to get a new list of modules I need to ask conda to take care of for me
5. create a hash representing the combination of modules so I can compare it with environments that were created earlier
6. if there is no existing conda environment that matches that hash, I create one
7. then I activate the necessary environment and in that environment, execute the script

## Install
You need to have Conda installed on your system before I can do anything for you, [install instructions for conda aka miniconda here.](https://conda.io/miniconda.html)
Once you can run `conda --version`, the next step is just:
```
git clone https://github.com/jazzyjackson/condavision.git
cd condavision
bash condavision.sh
```
condavision without any arguments will link itself to /usr/local/bin so you can use it anywhere.

## Usage
After the install step, you can run any python file on your system with 'condavision' instead of 'python' - this will create an environment containing just the modules required by your script and version of python. You can modify the script but I have it defaulting to python 3.6 if you don't provide a python version. However, you can try the example.py script included in this repo with any version of python:
```
condavision python=2.7 example.py
```
or
```
condavision python=3.5 example.py
```
And you can see that conda will resolve dependencies, download whatever it needs to, and once that's done it will run the program passed into it.

It also checks your PYTHONPATH and installs dependencies for any of your own modules.

condavision prints out the progress of condavision and some of my own messages. If you want it to run silently you'll have to comment out some echoes and redirect some processes to /dev/null - actually if someone wants to add a --silent flag feature that'd be great.

