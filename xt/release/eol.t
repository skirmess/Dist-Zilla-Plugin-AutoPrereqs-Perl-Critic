#!perl

use 5.006;
use strict;
use warnings;

# this test was generated with
# Dist::Zilla::Plugin::Author::SKIRMESS::Test::XT::Test::EOL 0.005

use Test::EOL;
all_perl_files_ok( { trailing_whitespace => 1 }, grep { -d } qw( bin lib t xt) );
