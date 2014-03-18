package Role::REST::Client::Response;

use Moo;
use MooX::HandlesVia;
use Types::Standard qw(Str Int CodeRef InstanceOf);

has 'code' => (
	isa => Int,
	is  => 'ro',
);
has 'response' => (
	isa => InstanceOf['HTTP::Response'],
	is  => 'ro',
);
has 'error' => (
	isa => Str,
	is  => 'ro',
	predicate => 'failed',
);
has 'data_callback' => (
	init_arg => 'data',
	isa => CodeRef,
	is  => 'ro',
	default => sub { sub { {} } },
	handles_via => 'Code',
	handles => { data => 'execute' },
);

1;

__END__

=head1 NAME

Role::REST::Client::Response - Response class for REST

=head1 SYNOPSIS

    my $res = Role::REST::Client::Response->new(
        code          => '200',
        response      => HTTP::Response->new(...),
        error         => 0,
        data_callback => sub { sub { ... } },
    );

=head1 ATTRIBUTES

=head2 code

HTTP status code of the request

=head2 response

L<HTTP::Response> object. Use this if you need more information than status and content.

=head2 error

The error description returned from the user agent when the HTTP status code is 500 or higher. More detail may be found 
by calling C<< $res->response->content >>.

=head2 failed

True if the request didn't succeed.

=head2 data

The deserialized data. Returns an empty hashref if the response was unsuccessful.

=head1 BUGS

Please report any bugs or feature requests to bug-role-rest-client at rt.cpan.org, or through the
web interface at http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Role-REST-Client.
