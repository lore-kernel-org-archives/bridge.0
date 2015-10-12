Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-type:content-transfer-encoding;
	bh=s/0hZhtN1OFKq1r25+dpdF+Zb0jifm+ZTRUFyOSqCyg=;
	b=QC3NXqrNJrFz7PSlUY7ZzAQYFZhwF/KIZKQCTtRv3rXQmsoxU//JabGLOox0/TQQ7d
	B08lnkXTOBz3kehSa1bhH7NoZ0i/YqRS5GdI1kWTk6+j1RctfBKQU9RlyfOHKVj5Lc0s
	fe9DYGR2/LonOesfFXjj02li0/hiMyv6KyFD4=
References: <1444650069-32572-1-git-send-email-razor@blackwall.org>
	<1444650069-32572-4-git-send-email-razor@blackwall.org>
	<20151012173904.GC6756@colbert.mtl.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <561BF413.5010609@cumulusnetworks.com>
Date: Mon, 12 Oct 2015 19:55:31 +0200
MIME-Version: 1.0
In-Reply-To: <20151012173904.GC6756@colbert.mtl.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/4] bridge: vlan: break vlan_flush in
 two phases to keep old order
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, shm@cumulusnetworks.com, davem@davemloft.net

On 10/12/2015 07:39 PM, Ido Schimmel wrote:
> Mon, Oct 12, 2015 at 02:41:08PM IDT, razor@blackwall.org wrote:
>> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>>
> Hi,
> 
>> Ido Schimmel reported a problem with switchdev devices because of the
>> order change of del_nbp operations, more specifically the move of
>> nbp_vlan_flush() which deletes all vlans and frees vlgrp after the
>> rx_handler has been unregistered. So in order to fix this break
>> vlan_flush in two phases:
>> 1. delete all of vlan_group's vlans
>> 2. destroy rhtable and free vlgrp
>> We execute phase I (free_rht == false) in the same place as before so the
>> vlans can be cleared and free the vlgrp after the rx_handler has been
>> unregistered in phase II (free_rht == true).
> I don't fully understand the reason for the two-phase cleanup. Please
> see below.
>>
>> Reported-by: Ido Schimmel <idosch@mellanox.com>
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>> ---
>> Ido: I hope this fixes it for your case, a test would be much appreciated.
> This indeed fixes our switchdev issue. Thanks for the fix!
>>
[snip]
>>
>> -static void __vlan_flush(struct net_bridge_vlan_group *vlgrp)
>> +static void __vlan_flush(struct net_bridge_vlan_group *vlgrp, bool free_rht)
>> {
>> 	struct net_bridge_vlan *vlan, *tmp;
>>
>> 	__vlan_delete_pvid(vlgrp, vlgrp->pvid);
>> 	list_for_each_entry_safe(vlan, tmp, &vlgrp->vlan_list, vlist)
>> 		__vlan_del(vlan);
>> -	rhashtable_destroy(&vlgrp->vlan_hash);
>> -	kfree_rcu(vlgrp, rcu);
>> +
> Why not just issue a synchronize_rcu here and remove the if statement? I
> believe that would also be better for when we remove the bridge device
> itself. It's fully symmetric with init that way.
Hi,
I considered that, but I don't want to issue a second synchronize_rcu() for each
port when deleting them, with this change we avoid a second synchronize_rcu()
and use the rx_handler unregister one. In complex setups with lots of ports
this is a considerable overhead.
For the bridge device del case - the call is the same, there're no two phases
there.

Cheers,
 Nik
