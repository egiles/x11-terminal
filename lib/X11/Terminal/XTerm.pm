package X11::Terminal::XTerm;

use Moose;
extends 'X11::Terminal';

our $VERSION = 0.1;
=head1 NAME

X11::Terminal::XTerm - Create customised xterm windows

=head1 SYNOPSIS

This module provides an object interface to launching xterm windows.

	use X11::Terminal::XTerm;

	my $xt1 = X11::Terminal::XTerm->new();
	my $xt2 = X11::Terminal::XTerm->new(host => "remoteserver");
	my $xt3 = X11::Terminal::XTerm->new(foreground => "green");

	for ( $xt1, xt2, $xt3 ) {
	  $_->launch();
	}


=head1 CONSTRUCTOR

=over 4

=item X11::Terminal::XTerm->new(%attr);

Create a new XTerm object, optionally with the specified attributes (see below).

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

=item foreground

Set the forground colour to be used in the XTerm window

=item background

Set the background colour to be used in the XTerm window

=item font

Set the font used in the XTerm window

=item profile

Set the X11 resource name used by the XTerm window

=item geometry

Set the preferred size and position of the XTerm window

=back


=head1 OTHER METHODS

=over 4

=item launch();

Launch an xterm window.

=item terminalArgs();

Return the arguments that will be passed to the xterm.  This will provide the customisations.  There be no reason to call this method directly.
=cut

sub terminalArgs {
  my ($self) = @_;

  my $args = "";
  if ( my $font = $self->font() ) {
    $args .= " -fn $font";
  }
  if ( my $name = $self->profile() ) {
    $args .= " -name $name";
  }
  if ( my $colour = $self->foreground() ) {
    $args .= " -fg $colour";
  }
  if ( my $geo = $self->geometry() ) {
    $args .= " -geometry $geo";
  }
  if ( my $colour = $self->background() ) {
    $args .= " -bg $colour";
  }
  return "$args";
}

=back

=head1 COPYRIGHT

Copyright 2010 Evan Giles.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

L<X11::Terminal>
=cut

1; # End of X11::Terminal::XTerm
