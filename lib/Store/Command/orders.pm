package Store::Command::orders;
use Mojo::Base 'Mojolicious::Commands';

has description => 'Inspect orders';
has hint        => <<EOF;

See 'APPLICATION orders help QUERY' for more information on a specific
order query.
EOF
has message    => sub { shift->extract_usage . "\nOrder queries:\n" };
has namespaces => sub { ['Store::Command::orders'] };

sub help { shift->run(@_) }

1;

=encoding utf8

=head1 NAME

Store::Command::orders - Order query command

=head1 SYNOPSIS

  Usage: APPLICATION orders QUERY [OPTIONS]

    mojo orders new
    mojo orders process

=head1 DESCRIPTION

L<Store::Command::orders> lists available order queries.

=head1 ATTRIBUTES

L<Store::Command::orders> inherits all attributes from
L<Mojolicious::Commands> and implements the following new ones.

=head2 description

  my $description = $orders->description;
  $orders         = $orders->description('Foo');

Short description of this command, used for the command list.

=head2 hint

  my $hint = $orders->hint;
  $orders  = $orders->hint('Foo');

Short hint shown after listing available order query commands.

=head2 message

  my $msg = $orders->message;
  $orders = $orders->message('Bar');

Short usage message shown before listing available order query commands.

=head2 namespaces

  my $namespaces = $orders->namespaces;
  $orders        = $orders->namespaces(['MyApp::Command::orders']);

Namespaces to search for available order query commands, defaults to
L<Store::Command::orders>.

=head1 METHODS

L<Store::Command::orders> inherits all methods from
L<Mojolicious::Commands> and implements the following new ones.

=head2 help

  $orders->help('app');

Print usage information for order query command.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut