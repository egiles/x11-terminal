use strict;
use warnings;

use Test::More tests => 6;

#==============================================================================#

for my $module ( "X11::Terminal", "X11::Terminal::XTerm" ) {
  require_ok($module);
  my $term = $module->new();
  ok($term,"Created $module object");
  ok($term->isa("X11::Terminal"), "$module is an X11::Terminal");
}

#==============================================================================#
