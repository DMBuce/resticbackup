## Rhesootick

Restic + hooks

    R ------> R
        H --> H
    E ------> E
    S ------> S
        O --> O
        O --> O
    T ------> T
    I ------> I
    C ------> C
        K --> K

Rhesootick is a bash shell script for [Restic](https://restic.net/).
It runs hooks before and after whatever restic commands you've configured.

### Install

The GitHub repository has a PKGBUILD for Arch Linux and a Makefile for other distros.

### Usage

Edit the config file, which is usually at `/etc/rhesootick.d/config`
or `/usr/local/etc/rhesootick.d/config`.
You'll probably want to set up a password and repository for restic using the settings near the top of the file.

Rhesootick can be configured to run any restic command by using config settings starting with `RHESOOTICK_`.
There are two examples of this in the default config:

    RHESOOTICK_BACKUP="backup -v --exclude-file=/etc/rhesootick.d/exclude /"
    RHESOOTICK_PRUNE="forget --prune --keep-hourly 12 --keep-daily 7 --keep-weekly 4 --keep-monthly 3"

With these settings in place, `rhesootick backup` will run
`restic backup -v --exclude-file=/etc/rhesootick.d/exclude /`
and `rhesootick prune` will run
`restic forget --prune --keep-hourly 12 --keep-daily 7 --keep-weekly 4 --keep-monthly 3` .

You can configure rhesootick to run any restic command in this way.
E.g. if you were to add the following setting,
`rhesootick snap` would run `restic snapshots`

    RHESOOTICK_SNAP=snapshots

In addition, invoking rhesootick through an appropriately named symlink
will run the corresponding restic command.
For example, the following symlinks are equivalent to `rhesootick backup`
and `rhesootick prune`, respectively.

    lrwxrwxrwx 1 root root 19 Oct 21 20:43 /etc/cron.daily/restic_backup -> /usr/bin/rhesootick
    lrwxrwxrwx 1 root root 19 Oct 21 20:44 /etc/cron.weekly/rhesootick_prune -> /usr/bin/rhesootick

You can configure rheostoic to log to a file or syslog with the `LOG_FILE` setting.

In the same folder as the config file, there is a `hooks` directory where you can place executable hooks to run before or after the restic command.
Rhesootick will run `*.pre` hooks before the configured restic command,
and `*.post` hooks afterward.
Pre hooks are passed two arguments: the status code of the last pre hook that failed
(or `0` if no hooks failed),
and the action about to be performed (e.g. for `rhesootick backup`, the action is `backup`).
If any pre hook fails, rhesootick will exit without running the restic command.
Post hooks are also passed two arguments: the status code of the restic command that was run,
and the action that was performed.

Several example hooks are provided. Some of them have additional configuration settings in the config file.
To use a hook, remove its `.disabled` extension.

### Documentation

Project documentation can be found in these files:

* LICENSE - Terms and conditions
* README  - This document

The changelog can be viewed on GitHub at
https://github.com/DMBuce/music/commits/master .

