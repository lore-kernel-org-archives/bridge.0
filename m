MIME-Version: 1.0
In-Reply-To: <4B31354D.3080805@navigue.com>
References: <4B31354D.3080805@navigue.com>
Date: Tue, 22 Dec 2009 15:32:19 -0600
Message-ID: <2e59e6970912221332g5091f49ao69a6c8bdfad1277c@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] ebtables/iptables ambiguity
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jonathan Thibault <jonathan@navigue.com>
Cc: bridge@lists.linux-foundation.org

On Tue, Dec 22, 2009 at 3:08 PM, Jonathan Thibault <jonathan@navigue.com> w=
rote:
> I am trying to use connmark based on the bridge output port.
>
> Normally, I would:
>
> ...
> iptables -t mangle -A VMARK -i out -m physdev --physdev-out in.15 -j MARK=
 --or-mark 0x00F
> ...
> iptables -t mangle -A VMARK -j CONNMARK --save-mark
>
> (VMARK is called in -t mangle POSTROUTING)
>
> But since this traffic is routed and not bridged, I get the expected:
>
> "physdev match: using --physdev-out in the OUTPUT, FORWARD and POSTROUTIN=
G chains for non-bridged traffic is not supported anymore."
>
> Now I could use ebtables to perform the mark in, say, filter FORWARD, but=
 would it know which member interface the packets are going if the traffic =
is not being bridged? =C2=A0And if so, would the mark appear in time for me=
 to -j CONNMARK --save-mark in POSTROUTING/VMARK?

If it isn't being bridged, the packet will pass through the ebtables
OUTPUT chain, not FORWARD (even if it is being routed, that's still
considered input to the local host, pass up to level 3, level 3
routing, then pass back down to level 2 as outgoing from the local
host).

There's a really nice diagram that shows the order all the chains are
visited by packets for pretty much every scenario imaginable.
http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png

As you can see, ebtables POSTROUTING actions will be run before the
packet reaches iptables POSTROUTING, so you should probably use those.

>
> I obviously could try it to see if it works, but I'd rather *understand* =
what I'm doing first ;)
>
> Jonathan
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
