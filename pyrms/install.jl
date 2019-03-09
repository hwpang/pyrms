using Pkg

#get the python path
out = Pipe()
proc = run(pipeline(`which python`,stdout=out))
close(out.in)
pypath = chomp(String(read(out)))

#set env variables for installing PyCall
ENV["CONDA_JL_HOME"] = join(split(s,'/')[2:end-2],'/')
ENV["PYTHON"] = pypath

Pkg.add("PyCall")
Pkg.build("PyCall")
Pkg.add("ReactionMechanismSimulator")
using PyCall
using ReactionMechanismSimulator