Message-ID: <4D0E84DB.6040105@online.nl>
Date: Sun, 19 Dec 2010 23:19:07 +0100
From: Rolf Fokkens <rolf.fokkens@online.nl>
MIME-Version: 1.0
References: <4D0E845B.60203@online.nl>
In-Reply-To: <4D0E845B.60203@online.nl>
Content-Type: multipart/alternative;
	boundary="------------070509050005030505010102"
Subject: Re: [Bridge] Why should static MAC address match one of the port
	MAC addresses.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multi-part message in MIME format.
--------------070509050005030505010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Forgot some specifics:

kernel is Fedora kernel-2.6.35.9-64.fc14.x86_64.

On 12/19/2010 11:16 PM, Rolf Fokkens wrote:
> Hi all,
>
> I'm having the problem Michiel describes as well. I have a bridge br2 
> containing 1 (but potentially more) tap interface for kvm. Windows 7 
> VM doesn't like the bridge mac address to change, so I try to make it 
> fixed.
>
> ifconfig br2 hw ether 02:00:00:00:01:02
>
> Interface br2 becomes instantly unreachable from the VM (via the tap 
> interface).
>
> So, Michiel's claim still seems to be true: the bridge mac address 
> should apparently be one of the bridge interfaces.
>
> I don't see the logic, this seems like a bug to me.
>
> Cheers,
>
> Rolf
>
> ------------------------------------------------------------------------
>
>     * /To/: Michel Lammertink <mlammertink@xxxxxxxxx
>       <mailto:mlammertink@DOMAIN.HIDDEN>>
>     * /Subject/: Re: Why should static MAC address match one of the
>       port MAC addresses.
>     * /From/: Stephen Hemminger <shemminger@xxxxxxxxxxxxxxxxxxxx
>       <mailto:shemminger@DOMAIN.HIDDEN>>
>     * /Date/: Tue, 12 Oct 2010 09:44:08 -0700
>     * /Cc/: bridge@xxxxxxxxxxxxxxxxxxxxxxxxxx
>       <mailto:bridge@DOMAIN.HIDDEN>
>     * /In-reply-to/: <4CB46549.2070901@xxxxxxxxx
>       <mailto:4CB46549.2070901@DOMAIN.HIDDEN>>
>     * /Organization/: Linux Foundation
>     * /References/: <4CB46549.2070901@xxxxxxxxx
>       <mailto:4CB46549.2070901@DOMAIN.HIDDEN>>
>
> ------------------------------------------------------------------------
> On Tue, 12 Oct 2010 15:40:25 +0200 Michel Lammertink<mlammertink@xxxxxxxxx>  wrote:
>
> >/  Hi all,/
> >/  /
> >/  I've read many messages on this mailing list with the question about/
> >/  setting a static MAC address on the bridge interface, but two questions/
> >/  remain:/
> >/  /
> >/   1. Why should the MAC address of the bridge match the address of one of/
> >/  its interfaces? Setting the MAC address to a different value does not/
> >/  generate an error, but the bridge is not working properly (Local data/
> >/  does not arrive)./
>
> No longer a requirement. It was just a good way to ensure a good
> address that was unique, and not being used by other systems.
>
> >/   2. Why does the bridge by default choose the "lowest" MAC address,/
> >/  instead of the MAC address of the first port added, as is proposed by/
> >/  the standard [1]?/
>
> It was a convenience in original design to choose a consistent value.
> Since ports can be added in any order, using the lowest seemed like
> a good idea for the original author. This has been maintained for
> backwards compatibility.
>
> >/  [1] IEEE802.1D, Par. 7.12.5./
> >/      Quote: "The Bridge Address may be the individual MAC Address of a/
> >/  Bridge Port, in which case, use of the address of the lowest numbered/
> >/  Bridge Port (Port 1) is recommended."/
> >/  /
> >/  Thanks in advance,/
> >/  /
> >/  Michel./


