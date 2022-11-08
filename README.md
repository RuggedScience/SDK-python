# Python SDK
This is a wrapper around the [Rugged Science SDK](https://github.com/ruggedscience/sdk). For more information about the available APIs see the [librsdio](https://github.com/ruggedscience/sdk/librsdio.md) and [librspoe](https://github.com/ruggedscience/sdk/librspoe.md) docs.

### Installing
The package can be installed either by [compiling the sources](#compiling) or installing via `python -m pip install rssdk`.  

### Dio Example
```python
from rssdk import RsDio, OutputMode

dio = RsDio()
dio.setXmlFile("ecs9000.xml")

dio.setOutputMode(1, OutputMode.ModeNpn)

dio.digitalRead(1, 1)
dio.digitalWrite(1, 11, True)

```

### PoE Example
```python
from rssdk import RsPoe, PoeState

poe = RsPoe()
poe.setXmlFile("ecs9000.xml")

poe.getPortState(3)
poe.setPortState(PoeState.StateDisabled)
```
