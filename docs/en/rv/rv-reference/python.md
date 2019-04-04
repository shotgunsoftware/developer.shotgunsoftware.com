---
layout: default
title: Python
permalink: /rv/rv-reference/python/
lang: en
---

# Python

As of RV 3.12 you can use Python in RV in conjunction with Mu or in place of it. It’s even possible to call Python commands from Mu and vice versa. So in answer to the question: which language should I use to customize RV? The answer is whichever you like. At this point we recommend using Python.

There are some slight differences that need to be noted when translating code between the two languages:

In Python the modules names required by RV are the same as in Mu. As of this writing, these are commands, extra_commands, rvtypes, and rvui. However, the Python modules all live in the rv package. So while in Mu you can:

```
use commands
```

or

```
require commands
```

to make the commands visible in the current namespace. In Python you need to include the package name:

```
from rv.commands import *
```

or

```
import rv.commands
```

Pythonistas will know all the permutations of the above.

## Calling Mu From Python

It’s possible to call Mu code from Python, but in practice you will probably not need to do this unless you need to interface with existing packages written in Mu.

To call a Mu function from Python, you need to import the MuSymbol type from the pymu module. In this example, the play function is imported and called F on the Python side. F is then executed:

```
from pymu import MuSymbol
F = MuSymbol("commands.play")
F()
```

If the Mu function has arguments you supply them when calling. Return values are automatically converted between languages. The conversions are indicated in the table under Python Mu Type Conversions.

```
from pymu import MuSymbol
F = MuSymbol("commands.isPlaying")
G = MuSymbol("commands.setWindowTitle")
if F() == True:
    G("PLAYING")
```

Once a MuSymbol object has been created, the overhead to call it is minimal. All of the Mu commands module is imported on start up or reimplemented as native CPython in the Python rv.commands module so you will not need to create MuSymbol objects yourself; just import rv.commands and use the pre-existing ones.

When a Mu function parameter takes a class instance, a Python dictionary can be passed in. When a Mu function returns a class, a dictionary will be returned. Python dictionaries should have string keys which have the same names as the Mu class fields and corresponding values of the correct types.

For example, the Mu class Foo { int a; float b; } as instantiated as Foo(1, 2.0) will be converted to the Python dictionary {’a’ : 1, ’b’ : 2.0} and vice versa.

Existing Mu code can be leveraged with the rv.runtime.eval call to evaluate arbitrary Mu from Python. The second argument to the eval function is a list of Mu modules required for the code to execute and the result of the evaluation will be returned as a string. For example, here’s a function that could be a render method on a mode; it uses the Mu gltext module to draw the name of each visible source on the image:

```
def myRender (event) :
    event.reject()

    for s in rv.commands.renderedImages() :
        if (rv.commands.nodeType(rv.commands.nodeGroup(s["node"])) != "RVSourceGroup") :
            continue
        geom    = rv.commands.imageGeometry(s["name"])

        if (len(geom) == 0) :
            continue

        x       = geom[0][0]
        y       = (geom[0][1] + geom[2][1]) / 2.0         
        domain  = event.domain()
        w       = domain[0]
        h       = domain[1]

        drawCode = """
       {
           rvui.setupProjection (%d, %d);
           gltext.color (rvtypes.Color(1.0,1.0,1.0,1));
           gltext.size(14);
           gltext.writeAt(%f, %f, extra_commands.uiName("%s"));
       }
       """
       rv.runtime.eval(drawCode % (w, h, float(x), float(y), s["node"]), ["rvui", "rvtypes", "extra_commands"])
```

>**NOTE**: Python code in RV 4 can assume that default parameters in Mu functions will be supplied if needed. Prior to RV 4 all parameters had to be specified even when the parameter had a default value.

## Calling Python From Mu

There are two ways to call Python from Mu code: a Python function being used as a call back function from Mu or via the python Mu module.

In order to use a Python callable object as a call back from Mu code simply pass the callable object to the Mu function. The call back function’s arguments will be converted according to the Mu to Python value conversion rules show in the figure under Python Mu Type Conversions. There are restrictions on which callable objects can be used; only callable objects which return values of None, Float, Int, String, Unicode, Bool, or have no return value are currently allowed. Callable objects which return unsupported values will cause a Mu exception to be thrown after the callable returns.

The Mu “python” module implements a small subset of the CPython API. You can see documentation for this module in the Mu Command API Browser under the Help menu. Here is an example of how you would call os.path.join from Python in Mu.

```
require python;

let pyModule = python.PyImport_Import ("os");

python.PyObject pyMethod = python.PyObject_GetAttr (pyModule, "path");
python.PyObject pyMethod2 = python.PyObject_GetAttr (pyMethod, "join");

string result = to_string(python.PyObject_CallObject (pyMethod2, ("root","directory","subdirectory","file")));

print("result: %s\n" % result); // Prints "result: root/directory/subdirectory/file"
```

If the method you want to call takes no arguments like os.getcwd, then you will want to call it in the following manner.

```
require python;

let pyModule = python.PyImport_Import ("os");

python.PyObject pyMethod = python.PyObject_GetAttr (pyModule, "getcwd");

string result = to_string(python.PyObject_CallObject (pyMethod, PyTuple_New(0)));

print("result: %s\n" % result); // Prints "result: /var/tmp"
```

