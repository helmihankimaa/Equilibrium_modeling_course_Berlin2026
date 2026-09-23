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

### 1. Install Julia

Download and install Julia from [julialang.org/downloads](https://julialang.org/downloads/) (tested with version 1.12).

### 2. Clone this repository

```
git clone https://github.com/helmihankimaa/Equilibrium_modeling_course_Berlin2026.git
```

### 3. Install the Jupyter kernel for Julia

From a terminal in the repository folder, run the following command once:

```
julia -e 'using Pkg; Pkg.add("IJulia")'
```

This registers a "Julia" kernel that Jupyter or VS Code can use to run the notebooks.

### 4. Open and run a notebook

You can open the notebooks either with a Jupyter server or directly in VS Code.

**Option A: Jupyter server**

From a terminal in the repository folder, run:

```
julia -e 'using IJulia; notebook()'
```

This will start a Jupyter server and open the repository in your web browser. Click on one of the notebooks to start a new kernel and run it.

**Option B: VS Code**

Open [Visual Studio Code](https://code.visualstudio.com), install the Jupyter and Julia extensions, then open this repository folder and open one of the notebook files directly.

### 5. Select the Julia kernel and run the setup cell

Once a notebook is open, make sure the "Julia" kernel is selected. Then run the first code cell. It activates the project's pinned environment (`Project.toml`/`Manifest.toml`, already included in this repository) and installs the exact package versions used to build the notebooks (JuMP, HiGHS, Ipopt, SCIP, PATHSolver, Plots, DataFrames):

```julia
using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
```

This only needs to fully download packages the first time; after that it activates instantly.
