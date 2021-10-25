
`resticbackup` is a bash shell script for [Restic](https://restic.net/).
It runs hooks before and after whatever restic commands you've configured.

### Install

The GitHub repository has a PKGBUILD for Arch Linux and a Makefile for other distros.

### Usage

Edit the config file, which is usually at `/etc/resticbackup.d/config`
or `/usr/local/etc/resticbackup.d/config`.
You'll probably want to set up a password and repository for restic using the settings near the top of the file.

`resticbackup` can be configured to run any restic command by using config settings starting with `RESTICBACKUP_`.
There are two examples of this in the default config:

    RESTICBACKUP_BACKUP="backup -v --exclude-file=/etc/resticbackup.d/exclude /"
    RESTICBACKUP_PRUNE="forget --prune --keep-hourly 12 --keep-daily 7 --keep-weekly 4 --keep-monthly 3"

With these settings in place, `resticbackup backup` will run
`restic backup -v --exclude-file=/etc/resticbackup.d/exclude /`
and `resticbackup prune` will run
`restic forget --prune --keep-hourly 12 --keep-daily 7 --keep-weekly 4 --keep-monthly 3` .

You can configure resticbackup to run any restic command in this way.
E.g. if you were to add the following setting,
`resticbackup snap` would run `restic snapshots`

    RESTICBACKUP_SNAP=snapshots

In addition, invoking resticbackup through an appropriately named symlink
will run the corresponding restic command.
For example, the following symlinks are equivalent to `resticbackup backup`
and `resticbackup prune`, respectively.

    lrwxrwxrwx 1 root root 19 Oct 21 20:43 /etc/cron.daily/restic_backup -> /usr/bin/resticbackup
    lrwxrwxrwx 1 root root 19 Oct 21 20:44 /etc/cron.weekly/resticbackup_prune -> /usr/bin/resticbackup

You can configure rheostoic to log to a file or syslog with the `LOG_FILE` setting.

In the same folder as the config file, there is a `hooks` directory where you can place executable hooks to run before or after the restic command.
`resticbackup` will run `*.pre` hooks before the configured restic command,
and `*.post` hooks afterward.
Pre hooks are passed two arguments: the status code of the last pre hook that failed
(or `0` if no hooks failed),
and the action about to be performed (e.g. for `resticbackup backup`, the action is `backup`).
If any pre hook fails, resticbackup will exit without running the restic command.
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

