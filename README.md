# NAME

Dist::Zilla::Plugin::AutoPrereqs::Perl::Critic - automatically extract Perl::Critic policy prereqs

# VERSION

Version 0.006

# SYNOPSIS

    # in dist.ini:
    [AutoPrereqs::Perl::Critic]
    critic_config        = .perlcriticrc  ; defaults to not specify a profile
    phase                = develop        ; default
    type                 = requires       ; default
    remove_core_policies = 1              ; default

# DESCRIPTION

This plugin will add [Perl::Critic](https://metacpan.org/pod/Perl%3A%3ACritic) and all policies used by it,
in the installed version, as distribution prerequisites.

## critic\_config

By default no policy is specified which lets [Perl::Critic](https://metacpan.org/pod/Perl%3A%3ACritic)
find the config itself. This defaults to `.perlcriticrc` in the current
directory.

## phase

By default, the dependencies are added to the `develop` `phase`. This can be
changed to every valid phase.

## remove\_core\_policies

By default, policies that are included in the latest
[Perl::Critic](https://metacpan.org/pod/Perl%3A%3ACritic) distribution are not added as dependency. This
can be changed by setting `remove_core_policies` to `0`.

Note: [Perl::Critic](https://metacpan.org/pod/Perl%3A%3ACritic) itself is always added as dependency
which will come with the core policies.

Note: This feature needs HTTP access to `cpanmetadb.plackperl.org`. Please
disable this feature if you're system cannot access that server.

Note: To reduce network traffic and remove the delay caused by the network
access the cache file `.perlcritic_package.yml` is generated. You can either
add this file to your `.gitignore` file or add it to Git. It will be updated
as soon as the system runs a newer version of [Perl::Critic](https://metacpan.org/pod/Perl%3A%3ACritic)
then the one that is mentioned in the cache file.

## type

By default, the dependencies are added as `type` `requires`. This can be changed
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

# SEE ALSO

[Dist::Zilla::Plugin::AutoPrereqs](https://metacpan.org/pod/Dist%3A%3AZilla%3A%3APlugin%3A%3AAutoPrereqs),
[Perl::Critic](https://metacpan.org/pod/Perl%3A%3ACritic),
[Test::Perl::Critic](https://metacpan.org/pod/Test%3A%3APerl%3A%3ACritic)
