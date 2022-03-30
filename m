Return-Path: <jay.vosburgh@canonical.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1648667761;
 bh=e5dkA3qH+uuDiLClm1Oo80cVgcvwun8I0S6yuR2jxQk=;
 h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
 Content-Type:Date:Message-ID;
 b=iQ7W6OMgZtu6n1x/COyYQIbMLN+F7uc4lcz4Lz1vibHByGCxltMxn5OoDyUAjhrQX
 4V9rhblz2IHwsOqjth5i0ncyjwLH/YXGpccWgZKi7OmtrOTjDuigWQ9MI1YpUCd1LC
 iuVme6tPje+eHkpGIKzVtLtoGcsFUHNfjGe67gUSZMYh9JZrR0Pxgpka3q5VYSIYF4
 kfDDuqSy2env8GEPreJHqMsLAfiu21jm8Ye2a2HFS40r5YPc2vGuIl+gjy7oLZ45zW
 g9bOKykv2LJCEpjgieSXp6opvf+wRbSn5TIgYWtQ0RumnJPCUtPgY2WS+ch7Yi81DW
 pqB3hBI65PwzA==
From: Jay Vosburgh <jay.vosburgh@canonical.com>
In-reply-to: <20220330101256.53f6ef48@kernel.org>
References: <20220329114052.237572-1-wintera@linux.ibm.com>
 <20220329175421.4a6325d9@kernel.org>
 <d2e45c4a-ed34-10d3-58cd-01b1c19bd004@blackwall.org>
 <c1ec0612-063b-dbfa-e10a-986786178c93@linux.ibm.com>
 <20220330085154.34440715@kernel.org>
 <c512e765-f411-9305-013b-471a07e7f3ff@blackwall.org>
 <20220330101256.53f6ef48@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2599.1648667758.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Mar 2022 12:15:58 -0700
Message-ID: <2600.1648667758@famine>
Subject: Re: [Bridge] [PATCH net-next v2] veth: Support bonding events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-s390@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Heiko Carstens <hca@linux.ibm.com>, Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@nvidia.com>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Wed, 30 Mar 2022 19:16:42 +0300 Nikolay Aleksandrov wrote:
>> > Maybe opt-out? But assuming the event is only generated on
>> > active/backup switch over - when would it be okay to ignore
>> > the notification?
>> =

>> Let me just clarify, so I'm sure I've not misunderstood you. Do you mea=
n opt-out as in
>> make it default on? IMO that would be a problem, large scale setups wou=
ld suddenly
>> start propagating it to upper devices which would cause a lot of unnece=
ssary bcast.
>> I meant enable it only if needed, and only on specific ports (second pa=
rt is not
>> necessary, could be global, I think it's ok either way). I don't think =
any setup
>> which has many upper vlans/macvlans would ever enable this.
>
>That may be. I don't have a good understanding of scenarios in which
>GARP is required and where it's not :) Goes without saying but the
>default should follow the more common scenario.

	At least from the bonding failover persective, the GARP is
needed when there's a visible topology change (so peers learn the new
path), a change in MAC address, or both.  I don't think it's possible to
determine from bonding which topology changes are visible, so any
failover gets a GARP.  The original intent as best I recall was to cover
IP addresses configured on the bond itself or on VLANs above the bond.

	If I understand the original problem description correctly, the
bonding failover causes the connectivity issue because the network
segments beyond the bond interfaces don't share forwarding information
(i.e., they are completely independent).  The peer (end station or
switch) at the far end of those network segments (where they converge)
is unable to directly see that the "to bond eth0" port went down, and
has no way to know that anything is awry, and thus won't find the new
path until an ARP or forwarding entry for "veth_a2" (from the original
diagram) times out at the peer out in the network.

>> >> My concern was about the Hangbin's alternative proposal to notify al=
l
>> >> bridge ports. I hope in my porposal I was able to avoid infinite loo=
ps.  =

>> > =

>> > Possibly I'm confused as to where the notification for bridge master
>> > gets sent..  =

>> =

>> IIUC it bypasses the bridge and sends a notify peers for the veth peer =
so it would
>> generate a grat arp (inetdev_event -> NETDEV_NOTIFY_PEERS).
>
>Ack, I was basically repeating the question of where does =

>the notification with dev =3D=3D br get generated.
>
>There is a protection in this patch to make sure the other =

>end of the veth is not plugged into a bridge (i.e. is not
>a bridge port) but there can be a macvlan on top of that
>veth that is part of a bridge, so IIUC that check is either
>insufficient or unnecessary.

	I'm a bit concerned this is becoming a interface plumbing
topology change whack-a-mole.

	In the above, what if the veth is plugged into a bridge, and
there's a end station on that bridge?  If it's bridges all the way down,
where does the need for some kind of TCN mechanism stop?

	Or instead of a veth it's an physical network hop (perhaps a
tunnel; something through which notifiers do not propagate) to another
host with another bridge, then what?

	-J

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
