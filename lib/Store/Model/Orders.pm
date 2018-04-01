package Store::Model::Orders;
use Mojo::Base -base;

has 'pg';

sub add {
  my ($self, $cart) = @_;
  warn Data::Dumper::Dumper(_lc_keys($cart));
  return $self->pg->db->insert('orders', _lc_keys($cart), {returning => 'id'})->hash->{id};
}

sub all { shift->pg->db->select('orders', {store => shift})->hashes->to_array }

sub find {
  my ($self, $id) = @_;
  return $self->pg->db->select('orders', undef, {id => $id})->hash;
}

sub paid {
  my ($self, $id) = @_;
  return $self->pg->db->query(q(select id from orders where id=? and stripe->>'paid'='true'), $id)->rows;
}

sub remove {
  my ($self, $id) = @_;
  $self->pg->db->delete('orders', {id => $id});
}

sub save {
  my ($self, $id, $cart) = @_;
  $self->pg->db->update('orders', _lc_keys($cart), {id => $id});
}

sub _lc_keys {
  my $hash = shift;
  return { map {lc($_) => $hash->{$_}} keys %$hash };
}

1;
