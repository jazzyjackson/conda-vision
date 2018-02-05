#!/bin/bash
if [ $# -eq 0 ]
then 
    if which condavision
    then
        echo "no arguments. condavision is already on your path, exiting"
        exit
    else
        echo "adding condavision to path"
        # you could link a different script to condavision to change default behavior. if you want 36
        ln condavision27.sh /usr/bin/condavision
        ln condavision36.sh /usr/bin/condavision3
        exit
    fi
fi

# set python version, grab name of script, and slice arguments

pythonversion="python=3.6" # if there's only one argument default to python 3.6 
pythonscript=$1            # and use first argument as python script
pyargs=$"${@:2}"           # any remaining arguments will be passed to python

echo "version:" $pythonversion
echo "script:" $pythonscript
echo "args:" $pyargs

if [ $PYTHONPATH ] # if PYTHONPATH variable is set, include python files therein in a list of modules not to add via conda (they're already here!)
then
    # also get the names of the python files in python path and consider them possible modules that conda shouldn't try to isntall on its own
    pypathfiles=$(echo -e "$pythonscript\n$(find -f $PYTHONPATH | grep ".py$")")
    localmod=$(cut -f 1 -d '.' <(grep .py <(ls -R1 $PYTHONPATH)))    
else
    # if PYTHONPATH isnt set consider list of local modules blank
    pypathfiles=$pythonscript
    localmod=""
fi
# plus a sorted string containing all the built in modules for python 2.7, 3.5 and 3.6, sure there's python functions that can print these out, but the whole point is I don't know what version of python I have installed, and besides I don't want to wait around for python to launch and import stuff when I can just embed a big string in this file
builtins="BaseHTTPServer\nBastion\nCGIHTTPServer\nCarbon\nCarbon.AE\nCarbon.AH\nCarbon.App\nCarbon.Appearance\nCarbon.CF\nCarbon.CG\nCarbon.CarbonEvents\nCarbon.CarbonEvt\nCarbon.Cm\nCarbon.Components\nCarbon.ControlAccessor\nCarbon.Controls\nCarbon.CoreFounation\nCarbon.CoreGraphics\nCarbon.Ctl\nCarbon.Dialogs\nCarbon.Dlg\nCarbon.Drag\nCarbon.Dragconst\nCarbon.Events\nCarbon.Evt\nCarbon.File\nCarbon.Files\nCarbon.Fm\nCarbon.Folder\nCarbon.Folders\nCarbon.Fonts\nCarbon.Help\nCarbon.IBCarbon\nCarbon.IBCarbonRuntime\nCarbon.Icns\nCarbon.Icons\nCarbon.Launch\nCarbon.LaunchServices\nCarbon.List\nCarbon.Lists\nCarbon.MacHelp\nCarbon.MediaDescr\nCarbon.Menu\nCarbon.Menus\nCarbon.Mlte\nCarbon.OSA\nCarbon.OSAconst\nCarbon.QDOffscreen\nCarbon.Qd\nCarbon.Qdoffs\nCarbon.Qt\nCarbon.QuickDraw\nCarbon.QuickTime\nCarbon.Res\nCarbon.Resources\nCarbon.Scrap\nCarbon.Snd\nCarbon.Sound\nCarbon.TE\nCarbon.TextEdit\nCarbon.Win\nCarbon.Windows\nColorPicker\nConfigParser\nCookie\nDEVICE\nDocXMLRPCServer\nEasyDialogs\nFL\nFrameWork\nGL\nHTMLParser\nMacOS\nMimeWriter\nMiniAEFrame\nNav\nPixMapWrapper\nQueue\nSUNAUDIODEV\nScrolledText\nSimpleHTTPServer\nSimpleXMLRPCServer\nSocketServer\nStringIO\nTix\nTkinter\nUserDict\nUserList\nUserString\nW\n__builtin__\n__future__\n__main__\n_dummy_thread\n_thread\n_winreg\nabc\naepack\naetools\naetypes\naifc\nal\nanydbm\napplesingle\nargparse\narray\nast\nasynchat\nasyncio\nasyncore\natexit\naudioop\nautoGIL\nbase64\nbdb\nbinascii\nbinhex\nbisect\nbsddb\nbuildtools\nbuiltins\nbz2\ncPickle\ncProfile\ncStringIO\ncalendar\ncd\ncfmfile\ncgi\ncgitb\nchunk\ncmath\ncmd\ncode\ncodecs\ncodeop\ncollections\ncollections.abc\ncolorsys\ncommands\ncompileall\ncompiler\ncompiler.ast\ncompiler.visitor\nconcurrent\nconcurrent.futures\nconfigparser\ncontextlib\ncookielib\ncopy\ncopy_reg\ncopyreg\ncrypt\ncsv\nctypes\ncurses\ncurses.ascii\ncurses.panel\ncurses.textpad\ndatetime\ndbhash\ndbm\ndbm.dumb\ndbm.gnu\ndbm.ndbm\ndecimal\ndifflib\ndircache\ndis\ndistutils\ndistutils.archive_util\ndistutils.bcppcompiler\ndistutils.ccompiler\ndistutils.cmd\ndistutils.command\ndistutils.command.bdist\ndistutils.command.bdist_dumb\ndistutils.command.bdist_msi\ndistutils.command.bdist_packager\ndistutils.command.bdist_rpm\ndistutils.command.bdist_wininst\ndistutils.command.build\ndistutils.command.build_clib\ndistutils.command.build_ext\ndistutils.command.build_py\ndistutils.command.build_scripts\ndistutils.command.check\ndistutils.command.clean\ndistutils.command.config\ndistutils.command.install\ndistutils.command.install_data\ndistutils.command.install_headers\ndistutils.command.install_lib\ndistutils.command.install_scripts\ndistutils.command.register\ndistutils.command.sdist\ndistutils.core\ndistutils.cygwinccompiler\ndistutils.debug\ndistutils.dep_util\ndistutils.dir_util\ndistutils.dist\ndistutils.emxccompiler\ndistutils.errors\ndistutils.extension\ndistutils.fancy_getopt\ndistutils.file_util\ndistutils.filelist\ndistutils.log\ndistutils.msvccompiler\ndistutils.spawn\ndistutils.sysconfig\ndistutils.text_file\ndistutils.unixccompiler\ndistutils.util\ndistutils.version\ndl\ndoctest\ndumbdbm\ndummy_thread\ndummy_threading\nemail\nemail.charset\nemail.contentmanager\nemail.encoders\nemail.errors\nemail.generator\nemail.header\nemail.headerregistry\nemail.iterators\nemail.message\nemail.mime\nemail.parser\nemail.policy\nemail.utils\nencodings\nencodings.idna\nencodings.mbcs\nencodings.utf_8_sig\nensurepip\nenum\nerrno\nexceptions\nfaulthandler\nfcntl\nfilecmp\nfileinput\nfindertools\nfl\nflp\nfm\nfnmatch\nformatter\nfpectl\nfpformat\nfractions\nftplib\nfunctools\nfuture_builtins\ngc\ngdbm\ngensuitemodule\ngetopt\ngetpass\ngettext\ngl\nglob\ngrp\ngzip\nhashlib\nheapq\nhmac\nhotshot\nhotshot.stats\nhtml\nhtml.entities\nhtml.parser\nhtmlentitydefs\nhtmllib\nhttp\nhttp.client\nhttp.cookiejar\nhttp.cookies\nhttp.server\nhttplib\nic\nicopen\nimageop\nimaplib\nimgfile\nimghdr\nimp\nimportlib\nimportlib.abc\nimportlib.machinery\nimportlib.util\nimputil\ninspect\nio\nipaddress\nitertools\njpeg\njson\njson.tool\nkeyword\nlib2to3\nlinecache\nlocale\nlogging\nlogging.config\nlogging.handlers\nlzma\nmacerrors\nmacostools\nmacpath\nmacresource\nmailbox\nmailcap\nmarshal\nmath\nmd5\nmhlib\nmimetools\nmimetypes\nmimify\nmmap\nmodulefinder\nmsilib\nmsvcrt\nmultifile\nmultiprocessing\nmultiprocessing.connection\nmultiprocessing.dummy\nmultiprocessing.managers\nmultiprocessing.pool\nmultiprocessing.sharedctypes\nmutex\nnetrc\nnew\nnis\nnntplib\nnumbers\noperator\noptparse\nos\nos.path\nossaudiodev\nparser\npathlib\npdb\npickle\npickletools\npipes\npkgutil\nplatform\nplistlib\npopen2\npoplib\nposix\nposixfile\npprint\nprofile\npstats\npty\npwd\npy_compile\npyclbr\npydoc\nqueue\nquopri\nrandom\nre\nreadline\nreprlib\nresource\nrexec\nrfc822\nrlcompleter\nrobotparser\nrunpy\nsched\nsecrets\nselect\nselectors\nsets\nsgmllib\nsha\nshelve\nshlex\nshutil\nsignal\nsite\nsmtpd\nsmtplib\nsndhdr\nsocket\nsocketserver\nspwd\nsqlite3\nssl\nstat\nstatistics\nstatvfs\nstring\nstringprep\nstruct\nsubprocess\nsunau\nsunaudiodev\nsymbol\nsymtable\nsys\nsysconfig\nsyslog\ntabnanny\ntarfile\ntelnetlib\ntempfile\ntermios\ntest\ntest.support\ntextwrap\nthread\nthreading\ntime\ntimeit\ntkinter\ntkinter.scrolledtext\ntkinter.tix\ntkinter.ttk\ntoken\ntokenize\ntrace\ntraceback\ntracemalloc\nttk\ntty\nturtle\nturtledemo\ntypes\ntyping\nunicodedata\nunittest\nunittest.mock\nurllib\nurllib.error\nurllib.parse\nurllib.request\nurllib.response\nurllib.robotparser\nurllib2\nurlparse\nuser\nuu\nuuid\nvenv\nvideoreader\nwarnings\nwave\nweakref\nwebbrowser\nwhichdb\nwinreg\nwinsound\nwsgiref\nwsgiref.handlers\nwsgiref.headers\nwsgiref.simple_server\nwsgiref.util\nwsgiref.validate\nxdrlib\nxml\nxml.dom\nxml.dom.minidom\nxml.dom.pulldom\nxml.etree.ElementTree\nxml.parsers.expat\nxml.parsers.expat.errors\nxml.parsers.expat.model\nxml.sax\nxml.sax.handler\nxml.sax.saxutils\nxml.sax.xmlreader\nxmlrpc\nxmlrpc.client\nxmlrpc.server\nxmlrpclib\nzipapp\nzipfile\nzipimport\nzlib"
# so non-conda includes all python builtins and any names of python files in PYTHONPATH, we have to sort to insert from localmod alphabetically
nonconda=$(sort -u <(echo -e "$localmod$builtins"))
# now lets find out what modules are required
regexone='^import[ ]([a-zA-Z0-9, ]+)[ ]as'  # first try capturing modules between import and as
regextwo='^import[ ]([a-zA-Z0-9, ]+)'       # if there was no as, great, grab any and all modules following import
regexthree='^from[ ]([a-zA-Z0-9, ]+)import' # could also be that a module exists between from and import
# also library() and require() for R scripts, optional quotes around alphanumeric library name, temporarily unimplemented
regexfour='^library\("?([a-zA-Z0-9, ]+)"?\)'
regexfive='^require\("?([a-zA-Z0-9, ]+)"?\)'

for file in $pypathfiles
do
    while read line
    do
        if [[ $line =~ $regexone || $line =~ $regextwo || $line =~ $regexthree ]]
        then
            # if there was a regex match, append it to dependencies var
            # usefully, I can append to $dependencies even if it doesn't exist yet as undefined returns blank
            dependencies=$dependencies${BASH_REMATCH[1]//,/ }" " # //,/ replaces commas with space, append space between results
            # uncomment the following line to print out file:module pairs, useful for finding which file is importing a problem
            # echo $file ${BASH_REMATCH[1]}
        fi
    done < $file
done
# if exeversion is R, append R to all the dependencies
# sed "s/^/r-" | tr \n ' '

# <( echo -e "$nonconda" ) is first 'file'
# <( echo $dependencies | tr " " "\n" | sort -u) dependencies translated into lines and sorted for unique values is second 'file'
# comm -13 find lines in common, hide column 1 and column 3
#   returning a sorted list of just the modules that conda needs to install
condamods=$(comm -13 <( echo -e "$nonconda" ) <( echo $dependencies | tr " " "\n" | sort -u))
# create a unique string from python version and the modules to be installed in this environment
condahash=$(echo $pythonversion$condamods | openssl md5 | tr -cd [:alnum:] ) #alnum to throw out parens, spaces, things that would break the filename if openssl spits out extraneous characters like (stdin:)
echo $pythonversion
echo $condamods
# print a list of existing environments and see if one hash the same hash
# that means an environment was created for the same set of module dependencies
# using conda evn list is the more robust, sure proof way, but it takes like a whole second
# so if you know where the environments are being saved, ~/anaconda3/envs/x, you could just ls | grep
# and have your answer instantaneously
if [[ $(conda env list | grep $condahash) ]]
then
    echo "environment exists"
else
    echo "creating environment"
    conda create --yes --name $condahash --quiet $pythonversion $(echo $condamods)
fi
echo -e "environment ready, running $pythonscript\n"
source activate $condahash && python $pythonscript $pyargs