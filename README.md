# use [![Build Status](https://travis-ci.org/justincampbell/use.svg?branch=master)](https://travis-ci.org/justincampbell/use)

`use` is a utility for managing project- or client-specific profile configurations. For example, maybe you have some AWS credentials for yourself, and some for work, and maybe some more for that friend you helped with that one startup thing. `use` lets you manage these environment-level credentials and configurations sanely.

# Installation

    TODO

# Setup

Create a folder in `~/.use`, and then add folders inside for each client:

    ~
      .use/
        me/
        my_company/

Then in each folder, create a `.profile` file to be sourced when you `use` that profile.

    # ~/.use/me/.profile
    export FOG_DIRECTORY=myname

# Usage

    use name # name is the directory ~/.use/name

You can also `use` nothing, which essentially resets your current session:

    use # Same as above, but skip loading a named config.

# Examples

## AWS Configuration

```sh
# ~/.use/my_company/.profile
export AWS_ACCESS_KEY_ID=abc123
export AWS_SECRET_ACCESS_KEY=abc123
```
