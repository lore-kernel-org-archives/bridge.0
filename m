Return-Path: <vyasevic@redhat.com>
Message-ID: <510C786E.5040406@redhat.com>
Date: Fri, 01 Feb 2013 21:22:38 -0500
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1359748930-31475-1-git-send-email-vyasevic@redhat.com>
	<1359748930-31475-6-git-send-email-vyasevic@redhat.com>
	<CAHXqBFKXEHjghyDe4UQs4inH55UzWcsz+eWAXR4qFiM7+4yVxw@mail.gmail.com>
	<CAHXqBFJ3FutyBGNAXPueWLqJncvzNqd69nTJc0nLgUqzFMTWjw@mail.gmail.com>
In-Reply-To: <CAHXqBFJ3FutyBGNAXPueWLqJncvzNqd69nTJc0nLgUqzFMTWjw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH v9 net-next 05/12] bridge: Add the ability to
 configure pvid
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: netdev@vger.kernel.org, shemminger@vyatta.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 02/01/2013 08:15 PM, Micha=B3 Miros=B3aw wrote:
> 2013/2/2 Micha=B3 Miros=B3aw <mirqus@gmail.com>:
>> 2013/2/1 Vlad Yasevich <vyasevic@redhat.com>:
>>> A user may designate a certain vlan as PVID.  This means that
>>> any ingress frame that does not contain a vlan tag is assigned to
>>> this vlan and any forwarding decisions are made with this vlan in mind.
>> [...]
>>>   struct net_port_vlans {
>>>          u16                             port_idx;
>>> +       u16                             pvid;
>>
>> I'm confused about the implementation. I would expect pvid field in
>> net_bridge_port and adding a tag if it isn't there on ingress path.
>> The rest would be just like without PVIDs. But here you pvid field to
>> net_port_vlans, and don't do anything with it in receive nor transmit
>> path. Does it work? What am I missing?
>
> Found the answer in next patch (you should merge #5 and #6).

It was split for incremental testing.  #5 added the ability to set and
delete it without impacting anything.  #6 added the actual work that=20
pvid does.

> Still,
> the implementation looks overly complicated. If you force the packet
> to canonical form on ingress (keeping outer tag in skb->vlan_tci, and
> setting skb->vlan_tci =3D pvid if there is no tag) the code should get
> simpler.

What if there is no outer tag?  That's what the ingress code is doing.
If there is no outer tag, pvid is written to vlan_tci.  If there was
outer tag in vlan_tci, it's left alone.  This way at the end of ingress
vlan_tci is always set.
At egress, we grab that tag and compare it against pvid if any.  If it
matches, it's stripped.  If it doesn't, we output with the tag thus
adding the header.

The only thing I can simplify is grab the tci directly at egress, but
that's what the code will do anyway.

-vlad

>
> Best Regards,
> Micha=B3 Miros=B3aw
>

