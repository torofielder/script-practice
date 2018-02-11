package FxmlrpcTest;
use Mojo::Base 'Mojolicious';

#XMLRPC コールバック
sub callback {
    (my $req,my $res)=@_;

    print STDOUT "This is callback\n";

    print Dumper($req);
    print Dumper($res);

}

# This method will run once at server start
sub startup {
  my $self = shift;

  #外部メソッド名と内部関数の紐付け設定
  my $methods = { 'xml.rpctestplus' => \&xmlrpcplus
            , 'xml.rpctestminus' => \&xmlrpcminus
            , 'xml.rpctestmixed' => \&xmlrpcmixed
	};

  #プラグインへのパラメータ
  my $xconf = {
	methods=>$methods,
    callback=>\&callback,
  };

  $self->plugin('Mojolicious::Plugin::FrontierXMLRPC',$xconf);

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

1;
