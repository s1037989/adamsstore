package Store::Command::orders::process;
use Mojo::Base 'Mojolicious::Command';

use Store::Util 'to_csv';

has description => 'Process new orders';
has usage => sub { shift->extract_usage };

sub run {
  my ($self, $class) = @_;
  say to_csv($self->app->orders->not_processed->arrays);
  $self->app->orders->process;
}

1;

=encoding utf8

=head1 NAME

Store::Command::orders::process - Process new orders command

=head1 SYNOPSIS

  Usage: APPLICATION orders process [OPTIONS]

    mojo orders process

  Options:
    -h, --help   Show this summary of available options

=head1 DESCRIPTION

L<Store::Command::orders::process> marks all L<Store::Command::orders::new>
orders as processed; this would be the appropriate time to copy and paste
the listed orders into the working Spreadsheet system.

=head1 ATTRIBUTES

L<Store::Command::orders::process> inherits all attributes from
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

L<Store::Command::orders::process> inherits all methods from
L<Mojolicious::Command> and implements the following new ones.

=head2 run

  $app->run(@ARGV);

Run this command.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicious.org>.

=cut
