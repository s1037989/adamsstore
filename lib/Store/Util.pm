package Store::Util;

use Exporter 'import';
use Text::CSV;

our @EXPORT_OK = (qw(to_csv));

sub to_csv {
  my ($data, $options) = @_;
  #my $csv_options = $c->stash('reply_table.csv_options') || {};
  #$csv_options->{binary} = 1 unless exists $csv_options->{binary};
  my $csv = Text::CSV->new({sep_char => "\t", quote_char => '', %$options});
  my $string = '';
  for my $row (@$data) {
    $csv->combine(@$row) || die $csv->error_diag;
    $string .= $csv->string . "\n";
  }
  return $string;
}

1;
