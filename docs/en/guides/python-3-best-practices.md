---
layout: default
title: Python 3 Porting Best Practices
pagename: python-3-best-practices
lang: en
---

# Python 3 Porting Best Practices

## Why the move to Python 3?

There are a few compelling reasons to make the leap to Python 3.  Perhaps the most dramatic is the Python 2 end of life, which occurred on January 1, 2020[^1]. With the sunsetting of Python 2, all support for Python 2 ceases, meaning that even new security vulnerabilities found in Python 2 will not be addressed.

## Things to Consider (Prior to updating to Python 3)

When considering moving to Python 3, it's good to look at the requirements and application of your codebase to set expectations.  Obviously, any host applications your code runs in will help drive this decision.  Knowing whether you need to support many different Python interpreter versions and, if so, which ones, will be important information as you decide on the porting process that makes sense for you.

Next, take an audit of what libraries your code depends on.  If any of these libraries do not have Python 3 compatible versions, you'll need to find an alternative library, or fork the library to provide compatibility yourself. Both of these options could potentially be costly decisions and are important to consider early on.  Additionally, even libraries that do offer Python 3 compatible versions may not be drop-in replacements, and some libraries choose to fork for Python 3 support rather than maintain compatibility for both Python 2 and 3 as a single source.  We'll discuss this in more depth in the "Porting Options" section below.

Finally, it's worth noting that while it is possible to continue to support Python versions older than 2.5 and Python 3 simultaneously[^2], this will make your life much harder.  Since Python 2.5 is very old and not used in modern DCC versions, this guide will work under the assumption that Python 2.5 and earlier will not be targeted.  If you do need to support older versions of Python, a branching approach as described in the "Porting Options" section below may be your best option.

## What's Different in Python 3

