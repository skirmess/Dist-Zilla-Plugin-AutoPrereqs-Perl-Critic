#!perl

use 5.006;
use strict;
use warnings;

# generated by Dist::Zilla::Plugin::Author::SKIRMESS::RepositoryBase 0.033

use Test::More;

use lib qw(lib);

my @modules = qw(
  Dist::Zilla::Plugin::AutoPrereqs::Perl::Critic
);

plan tests => scalar @modules;

for my $module (@modules) {
    require_ok($module) || BAIL_OUT();
}
