package Store::Command::orders::new;
use Mojo::Base 'Mojolicious::Command';

use Store::Util 'to_csv';

has description => 'View new orders';
has usage => sub { shift->extract_usage };

sub run {
  my ($self, $class) = @_;
  say to_csv($self->app->orders->not_processed->arrays);
}

1;

=encoding utf8

=head1 NAME

Store::Command::orders::new - View new orders command

=head1 SYNOPSIS

  Usage: APPLICATION orders new [OPTIONS]

    mojo orders new

  Options:
    -h, --help   Show this summary of available options

=head1 DESCRIPTION

L<Store::Command::orders::new> shows all new orders that are not yet
marked as process as done by the L<Store::Command::orders::process> command.

=head1 ATTRIBUTES

L<Store::Command::orders::new> inherits all attributes from
L<Mojolicious::Command> and implements the following new ones.

=head2 description

  my $description = $app->description;
  $app            = $app->description('Foo');

Short description of this command, used for the command list.

=head2 usage

  my $usage = $app->usage;
  $app      = $app->usage('Foo');

Usage information for this command, used for the help screen.

=head1 METHODS

L<Store::Command::orders::new> inherits all methods from
L<Mojolicious::Command> and implements the following new ones.

=head2 run

  $app->run(@ARGV);

Run this command.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut
