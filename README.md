# mmapuccino

A simple wrapper around memmapped allocator that makes it simpler to exchange between RAM and disc allocation of numpy arrays.

## Installation

For now:
```
pip install git+https://github.com/MatteoLacki/mmapuccino.git
```

## Usage:

```python
memmaped_folder = Path("test.tofu")
shutil.rmtree(memmaped_folder)
memmaped_folder.mkdir()

md = MmapedArrayValuedDict(memmaped_folder)
some_output = foo(
    ...,
    _empty=md.empty,
    _zeros=md.zeros
)
```

where function `foo` does some non-trivial allocations with `_empty` and `_zeros`.
The operation above will create a folder `test.tofu` and fill it with all the usages of `_empty` and `_zeros`.

By default, we provide wrappers around RAM allocators `np.empty` and `np.zeros` for defaults to functions like `foo`:

```python
from mmapuccino import empty
from mmapuccino import zeros

def foo(..., _empty=empty, _zeros=zeros):
    ...
    xx = _empty(name="xx", shape=10**10, dtype="uint32")
    yy = _zeros(name="yy", shape=(10**10, 3), dtype="uint32")
    ...
```

The pattern is one folder per one function call.
The user is responsible for finding nice names for the folders.

To open an existing dataset

```python
mmappuccio = MmapedArrayValuedDict(existing_folder, mode="r")
```

WATCH OUT! 
Not passing `mode="r"` results in data being overwritten.
