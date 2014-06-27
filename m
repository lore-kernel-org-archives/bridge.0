Return-Path: <matthijs@stdin.nl>
From: Matthijs Kooijman <matthijs@stdin.nl>
Message-ID: <20140627174837.GG1353@login.tika.stderr.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YgGp9RfepglW4nsE"
Content-Disposition: inline
Subject: [Bridge] Unable to DNAT packets back into originating bridge port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 27 Jun 2014 18:33:04 -0000
To: Stephen Hemminger <stephen@networkplumber.org>, Bart De Schuymer <bart.de.schuymer@pandora.be>
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org


--YgGp9RfepglW4nsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

I recently stumbled upon an issue in my iptables setup. After some
extensive debugging, I've found that the problem occurs when trying to
DNAT (+SNAT) a packet that comes in through a bridge, back into the same br=
idge
port it originated from.

The code ultimately responsible for this is the should_deliver function
[1], which prevents packets from being delivered back to their
originating port (ultimately to prevent bouncing broadcast message, I
believe).

[1]: https://github.com/torvalds/linux/blob/v3.14/net/bridge/br_forward.c#L=
30-L36

Another requirement for this issue to occur is the
bridge-nf-call-iptables settings, which must be at the default 1
setting. Without that, the packets are passed up through
br_pass_frame_up normally.

Some more details about my setup:

matthijs@grubby:~$ sudo brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.5cff350f105e       no              eth0

matthijs@grubby:~$ sudo ifconfig br0|grep inet
          inet addr:192.168.1.175  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::5eff:35ff:fe0f:105e/64 Scope:Link

matthijs@grubby:~$ sudo iptables -t nat -L
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination        =20
DNAT       tcp  --  anywhere             anywhere             tcp dpt:81 to=
:192.168.1.252

Chain INPUT (policy ACCEPT)
target     prot opt source               destination        =20

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination        =20

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination        =20
SNAT       tcp  --  anywhere             anywhere             tcp dpt:81 to=
:192.168.1.175

When I now create a connection from a host on eth0, to 192.167.1.175:81, th=
at
packet gets dropped instead of DNATed and SNATed back through eth0 to
192.168.1.184. Enable hairpin mode on eth0, or disabling
bridge-nf-call-iptables makes it work as expected.

Now, is this a bug in the kernel? Or should I not be expecting this setup t=
o work?

While debugging, I reviewed the code to trace the path the packet takes
through the code, and this is what I found (this just from review, I
haven't verified with debug output):

 - The packet comes in br_handle_frame
 - The frame gets dumped into the NF_BR_PRE_ROUTING netfilter chain
   (e.g. the bridge / ebtables version, not the ip / iptables one).
 - The ebtables rules get called
 - The br_nf_pre_routing hook for NF_BR_PRE_ROUTING gets called. This
   interrupts (returns NF_STOLEN) the handling of the NF_BR_PRE_ROUTING
   chain, and calls the NF_INET_PRE_ROUTING chain.
 - The br_nf_pre_routing_finish finish handler gets called after
   completing the NF_INET_PRE_ROUTING chain.
 - This handler resumes the handling of the interrupted
   NF_BR_PRE_ROUTING chain. However, because it detects that DNAT has
   happened, it sets the finish handler to
   br_nf_pre_routing_finish_bridge instead of the regular
   br_handle_frame_finish finish handler.
 - br_nf_pre_routing_finish_bridge runs, this skb->dev to the parent
   bridge and sets the BRNF_BRIDGED_DNAT flag which calls
   neigh->output(neigh, skb); which presumably resolves to one of the
   neigh_*output functions, each of which again calls dev_queue_xmit,
   which should (eventually) call br_dev_xmit.
 - br_dev_xmit sees the BRNF_BRIDGED_DNAT flag and calls
   br_nf_pre_routing_finish_bridge_slow instead of actually delivering
   the packet.
 - br_nf_pre_routing_finish_bridge_slow sets up the destination MAC
   address, sets skb->dev back to skb->physindev and calls
   br_handle_frame_finish.
 - br_handle_frame_finish calls br_forward.
 - br_forward calls should_deliver, which returns false when skb->dev !=3D
   p->dev (and "hairpin mode" is not enabled) causing the packet to be
   dropped.

Some things to note:
 - Why does the packet get redirected to NF_INET_PRE_ROUTING in
   br_nf_pre_routing already? Is it important that it happens halfway
   through the NF_BR_PRE_ROUTING chain? If not, why not do it in
   br_handle_frame_finish / br_forward when it has actually been
   established that the packet will be bridged and not routed?
 - Should should_deliver make an exception for DNAT'ed packets? Or
   perhaps only block broadcasts.

Also see this blogpost for a bit more details about my original setup
and debugging process:
http://www.stderr.nl/Blog/Software/Linux/BouncingPacketsKernelBug.html

Gr.

Matthijs

--YgGp9RfepglW4nsE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlOtrnQACgkQz0nQ5oovr7yYkACeN5CjwvbGHRiFD1qT1ZjKLDEP
gjkAoOQRq3YBIkslXyj/WRd1zEF2fAZ0
=38pn
-----END PGP SIGNATURE-----

--YgGp9RfepglW4nsE--
