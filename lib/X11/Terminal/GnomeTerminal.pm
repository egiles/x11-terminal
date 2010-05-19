package X11::Terminal::GnomeTerminal;

use Moose;
extends 'X11::Terminal';

our $VERSION = 0.1;
=head1 NAME

X11::Terminal::GnomeTerminal - Create customised gnome-terminal windows

=head1 SYNOPSIS

This module provides an object interface to launching gnome-terminal windows.

	use X11::Terminal::GnomeTerminal;

	my $xt1 = X11::Terminal::GnomeTerminal->new();
	my $xt2 = X11::Terminal::GnomeTerminal->new(host => "remoteserver");
	my $xt3 = X11::Terminal::GnomeTerminal->new(profile => "special");

	for ( $xt1, xt2, $xt3 ) {
	  $_->launch();
	}


=head1 CONSTRUCTOR

=over 4

=item X11::Terminal::GnomeTerminal->new(%attr);

Create a new GnomeTerminal object, optionally with the specified attributes (see below).

=back


=head1 ATTRIBUTES

The attributes may be set by passing values to the constructur, or by calling the accessor methods.

=over 4
 
=item host

Specifies the remote host to log in to (using ssh)

=item agentforward

If the host has been specified, and agentforward is true, the login to that host will use SSH Agent Forarding.

=item xforward

If the host has been specified, and xforward is true, the login to that host will use SSH X Forarding.

=item profile

Set the X11 resource name used by the GnomeTerminal window

=item geometry

Set the preferred size and position of the GnomeTerminal window

=back


=head1 OTHER METHODS

=over 4

=item launch();

Launch an gnome-terminal window.

=item terminalArgs();

Return the arguments that will be passed to the gnome-terminal.  This will provide the customisations.  There be no reason to call this method directly.
=cut

sub terminalArgs {
  my ($self) = @_;

  my $args = "";
  if ( my $name = $self->profile() ) {
    $args .= " -name $name";
  }
  if ( my $geo = $self->geometry() ) {
    $args .= " -geometry $geo";
  }
  return "$args";
}

=item terminalName();

Returns the name of the executable program that we want to run
=cut

sub terminalName {
  return "gnome-terminal";
}

=back

=head1 COPYRIGHT

Copyright 2010 Evan Giles.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

L<X11::Terminal>
=cut

1; # End of X11::Terminal::GnomeTerminal
