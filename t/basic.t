#!perl

# vim: ts=4 sts=4 sw=4 et: syntax=perl
#
# Copyright (c) 2017-2022 Sven Kirmess
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

use 5.006;
use strict;
use warnings;

use Test::DZil;
use Test::Fatal;
use Test::MockModule 0.14;
use Test::More 0.88;

use lib 't/lib';
use Local::HTTP::Tiny::Mock;

use Dist::Zilla::Plugin::AutoPrereqs::Perl::Critic;
use Perl::Critic;

my $perl_critic_version = Perl::Critic->VERSION();

my $http_tiny = Test::MockModule->new('HTTP::Tiny');

note('with working Intenet access (simulated)');

$http_tiny->redefine( 'get', Local::HTTP::Tiny::Mock::get_200() );

{
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZ1' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    'AutoPrereqs::Perl::Critic',
                ),
            },
        },
    );

    is( exception { $tzil->build; }, undef, 'Built dist successfully' );

    my $expected = {
        'develop' => {
            'requires' => {
                'Perl::Critic' => $perl_critic_version,
            },
        },
    };

    is_deeply( $tzil->distmeta->{prereqs}, $expected, 'without a single active policy only Perl::Critic is returned as dependency' );
}

{
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZ1' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    [
                        'AutoPrereqs::Perl::Critic',
                        {
                            phase => 'test',
                        },
                    ],
                ),
            },
        },
    );

    is( exception { $tzil->build; }, undef, 'Built dist successfully' );

    my $expected = {
        'test' => {
            'requires' => {
                'Perl::Critic' => $perl_critic_version,
            },
        },
    };

    is_deeply( $tzil->distmeta->{prereqs}, $expected, q{'phase' argument works} );
}

{
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZ1' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    [
                        'AutoPrereqs::Perl::Critic',

                        {
                            phase => 'test',
                            type  => 'recommends',
                        },
                    ],
                ),
            },
        },
    );

    is( exception { $tzil->build; }, undef, 'Built dist successfully' );

    my $expected = {
        'test' => {
            'recommends' => {
                'Perl::Critic' => $perl_critic_version,
            },
        },
    };

    is_deeply( $tzil->distmeta->{prereqs}, $expected, q{'phase' and 'recommends' arguments work} );
}

{
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZ2' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    [
                        'AutoPrereqs::Perl::Critic',

                        {
                            critic_config => 'perl_critic_config.txt',
                            phase         => 'test',
                            type          => 'recommends',
                        },
                    ],
                ),
            },
        },
    );

    is( exception { $tzil->build; }, undef, 'Built dist successfully' );

    my $expected = {
        'test' => {
            'recommends' => {
                'Perl::Critic' => $perl_critic_version,
            },
        },
    };

    is_deeply( $tzil->distmeta->{prereqs}, $expected, q{'critic_config', 'phase' and 'recommends' arguments work} );
}

{
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZ3' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    [
                        'AutoPrereqs::Perl::Critic',

                        {
                            critic_config => 'perl_critic_config.txt',
                            phase         => 'test',
                            type          => 'recommends',
                        },
                    ],
                ),
            },
        },
    );

    is( exception { $tzil->build; }, undef, 'Built dist successfully' );

    my $expected = {
        'test' => {
            'recommends' => {
                'Perl::Critic' => $perl_critic_version,
            },
        },
    };

    is_deeply( $tzil->distmeta->{prereqs}, $expected, 'core policy is not added to prereq' );
}

{
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZ3' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    [
                        'AutoPrereqs::Perl::Critic',

                        {
                            critic_config        => 'perl_critic_config.txt',
                            phase                => 'test',
                            type                 => 'recommends',
                            remove_core_policies => 0,
                        },
                    ],
                ),
            },
        },
    );

    is( exception { $tzil->build; }, undef, 'Built dist successfully' );

    my $expected = {
        'test' => {
            'recommends' => {
                'Perl::Critic'                                                    => $perl_critic_version,
                'Perl::Critic::Policy::Modules::RequireNoMatchVarsWithUseEnglish' => $perl_critic_version,
            },
        },
    };

    is_deeply( $tzil->distmeta->{prereqs}, $expected, q{'remove_core_policies' argument works} );
}

note('without working Intenet access (simulated)');

$http_tiny->redefine( 'get', Local::HTTP::Tiny::Mock::get_404() );

{
    my $tzil = Builder->from_config(
        { dist_root => 'corpus/dist/DZ3' },
        {
            add_files => {
                'source/dist.ini' => simple_ini(
                    'GatherDir',
                    [
                        'AutoPrereqs::Perl::Critic',

                        {
                            critic_config => 'perl_critic_config.txt',
                            phase         => 'test',
                            type          => 'recommends',
                        },
                    ],
                ),
            },
        },
    );

    like( exception { $tzil->build; }, "/ \Q[AutoPrereqs::Perl::Critic] Unable to download latest package information for Perl::Critic: Not Found. Please ensure that your system can access 'http://cpanmetadb.plackperl.org/v1.0/package/Perl::Critic' or disable 'remove_core_policies' in your dist.ini\E /xsm", 'throws an exception if http://cpanmetadb.plackperl.org/v1.0/package/Perl::Critic cannot be downloaded' );
}

done_testing();
