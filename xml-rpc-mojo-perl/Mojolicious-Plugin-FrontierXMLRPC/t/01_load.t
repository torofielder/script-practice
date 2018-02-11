use Mojo::Base -strict;

use lib  "./lib";

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

use_ok('Mojolicious::Plugin::FrontierXMLRPC');

done_testing();