If you are interested in retrieving an attribute alone then here is an example of how you would call sys.platform from Python in Mu.

```
require python;

let pyModule = python.PyImport_Import ("sys");

python.PyObject pyAttr = python.PyObject_GetAttr (pyModule, "platform");

string result = to_string(pyAttr);

print("result: %s\n" % result); // Prints "result: darwin"
```

## Python Mu Type Conversions

| | | | |
|-|-|-|-|
| **Python Type** | **Converts to Mu Type** | **Converts To Python Type** | |
| Str or Unicode | string | Unicode string | Normal byte strings and unicode strings are both converted to Mu’s unicode string. Mu strings always convert to unicode Python strings. |
| Int | int, short, or byte | Int | |
| Long | int64 | Long | |
| Float | float or half or double | Float | Mu double values may lose precision. Python float values may lose precision if passed to a Mu function that takes a half. |
| Bool | bool | Bool | |
| (Float, Float) | vector float[2] | (Float, Float) | Vectors are represented as tuples in Python |
| (Float, Float, Float) | vector float[3] | (Float, Float, Float) | |
| (Float, Float, Float, Float) | vector float[4] | (Float, Float, Float, Float) | |
| Event | Event | Event | |
| MuSymbol | runtime.symbol | MuSymbol | |
| Tuple | tuple | Tuple | Tuple elements each convert independently. NOTE: two to four element Float tuples will convert to vector float[N] in Mu. Currently there is no way to force conversion of these Float-only tuples to Mu float tuples. |
| List | type[] or type[N] | List | Arrays (Lists) convert back and forth |
| Dictionary | Class | Dictionary | Class labels become dictionary keys |
| Callable Object | Function Object | Not Applicable | Callable objects may be passed to Mu functions where a Mu function type is expected. This allows Python functions to be used as Mu call back functions. |

<center>*Mu-Python Value Conversion*</center>

## PyQt versus PySide

RV 6 uses Qt 4.8. This version of Qt is supported by both the PySide and PyQt modules. However, from RV 6.x.4 onwards, RV ships with PySide for all platforms (OSX, Linux, Windows).

Below is a simple pyside example using RV’s py-interp.

```
#!/Applications/RV64.app/Contents/MacOS/py-interp

# Import PySide classes
import sys
from PySide.QtCore import *
from PySide.QtGui import *

# Create a Qt application.
# IMPORTANT: RV's py-interp contains an instance of QApplication;
# so always check if an instance already exists.
app = QApplication.instance()
if app == None:     
	app = QApplication(sys.argv)

# Display the file path of the app.
print app.applicationFilePath()

# Create a Label and show it.
label = QLabel("Using RV's PySide")
label.show()

# Enter Qt application main loop.
app.exec_()

sys.exit()
```

To access RV’s essential session window Qt QWidgets, i.e. the main window, the GL view, top tool bar and bottom tool bar, import the python module &#8216;rv.qtutils’.

```
import rv.qtutils

# Gets the current RV session windows as a PySide QMainWindow.
rvSessionWindow = rv.qtutils.sessionWindow()

# Gets the current RV session GL view as a PySide QGLWidget.
rvSessionGLView = rv.qtutils.sessionGLView()

# Gets the current RV session top tool bar as a PySide QToolBar.
rvSessionTopToolBar = rv.qtutils.sessionTopToolBar()

# Gets the current RV session bottom tool bar as a PySide QToolBar.
rvSessionBottomToolBar = rv.qtutils.sessionBottomToolBar()
```

## Shotgun Toolkit in RV

As of RV version 7.0, the standard Shotgun integration (known as “SG Review”) is supplied by Shotgun Toolkit code that is distributed with RV. In future releases, this will allow Toolkit apps to be versioned independently from RV and for the RV Toolkit engine to host user-developed apps.

Some details about the Shotgun Toolkit usage in RV:

* All the code comprising SG Review in RV is written in Python and is distributed with RV.
    * The **sgtk** RV Package supplies the “bootstrap” mode that launches the RV Toolkit engine when necessary. That code is distributed in **plugins/Python/sgtk_**.
    * The Toolkit RV Engine itself (**tk-rv**) and all distributed apps and frameworks can be found here: **src/python/sgtk/***.
* In addition to the RV engine, three Toolkit apps are distributed with RV:
    * The SG Review app (**tk-rv-sgreview**), which drives the core SG Review workflows in RV.
    * The Import Cut app (**tk-multi-importcut**), which can be launched from the SG Review menu to import an EDL to Shotgun.
    * A general purpose Python console (**tk-multi-pythonconsole**), which can be launched from the Tools menu after Toolkit has been initialized.
* A complete install of Shotgun Toolkit is not required to run RV 7 or the Toolkit components distributed with it. All the required code is installed with RV.
* As noted above, in future releases we hope to allow the Toolkit apps to be independently versioned and to allow the RV Engine to host user-created apps, but the initial RV 7 release is fairly “baked” and although all the relevant source code is supplied, we’d recommend that developers contact us first before making extensive changes (so that we can help make sure that future updates do not generate too much hassle).
* Since the “SGTK” RV Package is loaded by default, the “SG Review” menu will appear as soon as you authenticate RV with Shotgun. If you do not wish to use any SG Review features, you can uninstall the package or set the env var RV_SHOTGUN_NO_SG_REVIEW_MENU.
