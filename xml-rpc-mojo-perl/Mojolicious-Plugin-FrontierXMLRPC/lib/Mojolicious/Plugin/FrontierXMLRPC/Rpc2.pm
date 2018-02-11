# XMLRPC controller
package Mojolicious::Plugin::FrontierXMLRPC::Rpc2;
use Mojo::Base 'Mojolicious::Controller';

use Frontier::RPC2;
use Data::Dumper;

sub proxy_xmlrpc {

    my $self = shift;

    my $plugin = $self->stash->{frontier_xmlrpc_plugin};
	if ( ! defined $plugin ) {
		return;
	}

    my $methods = $plugin->{'method'};
    my $server  = $plugin->{'rpc2'};
    my $cb  = $plugin->{'cb'};
	if ( ! defined $server or ! defined $methods ) {
		return;
	}

    my $body = $self->req->body;

    #translate from request(XML) to response
    my	$response = $server->serve($body, $methods);

    #modify HTTP response
    $self->render(text=>$response, format=>"xml");

	# callback 
	if ( defined $cb ) {
		&$cb($body, $response);
	}

}

1;
