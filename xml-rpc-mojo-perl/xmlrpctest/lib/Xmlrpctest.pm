package Xmlrpctest;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Router
  my $r = $self->routes;

  $r->get('/RPC2')->to('method#process');
  $r->post('/RPC2')->to('method#process');
}

1;
