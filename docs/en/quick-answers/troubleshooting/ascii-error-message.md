---
layout: default
title: ascii codec can’t decode byte 0x97 in position 10
pagename: ascii-error-message
lang: en
---

# ascii codec can’t decode byte 0x97 in position 10: ordinal not in range

## Related error messages:
While cloning a configuration
- TankError: Could not create file system structure: ‘ascii’ codec can’t decode byte 0x97 in position 10: ordinal not in range(128)

While setting up a project configuration using another project
- " ‘ascii’ codec can’t decode byte 0x97 in position 10: ordinal not in range(128)"

## How to fix:
Typically we see this error when there is a Unicode/special character somewhere in the “config” folder. We recomment taking a look to see if you can spot the special character. 

## Example of what's causing this error: 
In this case, the error stemmed from Windows adding a postfix `–` at end of file name. After removing all of those files, it started to work.

[See the full thread in the community](https://community.shotgridsoftware.com/t/ascii-problem/7688).

