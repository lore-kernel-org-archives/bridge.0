Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bridge] Question about VLANs, bridges and switches
Date: Fri, 26 Aug 2005 12:31:26 -0400
Message-ID: <EDF30175FE4D804B83444FB153172A5070D89E@louexch.KiZAN.net>
From: "Jeff Gercken" <JeffG@kizan.com>
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ryan McConigley <ryan@csse.uwa.edu.au>, bridge@lists.osdl.org

If you take a network and divide it into two vlans the idea is you're
creating two distinct network spaces on one physical network.  Logically
they are independent even though they use the same wires.  By bridging
them together you join the two at layer2 effectively undoing all the
benefits gained by creating the vlans.  You really want to connect the
vlans at layer3 (routing).

-Jeff

-----Original Message-----
From: bridge-bounces@lists.osdl.org
[mailto:bridge-bounces@lists.osdl.org] On Behalf Of Ryan McConigley
Sent: Friday, August 26, 2005 5:56 AM
To: bridge@lists.osdl.org
Subject: [Bridge] Question about VLANs, bridges and switches


	I have a question about bridges, vlans and switches.    We had
been using 
a bridge to provide filtering between our student labs and the main
network.  All the filtering does is check that a known IP matches a
known MAC address, this stops students plugging in laptops and stealing
an IP address.  (And yes, we know about the MAC spoofing issues too)
The connection was nice and simple, basically:

        [Main switch]-----<bridge firewall>-------[Lab Switch]

	And it was working fine.  Then of course, earlier this year, we
upgraded our network and the guy who did it created vlans so now we're
bridging from
Vlan_1 to Vlan_2 on seperate ports on the same switch.

	That has apparently been working fine as well, but when one of
the uni network guys looked at it he freaked and started going on about
the problems of arp broadcasts and he was insisting we replace it
immediately, but of course, couldn't provide any suggestions as to how
to replace it.  Since we're in a university and things appeared to be
working normally, I did what seemed natural... I ignored him.  (Mainly
because it was the middle of semester and changing things then is bad)

	Step forward a few months and here I am currently building two
replacement firewalls, so I thought I'd ask the list about problems with
bridging vlans on the same switch.

	I'll admit, the switch sees the mac address on two ports with
each port being on different vlans, so there could be some issues there,
but also everything seems to be working fine.  The two seem to
contradict each other or maybe we're just being lucky and not noticing
problems.

	So, anyone have any suggestions?  Is what we're doing
good/bad/suicidal?  Or does anyone have any suggestions how it could be
done better?  This new box I'm giving VLAN functionality and possibly
some routing too, still figuring out exactly how to put everything
together and what is needed.

	Cheers,
		Ryan.
--
           Ryan McConigley - Systems Administrator                  _.-,
      Computer Science   University of Western Australia        .--'
'-._
        Tel: (+61 8) 6488 7082 - Fax: (+61 8) 6488 1089       _/`-  _
'.
Ryan[@]csse.uwa.edu.au - http://www.csse.uwa.edu.au/~ryan
'----'._`.----. \
                                                                      `
\;
  "You're just jealous because the voices are talking to me"
;_\




