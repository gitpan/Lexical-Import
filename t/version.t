use warnings;
use strict;

use Test::More tests => 6;

eval q{
	use Lexical::Import qw(t::Exp1-1.00 foo);
	die unless foo() eq "FOO";
};
is $@, "";

eval q{
	use Lexical::Import qw(t::Exp1-1.20 foo);
	die unless foo() eq "FOO";
};
like $@, qr/\At::Exp1 version 1\.20? required--this is only version 1\.10/;

eval q{
	use Lexical::Import qw(t::Exp1-v1.0.0 foo);
	die unless foo() eq "FOO";
};
is $@, "";

eval q{
	use Lexical::Import qw(t::Exp1-v1.900.0 foo);
	die unless foo() eq "FOO";
};
like $@, qr/\At::Exp1 version v1\.900\.0 required--this is only version /;

eval q{
	use Lexical::Import qw(t::Exp0-1.00 successor);
	die unless successor(5) == 6;
};
like $@, qr/\At::Exp0 does not define \$t::Exp0::VERSION--/;

eval q{
	use Lexical::Import qw(t::Exp0-0 successor);
	die unless successor(5) == 6;
};
like $@, qr/\At::Exp0 does not define \$t::Exp0::VERSION--/;

1;