Python 3 comes with some slight syntax changes, changes to builtin functions, new features, and small behavior changes.  There are [many](https://docs.python.org/3.0/whatsnew/3.0.html#overview-of-syntax-changes) [great](https://portingguide.readthedocs.io/en/latest/) [guides](https://sebastianraschka.com/Articles/2014_python_2_3_key_diff.html) that enumerate these specific changes and provide examples.  Rather than dive into specifics here, the goal of this guide will be to describe the porting process from a higher-level perspective, with a few small deep dives where compatibility may be more complicated than just matching syntax.

## Porting Options

For most of us, porting our code to only support Python 3 is not yet an option.  Many DCCs still require Python 2 support, and this is unlikely to change overnight.  This means that in the real world, it will be a necessity to be able to support both Python 2 and 3.

There are two major approaches to supporting Python 2 and 3 simultaneously.  We'll discuss both of them briefly:

### Branching

In this approach, a new Python 3 compatible branch of your code is maintained in parallel with the current (Python 2 compatible) branch.  This has the advantage of letting you write cleaner, easier to read Python 3 code, and allows you to fully leverage new features without needing branching logic to maintain Python 2 support.  It also means that when the time comes to drop support for Python 2, you'll be left with a cleaner, more modern starting point in your Python 3 branch.  The obvious downside here is that maintaining two branches can be unwieldy and mean more work, especially if the Python 3 and Python 2 code starts to diverge as the Python 3 branch can leverage new features that can significantly change how your code looks (e.g. [`asyncio`](https://docs.python.org/3.6/library/asyncio.html).)

### Cross-Compatibility

In this approach, a single branch is maintained that uses the subset of syntax and builtins that are compatible with both Python 2 and 3.  This allows for a graceful transition from Python 2 to 3 without maintaining multiple branches of your code.  There are a few popular libraries designed to help with this approach, and it's a commonly-used solution to the problem of transition from Python 2 to 3.  In addition to the reduced complexity compared to maintaining multiple branches, this approach also means you don't need to change your code distribution mechanisms or worry about using the correct (Python 2 or 3) version of your code at import time.

The two most commonly used libraries for this approach are `future` and `six`.

#### `future`

The future module is probably the most popular choice for Python 2 + 3 compatibility.  It backports many Python 3 libraries to Python 2, and aims to allow you to move your codebase to a pure Python 3 syntax.  Because it backports modules and works by shadowing builtins, it is slightly more invasive than `six`.  Given the variety of DCCs and unknown client code in VFX environments, future may be too invasive and in an environment like this may pose a greater risk of causing problems down the road.  For this reason, we will focus on using `six` instead.

#### `six`

The `six` module does not attempt to backport Python 3 modules, or allow you to write pure Python 3 syntax, but instead unifies renamed modules and changed interfaces inside the `six.moves` namespace.  This allows you to update imports and use `six`'s helper functions to write code that is both Python 2 and 3 compatible.

## Testing and Linting

### Black

The porting process requires an examination of the entire python codebase, and introduces a fair amount of noise in the revision control history.  This makes it a good opportunity to take care of any other housekeeping that may have similar impacts.  We took this opportunity to apply [`black`](https://black.readthedocs.io/en/stable/) to our code.  This is not strictly necessary or directly related to Python 3 compatibility (unless your code is mixing tabs and spaces[^3]), but given the reasons identified above, we decided this was a good opportunity to modernize our code formatting.

### Tests

Test coverage was incredibly valuable during the porting process since it allowed us to quickly find problems that still needed to be addressed, and verify that large sections of code were working as expected without as much manual intervention.  In many cases, we found it worthwhile to increase test coverage as part of the porting process to ensure that Python 2/3 specific cases (e.g. unicode handling) were being addressed correctly.  This being said, we recognize that in many cases the realities of production mean that test coverage is sparse, and that adding tests to code that has little or no coverage may be too time consuming to be worthwhile as part of a project like adding Python 3 compatibility.  For those in this situation, there may still be some value in using coverage measurement tools and some more basic testing code during the porting process, as these tools can provide fast feedback on what code has been covered and what may still need attention.

### Porting Procedure

Automated Porting using `modernize`

[`python-modernize`](https://python-modernize.readthedocs.io/en/latest/) is a tool that can be very useful for automatically generating Python 3 compatible code.  `modernize` usually produces runnable code with minimal human intervention, and because of this can be a great tool to get most of the way to Python 3 compatibility very quickly.  Of course, as an automated tool it does come with the drawbacks one would expect.  It frequently produces less readable and less efficient code (e.g. wrapping all iterables in a `list()` instantiation.)  In some cases, modernize can even introduce regressions that might be difficult to spot.  There are also some areas where you'll find `modernize` is not much help at all, like when dealing with bytes and text.  Since these decisions require a bit more understanding of context, you'll likely have to spend some time manually addressing the handling of strings in your code even if you do rely on `modernize` for the bulk of the compatibility work.

The alternative to using an automated tool like modernize, of course, is to go through code manually to fix incompatibilities.  This can be tedious, but in our experience generally produces nicer looking code.

For our process we went with a hybrid approach, using `modernize` with a select set of fixers, and doing some of the work manually.  We also broke the process into two stages; first doing a pure syntax compatibility and code formatting pass, and then doing a more manual Python 3 port.  Our process was as follows:

In a branch:

1. Run modernize with the `except`, `numliterals`, and `print` fixers
  ```python-modernize --no-diffs --nobackups -f except -f numliterals -f print -w .```
2. Make sure the resulting code is Python 3 syntax compliant by compiling it with Python 3.  The goal here is not to have your code work in Python 3, but to ensure that the basic formatting and automatable syntax fixes are in place.  If your code does not successfully compile after this step, you’ll need to find the source of the problem and either add additional fixers to the above step, or manually fix the incompatibilities.  Ensure that any changes you make manually at this stage are syntax only and will not change the behavior of the code in Python 2.
  ```python3 -m compileall .```
3. Run `black` on the resulting code

This branch should not change any behavior or functionality, and should not introduce regressions, so it is considered safe to merge at this point.  This helps keep the history easier to read, and means that the Python 3 compatibility branch and master will diverge less during the porting process, making for an easier merge once the work is done.

In a new branch, the actual Python 3 port can now begin:

1. Search for method names that may require some work to deal with list/view/iterator differences between Python 2 and 3.  In Python 3 `.values()`, `.items()` and `.keys()` return an iterator or view instead of a list, so in cases where these methods are called the code should be able to handle both iterator and list returns, otherwise the result will need to be cast to a list.  Similarly, the `filter()` method returned a list in Python 2, but now returns an iterator.
2. Change calls from `dict.iteritems()` and `dict.itervalues()` to `dict.items()` and `dict.values()` if the returned collection won't be too big.  In these cases, the resulting cleaner code at the cost of a slight performance hit in Python 2 is preferable.  In cases where the collection might contain thousands of items or more, use `six.iteritems` and `six.itervalues` instead.  If `dict.iterkeys()` was used, simply replace the code with something like `for key in dictionary:`, since this will iterate on keys in both Python versions.  Watch out that returning an iterator in Python 3 doesn't change the semantics of the code however. If a method used to return `dict.values()`, you'll need to wrap the call inside `list(dict.values())` to ensure the method always returns a list in all versions on Python.
3. Search for `str`, `basestring`, `unicode`, `open`, `pickle`, `encode`, `decode` since these will be areas of the code that likely require some attention to handling of bytes and strings.  We used the coercion helper methods provided by six (e.g. `ensure_string`) where needed.  See the sections on `bytes` and `pickle` below.
4. Unless generating a super long range, `xrange` can be changed to `range` for simplicity, otherwise `six.range` can be used.
5. After committing the manual changes from above, run a full `python-modernize` and go through the diff manually.  Many of the resulting changes will be unwanted, as discussed above, however this is a good way to catch potential problems that were overlooked in the manual porting process.
  ```python-modernize --no-diffs --nobackups -f default . -w && git diff HEAD```
6. Test the resulting code to find the remaining problems.  There are some incompatibilities that don’t have fixers ([this](https://portingguide.readthedocs.io/en/latest/core-obj-misc.html) is a good resource to look at to get an idea of what those changes entail), and it’s easy to overlook text/binary problems during the port process.

We chose to use this process because we believe it allowed us to maintain a standard of more readable, efficient code than would have been automatically generated by using `modernize` on its own.

## Gotchas

### Bytes Woes

Python 3 introduces a strict separation between binary and textual data.  This is a long-called-for addition that most see as an improvement, but for Python 2 + 3 compatible code it adds some headaches.  Since Python 2 does not enforce this separation, and Python 3 introduces new types to do so, code that deals with data and strings will likely need some attention.  For the most part this just means making sure that strings are encoded / decoded properly, for which the `six.ensure_binary` and `six.ensure_text` helper functions are invaluable.  See the examples below for common applications of these methods.  In some cases, however, this can be more complicated.  For an example of this, see the pickle section below.

```python
# base64.encodestring expects str in Python 2, and bytes in Python 3.
# By using six.ensure_binary() we can ensure that the we always
# pass it the correct type.
base64.encodestring(six.ensure_binary(some_string))

# In this example (from tk-multi-publish2), we get a list of files
# from a QDropEvent in Pyside.  The  filenames are unicode, however
# they're being passed to code that expects str.

# In Python 2, this had looked like:
if isinstance(category_type, unicode):
                    category_type = category_type.encode("utf-8")

# Using six, we can get the same behavior in Python 2, and ensure
# compatibility with Python 3 with:
category_type = six.ensure_str(category_type)
```

### The `pickle` Pickle

Pickle in Python 3 returns a `bytes` object from `dumps()`, where previously it had returned a `str`.  Additionally, the output of `pickle.dumps()` in Python 3 contains `\x00` bytes, which cannot be decoded. This is not a  problem if the data is being stored in a file, but if the pickled data is being stored in, for example, an environment variable, this can become problematic.  As a workaround, we found that by forcing pickle to use protocol 0, no 0 bytes were included, and the output is once again decodable.  This comes at the cost of the slightly less efficient and fewer-featured older protocol.

```python
# Dumping data to a pickle string:
DUMP_KWARGS = {"protocol": 0}
# Force pickle protocol 0, since this is a non-binary pickle protocol.
# See https://docs.python.org/2/library/pickle.html#pickle.HIGHEST_PROTOCOL
# Decode the result to a str before returning.
pickled_data = six.ensure_str(cPickle.dumps(data, **DUMP_KWARGS))
```

```python
# Loading data from a pickle string:
LOAD_KWARGS = {"encoding": "bytes"} if six.PY3 else {}
data = cPickle.loads(six.ensure_binary(data), **LOAD_KWARGS)
```
### Regex `\W` flag

In Python 3, regular expression metacharacters match unicode characters where in Python 2 they do not.  To reproduce the previous behavior, Python 3 introduces a new `re.ASCII` flag, which does not exist in Python 2.  To maintain consistent behavior across Python 2 and 3, we wrapped `re` functions to include this flag across the board in Python 3.

### Dictionary Order

Prior to Python 3.7, dictionary order was not guaranteed.  As of Python 3.7, insertion order is preserved in dictionaries[11].  In practice, on Python 2.7 dictionary order was random but deterministic (though this was not guaranteed), on some versions of Python (including some version of Python 3) dictionary order is non-deterministic[10].  While code prior to Python 3.7 should not rely on dictionary key order being deterministic, there were instances where this assumption was made in our unit tests.  These tests broke in Python 3.7, and needed to be updated to ensure that dictionary key order was not relied upon.

### `sys.platform`

In Python 3.3+ `sys.platform` on Linux returns `linux`, where previously it had returned "linux" appended with the kernel major version (i.e. `linux2`).  Of course when testing for Linux it is easy enough to check `sys.platform.startswith('linux')`.  We chose to centralize these tests and platform "normalization", and introduced functions `sgtk.util.is_windows()`, `sgtk.util.is_linux()`, `sgtk.util.is_macos()`, as well as a `sgsix.platform` constant that contains a normalized platform string that can be used for consistent mapping to platform names across python versions.

<!-- Footnotes -->
## Notes

[^1]:
     [https://www.python.org/doc/sunset-python-2/](https://www.python.org/doc/sunset-python-2/)

[^2]:
     [https://docs.python.org/3/howto/pyporting.html#drop-support-for-python-2-6-and-older](https://docs.python.org/3/howto/pyporting.html#drop-support-for-python-2-6-and-older)

[^3]:
     [https://portingguide.readthedocs.io/en/latest/syntax.html#tabs-and-spaces](https://portingguide.readthedocs.io/en/latest/syntax.html#tabs-and-spaces)