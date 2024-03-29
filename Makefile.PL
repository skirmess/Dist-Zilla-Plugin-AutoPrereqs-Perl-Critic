use 5.006;
use strict;
use warnings;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
    ABSTRACT           => 'automatically extract Perl::Critic policy prereqs',
    AUTHOR             => 'Sven Kirmess <sven.kirmess@kzone.ch>',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    DISTNAME         => 'Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic',
    LICENSE          => 'open_source',
    MIN_PERL_VERSION => '5.006',
    NAME             => 'Dist::Zilla::Plugin::AutoPrereqs::Perl::Critic',
    PREREQ_PM        => {
        'CPAN::Meta::YAML'                => 0,
        'CPAN::Version'                   => 0,
        'Dist::Zilla::Role::PrereqSource' => 0,
        'HTTP::Tiny'                      => 0,
        Moose                             => 0,
        'Moose::Util::TypeConstraints'    => 0,
        'Path::Tiny'                      => 0,
        'Perl::Critic'                    => 0,
        'namespace::autoclean'            => 0,
        strict                            => 0,
        warnings                          => 0,
    },
    TEST_REQUIRES => {
        'Test::DZil'       => 0,
        'Test::Fatal'      => 0,
        'Test::MockModule' => '0.14',
        'Test::More'       => '0.88',
        lib                => 0,
    },
    VERSION => '0.006',
    test    => {
        TESTS => 't/*.t',
    },
);

my %FallbackPrereqs = (
    'CPAN::Meta::YAML'                => 0,
    'CPAN::Version'                   => 0,
    'Dist::Zilla::Role::PrereqSource' => 0,
    'HTTP::Tiny'                      => 0,
    Moose                             => 0,
    'Moose::Util::TypeConstraints'    => 0,
    'Path::Tiny'                      => 0,
    'Perl::Critic'                    => 0,
    'Test::DZil'                      => 0,
    'Test::Fatal'                     => 0,
    'Test::MockModule'                => '0.14',
    'Test::More'                      => '0.88',
    lib                               => 0,
    'namespace::autoclean'            => 0,
    strict                            => 0,
    warnings                          => 0,
);

if ( !eval { ExtUtils::MakeMaker->VERSION('6.63_03') } ) {
    delete $WriteMakefileArgs{TEST_REQUIRES};
    delete $WriteMakefileArgs{BUILD_REQUIRES};
    $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

if ( !eval { ExtUtils::MakeMaker->VERSION(6.52) } ) {
    delete $WriteMakefileArgs{CONFIGURE_REQUIRES};
}

WriteMakefile(%WriteMakefileArgs);

# vim: ts=4 sts=4 sw=4 et: syntax=perl
