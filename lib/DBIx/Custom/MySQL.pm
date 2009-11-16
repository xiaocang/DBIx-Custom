package DBIx::Custom::MySQL;
use base 'DBIx::Custom::Basic';

use warnings;
use strict;
use Carp 'croak';

my $class = __PACKAGE__;

$class->add_format(
    datetime => $class->formats->{SQL99_datetime},
    date     => $class->formats->{SQL99_date},
    time     => $class->formats->{SQL99_time},
);


sub connect {
    my $self = shift;
    
    if (!$self->data_source && (my $database = $self->database)) {
        $self->data_source("dbi:mysql:dbname=$database");
    }
    
    return $self->SUPER::connect;
}

sub last_insert_id {
    my $self = shift;
    
    croak "Not yet connected" unless $self->connected;
    
    my $last_insert_id = $self->dbh->{mysql_insertid};
    
    return $last_insert_id;
}

=head1 NAME

DBIx::Custom::MySQL - DBIx::Custom MySQL implementation

=head1 Synopsys

    # New
    my $dbi = DBIx::Custom::MySQL->new(user => 'taro', $password => 'kliej&@K',
                                      database => 'sample_db');
    # Insert 
    $dbi->insert('books', {title => 'perl', author => 'taro'});
    
    # Update 
    # same as 'update books set (title = 'aaa', author = 'ken') where id = 5;
    $dbi->update('books', {title => 'aaa', author => 'ken'}, {id => 5});
    
    # Delete
    $dbi->delete('books', {author => 'taro'});
    
    # select * from books;
    $dbi->select('books');
    
    # select * from books where ahthor = 'taro'; 
    $dbi->select('books', {author => 'taro'});

=head1 See DBIx::Custom and DBI::Custom::Basic documentation

This class is L<DBIx::Custom::Basic> subclass,
and L<DBIx::Custom::Basic> is L<DBIx::Custom> subclass.

You can use all methods of L<DBIx::Custom::Basic> and <DBIx::Custom>
Please see L<DBIx::Custom::Basic> and <DBIx::Custom> documentation.

=head1 Object methods

=head2 connect

    This method override DBIx::Custom::connect
    
    If database attribute is set, automatically data source is created and connect

=head2 last_insert_id

    # Get last insert id
    $last_insert_id = $self->last_insert_id;

This is equal to MySQL function

    last_insert_id()
    
=head1 Author

Yuki Kimoto, C<< <kimoto.yuki at gmail.com> >>

Github L<http://github.com/yuki-kimoto>

I develope this module L<http://github.com/yuki-kimoto/DBIx-Custom>

=head1 Copyright & license

Copyright 2009 Yuki Kimoto, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


