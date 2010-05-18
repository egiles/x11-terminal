require 5.6.0;

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'          => 'X11::Terminal',
    'ABSTRACT'      => 'A programtic interface to launching X terminal windows',
    'AUTHOR'        => 'Evan Giles <egiles@cpan.org>',
    'LICENSE'       => 'perl',
    'PREREQ_PM'     => { 'Moose' => '0.54', },
    'VERSION_FROM'  => 'lib/X11/Terminal.pm',
    'dist'          => { COMPRESS=>'gzip', SUFFIX=>'gz' },
);
