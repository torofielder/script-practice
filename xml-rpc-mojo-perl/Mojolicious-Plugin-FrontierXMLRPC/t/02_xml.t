use Mojo::Base -strict;

use lib  "./lib";

use Test::More;
use Mojolicious::Lite;
use Test::Mojo;

use Data::Dumper;

my $methods = { 'xml.rpctestplus' => \&xmlrpcplus
                };

sub callback {
    (my $req,my $res)=@_;

    print STDOUT "This is callback\n";

    print Dumper($req);
    print Dumper($res);

}

my $conf = { methods=>$methods,cb=>\&callback };

plugin 'FrontierXMLRPC', $conf ;

my $t = Test::Mojo->new;
my $xmlreq = "<?xml version='1.0'?> <methodCall> <methodName>xml.rpctestplus</methodName> <params> <param> <value><int>1</int></value> </param> <param> <value><int>2</int></value> </param> </params> </methodCall>";

#1 and 2 * 2 is 6
# '<?xml version="1.0" encoding="UTF-8"?><methodResponse><params><param><value><i4>6</i4></value></param></params></methodResponse>';

$t->post_ok('/RPC2'=>$xmlreq)->status_is(200)->content_like(qr/methodResponse/);

#API
sub xmlrpcplus {
    (my $a , my $b) = @_;

    return ($a + $b) * 2;
}

done_testing();
