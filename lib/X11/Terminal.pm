package X11::Terminal;

use Moose;

our $VERSION = 0.1;
=head1 NAME

X11::Terminal - Create customised X11 termnal windows

=head1 SYNOPSIS

This module provides a baseclass for launching terminal windows on your desktop.
You would normally instantiate subclass rather than using this class directly.

For example:

	use X11::Terminal::XTerm;
	
	# Create an xterm window, logged in to a remote server
	my $term = X11::Terminal::XTerm->new(host => "remotehost");
	$term->launch();
=cut

=head1 ATTRIBUTES

Each of the following attributes provide an accessor method, but they can also be set in the constructor.

Note that there are a lot of appearance related attributes, many of which will have no effect - depending on the subclass involved.  For example, a Gnome-Terminal subclass can't set the font as Gnome-Terminals utilise a profile setting for that bahaviour.

=over 4

=item host 
=cut
has 'host' => (
  is => 'rw',
  isa => 'Str',
);

=item xforward 
=cut
has 'xforward' => (
  is => 'rw',
  isa => 'Bool',
);

=item agentforward 
=cut
has 'agentforward' => (
  is => 'rw',
  isa => 'Bool',
);

=item profile
=cut
has 'profile' => (
  is => 'rw',
  isa => 'Str',
);

=item geometry
=cut
has 'geometry' => (
  is => 'rw',
  isa => 'Str',
);

=item font
=cut
has 'font' => (
  is => 'rw',
  isa => 'Str',
);

=item foreground
=cut
has 'foreground' => (
  is => 'rw',
  isa => 'Str',
);

=item background
=cut
has 'background' => (
  is => 'rw',
  isa => 'Str',
);

=back

=head1 OTHER METHODS

=over 4

=item shellCommand();

Return the (probably remote) shell command that should be run from within 
the terminal window.  There should be no need to call this directly.
=cut

sub shellCommand {
  my ($self) = @_;

  if ( my $host = $self->host() ) {
    my $sshForward = $self->xforward() ? "-X" : "";
    my $agentForward = $self->agentforward() ? "-A" : "";
    return "ssh $sshForward $agentForward $host";
  }
  return "bash";
}

=item launch();

Launch an xterm window, using whatever attributes have been defined to customse it appearance and behaviour.
=cut

sub launch {
  my ($self,$debug) = @_;

  my $shell = $self->shellCommand();
  my $term = $self->terminalName();
  my $args = $self->terminalArgs();
  my $command = "$term $args -e '$shell'";

  if ( ! $debug ) {
    if ( fork() == 0 ) {
      exec($command);
    }
  }
  return $command;
}

=item terminalName();

Returns the name of the program that will be run to provide the terminal window
=cut

sub terminalName {
  my ($self) = @_;

  my ($className) = ref($self) =~ m/([\w|-]+)$/;
  return lc($className);
}

=back

=head1 COPYRIGHT

Copyright 2010 Evan Giles.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
=cut

1; # End of X11::Terminal
