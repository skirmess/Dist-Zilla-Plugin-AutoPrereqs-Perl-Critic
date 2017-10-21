# NAME

Dist::Zilla::Plugin::AutoPrereqs::Perl::Critic - automatically extract Perl::Critic policy prereqs

# VERSION

Version 0.005

# SYNOPSIS

    # in dist.ini:
    [AutoPrereqs::Perl::Critic]
    critic_config        = .perlcriticrc  ; defaults to not specify a profile
    phase                = develop        ; default
    type                 = requires       ; default
    remove_core_policies = 1              ; default

# DESCRIPTION

This plugin will add [Perl::Critic](https://metacpan.org/pod/Perl::Critic) and all policies used by it,
in the installed version, as distribution prerequisites.

## critic\_config

By default no policy is specified which lets [Perl::Critic](https://metacpan.org/pod/Perl::Critic)
find the config itself. This defaults to `.perlcriticrc` in the current
directory.

## phase

By default, the dependencies are added to the **develop** **phase**. This can be
changed to every valid phase.

## remove\_core\_policies

By default, policies that are included in the latest
[Perl::Critic](https://metacpan.org/pod/Perl::Critic) distribution are not added as dependency. This
can be changed by setting **remove\_core\_policies** to **0**.

Note: [Perl::Critic](https://metacpan.org/pod/Perl::Critic) itself is always added as dependency
which will come with the core policies.

Note: This feature needs HTTP access to **cpanmetadb.plackperl.org**. Please
disable this feature if you're system cannot access that server.

Note: To reduce network traffic and remove the delay caused by the network
access the cache file `.perlcritic_package.yml` is generated. You can either
add this file to your `.gitignore` file or add it to Git. It will be updated
as soon as the system runs a newer version of [Perl::Critic](https://metacpan.org/pod/Perl::Critic)
then the one that is mentioned in the cache file.

## type

By default, the dependencies are added as **type** **requires**. This can be changed
to every valid phase.

# SUPPORT

## Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at [https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic/issues](https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic/issues).
You will be notified automatically of any progress on your issue.

## Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

[https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic](https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic)

    git clone https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic.git

# AUTHOR

Sven Kirmess <sven.kirmess@kzone.ch>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2017 by Sven Kirmess.

This is free software, licensed under:

    The (two-clause) FreeBSD License

# SEE ALSO

[Dist::Zilla::Plugin::AutoPrereqs](https://metacpan.org/pod/Dist::Zilla::Plugin::AutoPrereqs),
[Perl::Critic](https://metacpan.org/pod/Perl::Critic),
[Test::Perl::Critic](https://metacpan.org/pod/Test::Perl::Critic)
