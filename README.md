# Python SDK
This is a wrapper around the [Rugged Science SDK](https://github.com/ruggedscience/sdk). For more information about the available APIs see the [librsdio](https://github.com/RuggedScience/SDK/blob/main/librsdio.md) and [librspoe](https://github.com/RuggedScience/SDK/blob/main/librspoe.md) docs.

## Installing
The package can be installed either by [compiling the sources](#compiling) or installing via `python -m pip install rssdk`.  

***NOTE:*** When installing via `pip`, if a prebuilt wheel is not available for your platform and Python version the SDK will have to be compiled. 
This requires a compiler to be installed such as MSVC or g++. If no compiler is found an error will be thrown during installation and the module will not be installed.  


## Dio Example
```python
from rssdk import RsDio, OutputMode

dio = RsDio()
if not dio.setXmlFile("ecs9000.xml"):
    print(dio.getLastError())
    exit(1)

dio.setOutputMode(1, OutputMode.ModeNpn)

dio.digitalRead(1, 1)
dio.digitalWrite(1, 11, True)

```

## PoE Example
```python
from rssdk import RsPoe, PoeState

poe = RsPoe()
if not poe.setXmlFile("ecs9000.xml"):
    print(dio.getLastError())
    exit(1)

poe.getPortState(3)
poe.setPortState(PoeState.StateDisabled)
```

# Compiling
A source distribution and a wheel can be built from sources. The following steps assume you already have git, a compiler, Python, and CMake installed in standard locations and in the users path.

1) Clone the repository using git and change directory into the newly created folder.
    ```console
    git clone https://github.com/ruggedscience/SDK-python
    cd SDK-python
    ```

2) The SDK sources are kept in a seperate repositry and are added as a submodule. By default git doesn't pull submodules.
    ```console
    git submodule init
    git submodule update
    ```

3) Now all of the sources should be available to be built. It's best practice to create a seperate build directory to isolate the build files from the source files.
    ```console
    mkdir build
    cd build
    ```

4) Next the cmake configuration files need to be created. If the environment changes, such as the when switching between Python virtual environments, this command needs to be rerun.
    ```console
    cmake ..
    ``` 

5) Lastly run the following command to build the source distribution and wheel for the current platform and Python version.
    ```console
    cmake --build .
    ```

This should result in two Python build artifacts in the build directory: `rssdk-*.tar.gz` and `rssdk-*.whl`.

The `.tar.gz` file is the source distribution. This can be installed on different platforms and Python versions using `python -m pip install rssdk-*.tar.gz` but will be compiled at the time of install.
This means the system it is being installed on will need to have a compiler available.

The `.whl` is platform and Python version specific and can only be installed in environments with the exact same configuration. It can be installed using `python -m pip install rssdk-*.whl`

