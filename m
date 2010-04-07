MIME-Version: 1.0
In-Reply-To: <000101cad601$5d42a300$17c7e900$@com>
References: <q2x1803dfd21004061402h67b2a920m4b9b1ac2dc66bb2f@mail.gmail.com>
	<l2sc5b98f841004061617s1bb85838k7c1cc7a887646b53@mail.gmail.com>
	<000001cad5e4$fcc81030$f6583090$@com>
	<g2wc5b98f841004061808gc8817c6fj62d89fe4f6810396@mail.gmail.com>
	<p2m1803dfd21004061941zfc89ca1fve66f35ec099e8ea6@mail.gmail.com>
	<n2hc5b98f841004062001ie80b2130ma08829633315c3c@mail.gmail.com>
	<000101cad601$5d42a300$17c7e900$@com>
Date: Tue, 6 Apr 2010 21:29:12 -0600
Message-ID: <s2xc5b98f841004062029oda188282r6f65c3559d1b5d8a@mail.gmail.com>
From: Robert LeBlanc <robert@leblancnet.us>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Bridging vSwitches in VMwares ESXi
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ryan King <ryank@globaldial.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Apr 6, 2010 at 9:21 PM, Ryan King <ryank@globaldial.com> wrote:
> Just to clarify our setup:
>
> The physical server has 4 physical nics. =A0vswitch1 uses 2 pnics in
> active/active. =A0vswitch2 uses 2 pnics in active/active.
>
> The VM (running openvpn) has a bridge with one vnic on vswitch1 and one v=
nic
> on vswitch2. =A0Since moving the 2nd interface to vswitch2, I have not
> experienced this issue any more (ie: previously, both vnics were on vswit=
ch1
> - this was where we saw this issue).

We were using VLANs and bridging across VLANs, this may have
compounded our problem. We we put openvpn on it to connect two
datacenters, we got similar broadcasts storms over the VPN connection
as well.

I was going to do something similar to connect family networks using
openvpn at home until we ran into the problem. I think disbanded the
project, maybe I'll have to look into it again if VLANs were the
problem.

Robert LeBlanc
Life Sciences & Undergraduate Education Computer Support
Brigham Young University
