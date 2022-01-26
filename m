Return-Path: <toke@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643201457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e9hOV54Md4mkMW4fxi7kpJhvDxIQw3Di2qayJ9be2AQ=;
 b=DLSkFGgW2t4i1H8JMQrzOgXoTqD0KLaiDl8B6ei76G04jVzuUsDUNX+IqzeITKhcKNgMR5
 o/2OodU6UulwYgLWJ+lxqUJId0Vmj127SVFdlFLFcjNGueiIOSNBY4vp3t+LOqP8vkPdf8
 zpdi+P0ZKemknRoCVJ+zyxWAbIBSpps=
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
In-Reply-To: <113d070a-6df1-66c2-1586-94591bc5aada@nvidia.com>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <61553c87-a3d3-07ae-8c2f-93cf0cb52263@nvidia.com>
 <YfEwLrB6JqNpdUc0@lore-desk>
 <113d070a-6df1-66c2-1586-94591bc5aada@nvidia.com>
Date: Wed, 26 Jan 2022 13:50:51 +0100
Message-ID: <878rv23bkk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, daniel@iogearbox.net, netdev@vger.kernel.org, dsahern@kernel.org, Roopa Prabhu <roopa@nvidia.com>, komachi.yoshiki@gmail.com, ast@kernel.org, davem@davemloft.net, Ido Schimmel <idosch@idosch.org>, memxor@gmail.com, brouer@redhat.com, kuba@kernel.org, bpf@vger.kernel.org, andrii.nakryiko@gmail.com, lorenzo.bianconi@redhat.com

Nikolay Aleksandrov <nikolay@nvidia.com> writes:

> On 26/01/2022 13:27, Lorenzo Bianconi wrote:
>>> On 24/01/2022 19:20, Lorenzo Bianconi wrote:
>>>> Similar to bpf_xdp_ct_lookup routine, introduce
>>>> br_fdb_find_port_from_ifindex unstable helper in order to accelerate
>>>> linux bridge with XDP. br_fdb_find_port_from_ifindex will perform a
>>>> lookup in the associated bridge fdb table and it will return the
>>>> output ifindex if the destination address is associated to a bridge
>>>> port or -ENODEV for BOM traffic or if lookup fails.
>>>>
>>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>>> ---
>>>>  net/bridge/br.c         | 21 +++++++++++++
>>>>  net/bridge/br_fdb.c     | 67 +++++++++++++++++++++++++++++++++++------
>>>>  net/bridge/br_private.h | 12 ++++++++
>>>>  3 files changed, 91 insertions(+), 9 deletions(-)
>>>>
>>>
>>> Hi Lorenzo,
>> 
>> Hi Nikolay,
>> 
>> thx for the review.
>> 
>>> Please CC bridge maintainers for bridge-related patches, I've added Roopa and the
>>> bridge mailing list as well. Aside from that, the change is certainly interesting, I've been
>>> thinking about a similar helper for some time now, few comments below.
>> 
>> yes, sorry for that. I figured it out after sending the series out.
>> 
>>>
>>> Have you thought about the egress path and if by the current bridge state the packet would
>>> be allowed to egress through the found port from the lookup? I'd guess you have to keep updating
>>> the active ports list based on netlink events, but there's a lot of egress bridge logic that
>>> either have to be duplicated or somehow synced. Check should_deliver() (br_forward.c) and later
>>> egress stages, but I see how this is a good first step and perhaps we can build upon it.
>>> There are a few possible solutions, but I haven't tried anything yet, most obvious being
>>> yet another helper. :)
>> 
>> ack, right but I am bit worried about adding too much logic and slow down xdp
>> performances. I guess we can investigate first the approach proposed by Alexei
>> and then revaluate. Agree?
>> 
>
> Sure, that approach sounds very interesting, but my point was that
> bypassing the ingress and egress logic defeats most of the bridge
> features. You just get an fdb hash table which you can build today
> with ebpf without any changes to the kernel. :) You have multiple
> states, flags and options for each port and each vlan which can change
> dynamically based on external events (e.g. STP, config changes etc)
> and they can affect forwarding even if the fdbs remain in the table.

To me, leveraging all this is precisely the reason to have BPF helpers
instead of just replicating state in BPF maps: it's very easy to do that
and show a nice speedup, and then once you get all the corner cases
covered that the in-kernel code already deals with, you've chipped away
at that speedup and spent a lot of time essentially re-writing the
battle-tested code already in the kernel.

So I think figuring out how to do the state sync is the right thing to
do; a second helper would be fine for this, IMO, but I'm not really
familiar enough with the bridge code to really have a qualified opinion.

-Toke

