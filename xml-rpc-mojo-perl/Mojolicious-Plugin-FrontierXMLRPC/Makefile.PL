use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::FrontierXMLRPC',
  VERSION_FROM => 'lib/Mojolicious/Plugin/FrontierXMLRPC.pm',
  AUTHOR       => 'tanino@soum.co.jp>',
  PREREQ_PM    => {'Mojolicious' => '7.64'},
  test         => {TESTS => 't/*.t'}
);
