# In-Class Exercises for Equilibrium Modeling Course
Instructors: Steven A. Gabriel, Helmi Hankimaa, Lukas Barner

Date: October 2026

This repository contains a set of Jupyter notebooks meant to complement lectures on Equilibrium Modeling in Energy Markets. The repository contains three notebooks:

Module 1: Optimization Problems & Karush-Kuhn-Tucker (KKT) Conditions

Module 2: Mixed Complementarity Problems (MCPs) and Strategic Competition

Module 3: Bilevel Problems

Each notebook corresponds to a module in the course and includes several exercises. The notebooks are designed to be self-contained but are closely linked with the in-person lectures of the course. The notebooks implement optimization models in Julia using [JuMP](https://jump.dev). The problems are solved using open-source solvers, and the choice of solver depends on the problem type. The solvers used are HiGHS, Ipopt, SCIP, and PATH.

## Getting Started

To run the notebooks (`Module_1.ipynb`, `Module_2.ipynb`, `Module_3.ipynb`), you need to have Julia installed on your computer along with a Jupyter notebook environment.

### 1. Installation

In case you do not yet have a running Julia installation, please follow the
instructions below:

juliaup is a Julia installer and version multiplexer, see
[juliaup](https://github.com/JuliaLang/juliaup). We recommend you use juliaup to
install the Julia language. 

After the installation, you can check if everything works as expected by
typing julia in your command line (terminal/powershell). You should now see
the [Julia REPL prompt](https://docs.julialang.org/en/v1/stdlib/REPL/). 

We also strongly recommend using [Visual Studio Code](https://code.visualstudio.com) as an editor. 

In VS Code, you need to install the Julia and Jupyter extensions. To do so, go to the
“Extensions" view (on the left sidebar), search for the extension, and install
the respective extension. 

We will provide support during the first lecture in case you run into
problems. However, please make sure you have downloaded everything
beforehand.

### 2. Clone this repository

```
git clone https://github.com/helmihankimaa/Equilibrium_modeling_course_Berlin2026.git
```

### 3. Instantiate packages

From a terminal in the repository folder, run the following command once:

```
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

This step instantiates packages required in this course. 

### 4. Open and run a notebook

In VS Code, open this repository folder and start with one of the notebook files.

### 5. Select the Julia kernel and run a cell

Once the notebook is open, make sure the “Julia” kernel is selected. You can then run the notebook cells.

### 6. Running Julia scripts interactively

To run a Julia script interactively, open one of the scripts (.jl files), and press Shift+Enter on any line you would like to execute. 