package Mojolicious::Plugin::FrontierXMLRPC;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

use Frontier::RPC2;

my $log = Mojo::Log->new;

sub register {
	my ($self, $app, $conf) = @_;
    #$log->info("FrontierXMLRPC\n");

	# XMLRPC
    my $server = Frontier::RPC2->new( 'encoding' => 'UTF-8' );
    if ( !defined $server ) {
        return ;
    }
 
    # parameter settings
    $self->{'method'} = $conf->{methods};
    $self->{'cb'} = $conf->{cb};
    $self->{'rpc2'} = $server;
 
    my $r = $app->routes;
 
    # prepare "/RPC2"
    $r->post("/RPC2")->to(namespace => 'Mojolicious::Plugin::FrontierXMLRPC::Rpc2',
        action=>'proxy_xmlrpc',
        frontier_xmlrpc_plugin => $self,
    );
	
	return;
 
}

1;
__END__

=encoding utf8

=head1 NAME

Mojolicious::Plugin::FrontierXMLRPC - Mojolicious Plugin

=head1 SYNOPSIS

  # Mojolicious
  $self->plugin('FrontierXMLRPC');

  # Mojolicious::Lite
  plugin 'FrontierXMLRPC';

=head1 DESCRIPTION

L<Mojolicious::Plugin::FrontierXMLRPC> is a L<Mojolicious> plugin.

=head1 METHODS

L<Mojolicious::Plugin::FrontierXMLRPC> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut
