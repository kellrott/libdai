import os

AddOption('--prefix',
                  dest='prefix',
                  type='string',
                  nargs=1,
                  action='store',
                  metavar='DIR',
                  help='installation prefix')

AddOption('--test',
				dest='test',
				action='store_true',
				default=False)

PREFIX = GetOption('prefix')
if PREFIX is None:
	PREFIX="/usr/local/"

SOURCE = [
	"src/graph.cpp",
	"src/bp.cpp",
	"src/dag.cpp",
	"src/bipgraph.cpp",
	"src/varset.cpp",
	"src/daialg.cpp",
	"src/alldai.cpp",
	"src/clustergraph.cpp",
	"src/factor.cpp",
	"src/factorgraph.cpp",
	"src/properties.cpp",
	"src/regiongraph.cpp",
	"src/util.cpp",
	"src/weightedgraph.cpp",
	"src/exceptions.cpp",
	"src/exactinf.cpp",
	"src/evidence.cpp",
	"src/emalg.cpp",
	"src/io.cpp",
	"src/bp_dual.cpp",
	"src/bbp.cpp",
	"src/cobwebgraph.cpp",
	#other methods, not yet optional in scons build
	"src/fbp.cpp",
	"src/trwbp.cpp",
	"src/mf.cpp",
	"src/hak.cpp",
	"src/lc.cpp",
	"src/jtree.cpp",
	"src/treeep.cpp",
	"src/mr.cpp",
	"src/gibbs.cpp",
	"src/cbp.cpp",
	"src/decmap.cpp",
	"src/glc.cpp"
]


engine_targets = [
"-DDAI_WITH_BP",
"-DDAI_WITH_FBP",
"-DDAI_WITH_TRWBP",
"-DDAI_WITH_MF",
"-DDAI_WITH_HAK",
"-DDAI_WITH_LC",
"-DDAI_WITH_TREEEP",
"-DDAI_WITH_JTREE",
"-DDAI_WITH_MR",
"-DDAI_WITH_GIBBS",
"-DDAI_WITH_CBP",
"-DDAI_WITH_DECMAP",
"-DDAI_WITH_GLC"
]

env = Environment(
#	CPPFLAGS="-arch i386",
#	LINKFLAGS="-arch i386",
	CPPFLAGS=" ".join(engine_targets),
	CPPPATH=[ os.path.join(Dir('#').abspath,'include'), '/opt/local/include', os.path.join(PREFIX, "include") ], 
	LIBPATH = ['/opt/local/lib', os.path.join(PREFIX, "lib") ],
	build_dir="build"
)

shared_lib = env.StaticLibrary("dai", SOURCE, LIBS=['gmpxx', 'gmp'])
static_lib = env.SharedLibrary("dai", SOURCE, LIBS=['gmpxx', 'gmp'])

Export("env")
if GetOption('test'):
	env.Alias("test", SConscript('tests/Sconscript'))
env.Alias("all", [shared_lib, static_lib])
env.Alias("install", env.Install(os.path.join(PREFIX, "lib"), [shared_lib, static_lib]))

header_files = Glob('include/dai/*.h')

env.Alias("install", env.Install(os.path.join(PREFIX, "include", "dai"), header_files))
