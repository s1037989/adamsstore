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

sub not_processed {
  shift->pg->db->query(q[select id,timestamp::date,email,name,address,city,state,zip,json_array_elements(cart)->>'sku' sku,json_array_elements(cart)->>'product' product,json_array_elements(cart)->>'size' size from orders where store=? and stripe->>'livemode'='true' and stripe->>'paid'='true' and (processed=false or processed is null) order by id], shift);
}

sub paid {
  my ($self, $id) = @_;
  return $self->pg->db->query(q(select id from orders where id=? and stripe->>'paid'='true'), $id)->rows;
}

sub process {
  shift->pg->db->query(q[update orders set processed=true where store=? and stripe->>'livemode'='true' and stripe->>'paid'='true' and (processed=false or processed is null)], shift);
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
