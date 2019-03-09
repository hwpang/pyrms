using Pkg

pyout = Pipe()
proc1 = run(pipeline(`python -V`,stdout=pyout))
close(pyout.in)
pyversion = chomp(String(read(pyout)))
println("python version: $pyversion")

#get the python path
if !("PyCall" in keys(Pkg.installed()))
    out = Pipe()
    proc = run(pipeline(`which python`,stdout=out))
    close(out.in)
    pypath = chomp(String(read(out)))

    #set env variables for installing PyCall
    ENV["CONDA_JL_HOME"] = join(split(pypath,'/')[2:end-2],'/')
    ENV["PYTHON"] = pypath
    Pkg.add("PyCall")
    Pkg.build("PyCall")
end

Pkg.add("ReactionMechanismSimulator")
using PyCall
using ReactionMechanismSimulator
