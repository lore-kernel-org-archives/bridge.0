MIME-Version: 1.0
In-Reply-To: <4A6638A5.208@ipfire.org>
References: <4A6638A5.208@ipfire.org>
Date: Tue, 21 Jul 2009 17:59:48 -0500
Message-ID: <2e59e6970907211559t1bf1c776r8684d59e98f96069@mail.gmail.com>
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridging untagged and tagged VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Michael Tremer <michael.tremer@ipfire.org>
Cc: bridge@lists.linux-foundation.org

On Tue, Jul 21, 2009 at 4:52 PM, Michael
Tremer<michael.tremer@ipfire.org> wrote:
> Hello everybody,
> I got a weird problem but don't know if it is expected to work.
>
> brctl addbr br0
> vconfig add eth0 30
> brctl addif br0 eth0.30
>
> Until here, everythink works well... I can access the VLAN with id 30.
> But when I run the following:
>
> brctl addif br0 eth0

I'm sure someone will step in and correct me if I'm wrong.

You are wanting to treat packets with no VLAN header the same as those
tagged in VLAN 30.  But "eth0" does not mean "packets with no VLAN
header", it means *ALL* packets which arrive through eth0.  This
packet stream is passed through VLAN processing and distribution is
done, dealing the payloads (now without the VLAN header) to the
virtual interfaces.

Imagine if the bridge module blindly did what you asked.  Then every
packet in eth0.30 would have a VLAN header added and placed into eth0
for transmission.  Because eth0 is part of a bridge, it is eligible
for transmission through each port of the bridge, so it is copied to
eth0.30.  Now the VLAN module processes it out, adding a VLAN header
and placing it into eth0.  The snowball effect would quickly swamp the
network.  So bridge ignores the virtual slave interfaces if you brctl
addif the master device.

I don't think Linux VLAN support provides a way to separate packets
with _no_ VLAN header onto a virtual interface, but that surely sounds
useful.  There'd be problems with nested VLANs though.  In a system
with two layer nesting, is a packet that arrives with only one tag
treated as missing the inner tag or the outer one?

>
> Then, I can't access the VLAN any more but the untagged LAN.
> But instead of adding eth0:
>
> vconfig add eth0 40
> brctl addif br0 eth0.40
>
> It works.
>
> It would be nice if you can me give a short advice...
> Is it not possible to bridge an untagged LAN with a tagged VLAN or
> is this a bug?
>
> Sincerely,
>
> Michael
>
> Kernel 2.6.29, brctl 1.4
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge
>
