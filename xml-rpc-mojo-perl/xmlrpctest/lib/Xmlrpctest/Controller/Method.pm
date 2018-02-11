package Xmlrpctest::Controller::Method;
use Mojo::Base 'Mojolicious::Controller';

use Mojo::Home;

use Frontier::RPC2;

my $log = Mojo::Log->new;

#外部メソッド名と内部関数の紐付け設定
my $methods = {
	'xml.rpctestplus' => \&xmlrpcplus,
	'xml.rpctestminus' => \&xmlrpcminus,
   	'xml.rpctestmixed' => \&xmlrpcmixed 
};

#受信
sub process {
	my $self = shift;
    #my $c = $self->ctx;

	$log->debug("in progress");

    my $server = Frontier::RPC2->new( 'encoding' => 'UTF-8' );
	if ( !defined $server ) {
		$self->render_text("frontier failed");
		return ;
	}

	my $body = $self->req->body;
	$log->debug("body: $body ");
	#request(XML)からresponseに変換
	my $response = $server->serve($body, $methods);
	$log->debug("res: $response ");

	#HTTPレスポンスに変換
	$self->render(text=>$response,format=>"xml");

}

#API
sub xmlrpcplus {
	(my $a , my $b) = @_;

	return $a + $b;
}

sub xmlrpcminus {
	(my $a , my $b) = @_;

	return $a - $b;
}

sub xmlrpcmixed {
	(my $a , my $b) = @_;
	my @c = (1,3,2);
	my $data = {a=>'b',b=>$a,c=>\@c};

	return $data;
}
