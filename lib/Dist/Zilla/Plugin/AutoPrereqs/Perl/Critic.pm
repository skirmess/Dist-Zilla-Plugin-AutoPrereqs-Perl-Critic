package Dist::Zilla::Plugin::AutoPrereqs::Perl::Critic;

use strict;
use warnings;

our $VERSION = '0.001';

use Moose;
with qw(
  Dist::Zilla::Role::PrereqSource
);

use Perl::Critic;
use Moose::Util::TypeConstraints 'enum';
use namespace::autoclean;

has critic_config => (
    is      => 'ro',
    isa     => 'Maybe[Str]',
    default => undef,
);

has phase => (
    is      => 'ro',
    isa     => enum( [qw(configure build test runtime develop)] ),
    default => 'develop',
);

has type => (
    is      => 'ro',
    isa     => enum( [qw(requires recommends suggests conflicts)] ),
    default => 'requires',
);

sub register_prereqs {
    my ($self) = @_;

    my $type          = $self->type;
    my $phase         = $self->phase;
    my $critic_config = $self->critic_config;

    my %critic_args = ();
    if ( defined $critic_config ) {
        $critic_args{-profile} = $critic_config;
    }

    my $critic = Perl::Critic->new(%critic_args);

    for my $policy ( $critic->config()->policies() ) {
        my $policy_module  = ref $policy;
        my $policy_version = $policy->VERSION();

        $self->zilla->register_prereqs( { phase => $phase, type => $type }, $policy_module => $policy_version );
    }

    $self->zilla->register_prereqs( { phase => $phase, type => $type }, 'Perl::Critic' => Perl::Critic->VERSION() );

    return;
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::AutoPrereqs::Perl::Critic - automatically extract Perl::Critic policy prereqs

=head1 SYNOPSIS

  # in dist.ini:
  [AutoPrereqs::Perl::Critic]
  critic_config = .perlcriticrc  ; defaults to not specify a profile
  phase         = develop        ; default
  type          = requires       ; default

=head1 DESCRIPTION

This plugin will add L<Perl::Critic|Perl::Critic> and all policies used by it,
in the installed version, as distribution prerequisites.

=head2 critic_config

By default no policy is specified which lets L<Perl::Critic|Perl::Critic>
find the config itself. This defaults to F<.perlcriticrc> in the current
directory.

=head2 phase

By default, the dependencies are added to the B<develop> B<phase>. This can be
changed to every valid phase.

=head2 type

By default, the dependencies are added as B<type> B<requires>. This can be changed
to every valid phase.

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software. The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic>

  git clone https://github.com/skirmess/Dist-Zilla-Plugin-AutoPrereqs-Perl-Critic.git

=head1 AUTHOR

Sven Kirmess <sven.kirmess@kzone.ch>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2017 by Sven Kirmess.

This is free software, licensed under:

  The (two-clause) FreeBSD License

=head1 SEE ALSO

L<Dist::Zilla::Plugin::AutoPrereqs|Dist::Zilla::Plugin::AutoPrereqs>,
L<Perl::Critic|Perl::Critic>,
L<Test::Perl::Critic|Test::Perl::Critic>,

=cut

# vim: ts=4 sts=4 sw=4 et: syntax=perl