--------------070509050005030505010102
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Forgot some specifics:<br>
    <br>
    kernel is Fedora kernel-2.6.35.9-64.fc14.x86_64.<br>
    <br>
    On 12/19/2010 11:16 PM, Rolf Fokkens wrote:
    <blockquote cite="mid:4D0E845B.60203@online.nl" type="cite">
      <meta http-equiv="content-type" content="text/html;
        charset=ISO-8859-1">
      Hi all,<br>
      <br>
      I'm having the problem Michiel describes as well. I have a bridge
      br2 containing 1 (but potentially more) tap interface for kvm.
      Windows 7 VM doesn't like the bridge mac address to change, so I
      try to make it fixed.<br>
      <br>
      <tt>ifconfig br2 hw ether 02:00:00:00:01:02</tt><br>
      <br>
      Interface br2 becomes instantly unreachable from the VM (via the
      tap interface).<br>
      <br>
      So, Michiel's claim still seems to be true: the bridge mac address
      should apparently be one of the bridge interfaces.<br>
      <br>
      I don't see the logic, this seems like a bug to me.<br>
      <br>
      Cheers,<br>
      <br>
      Rolf<br>
      <br>
      <hr>
      <ul>
        <li><em>To</em>: Michel Lammertink &lt;<a moz-do-not-send="true"
            href="mailto:mlammertink@DOMAIN.HIDDEN">mlammertink@xxxxxxxxx</a>&gt;</li>
        <li><em>Subject</em>: Re: Why should static MAC address match
          one of the port MAC addresses.</li>
        <li><em>From</em>: Stephen Hemminger &lt;<a
            moz-do-not-send="true"
            href="mailto:shemminger@DOMAIN.HIDDEN">shemminger@xxxxxxxxxxxxxxxxxxxx</a>&gt;</li>
        <li><em>Date</em>: Tue, 12 Oct 2010 09:44:08 -0700</li>
        <li><em>Cc</em>: <a moz-do-not-send="true"
            href="mailto:bridge@DOMAIN.HIDDEN">bridge@xxxxxxxxxxxxxxxxxxxxxxxxxx</a></li>
        <li><em>In-reply-to</em>: &lt;<a moz-do-not-send="true"
            href="mailto:4CB46549.2070901@DOMAIN.HIDDEN">4CB46549.2070901@xxxxxxxxx</a>&gt;</li>
        <li><em>Organization</em>: Linux Foundation</li>
        <li><em>References</em>: &lt;<a moz-do-not-send="true"
            href="mailto:4CB46549.2070901@DOMAIN.HIDDEN">4CB46549.2070901@xxxxxxxxx</a>&gt;</li>
      </ul>
      <hr>
      <pre>On Tue, 12 Oct 2010 15:40:25 +0200 Michel Lammertink &lt;mlammertink@xxxxxxxxx&gt; wrote:

&gt;<i> Hi all,</i>
&gt;<i> </i>
&gt;<i> I've read many messages on this mailing list with the question about</i>
&gt;<i> setting a static MAC address on the bridge interface, but two questions</i>
&gt;<i> remain:</i>
&gt;<i> </i>
&gt;<i>  1. Why should the MAC address of the bridge match the address of one of</i>
&gt;<i> its interfaces? Setting the MAC address to a different value does not</i>
&gt;<i> generate an error, but the bridge is not working properly (Local data</i>
&gt;<i> does not arrive).</i>

No longer a requirement. It was just a good way to ensure a good
address that was unique, and not being used by other systems.

&gt;<i>  2. Why does the bridge by default choose the "lowest" MAC address,</i>
&gt;<i> instead of the MAC address of the first port added, as is proposed by</i>
&gt;<i> the standard [1]?</i>

It was a convenience in original design to choose a consistent value.
Since ports can be added in any order, using the lowest seemed like
a good idea for the original author. This has been maintained for
backwards compatibility.

&gt;<i> [1] IEEE802.1D, Par. 7.12.5.</i>
&gt;<i>     Quote: "The Bridge Address may be the individual MAC Address of a</i>
&gt;<i> Bridge Port, in which case, use of the address of the lowest numbered</i>
&gt;<i> Bridge Port (Port 1) is recommended."</i>
&gt;<i> </i>
&gt;<i> Thanks in advance,</i>
&gt;<i> </i>
&gt;<i> Michel.</i>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070509050005030505010102--
