Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Pp55f5y/3oXmseDIKRvoQW92fcBrV55sv14SYmev+XI=;
 b=fn+MasOnPFOP+G2YS1p862AHL5F2hGI1qIlW52jGzrFMUpu85fSoUUO74d/pYH3hpw
 ohHAepPizDOATi/sSyAhsvMjWMNUFkNLStzWDbE7I4Xj5Ji+8H1hvHTXCGO/tM6w3gp5
 ukmUTPJ78PNNgCZvwEjwX4sbbU1LfF90yon+c=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
 <20200905082410.2230253-6-nikolay@cumulusnetworks.com>
 <20200906135604.4d47b7a8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <89eb1120-5776-081e-52ce-1ef92f41ecbe@cumulusnetworks.com>
Message-ID: <6765a976-0284-6ae9-f4f6-c0a72b80921b@cumulusnetworks.com>
Date: Mon, 7 Sep 2020 00:31:35 +0300
MIME-Version: 1.0
In-Reply-To: <89eb1120-5776-081e-52ce-1ef92f41ecbe@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v3 05/15] net: bridge: mcast: factor
 out port group del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On 9/7/20 12:29 AM, Nikolay Aleksandrov wrote:
> On 9/6/20 11:56 PM, Jakub Kicinski wrote:
>> On Sat,  5 Sep 2020 11:24:00 +0300 Nikolay Aleksandrov wrote:
>>> @@ -843,24 +843,11 @@ static int __br_mdb_del(struct net_bridge *br, struct br_mdb_entry *entry)
>>>           if (!p->port || p->port->dev->ifindex != entry->ifindex)
>>>               continue;
>>> -        if (!hlist_empty(&p->src_list)) {
>>> -            err = -EINVAL;
>>> -            goto unlock;
>>> -        }
>>> -
>>>           if (p->port->state == BR_STATE_DISABLED)
>>>               goto unlock;
>>> -        __mdb_entry_fill_flags(entry, p->flags);
>>
>> Just from staring at the code it's unclear why the list_empty() check
>> and this __mdb_entry_fill_flags() are removed as well.
>>
> 
> The hlist_empty check is added by patch 01 temporarily for correctness.
> Otherwise I'd have to edit all open-coded pg del places and add src delete
> code and then remove it here.
> 

Obviously if I do a v4, I'll just move this patch before adding the hlist_empty
in the first place. :-)

> __mdb_entry_fill_flags() are called by __mdb_fill_info() which is the only
> function used to fill an mdb both for dumping and notifications after patch 08.
> 
>>> -        rcu_assign_pointer(*pp, p->next);
>>> -        hlist_del_init(&p->mglist);
>>> -        del_timer(&p->timer);
>>> -        kfree_rcu(p, rcu);
>>> +        br_multicast_del_pg(mp, p, pp);
>>>           err = 0;
>>> -
>>> -        if (!mp->ports && !mp->host_joined &&
>>> -            netif_running(br->dev))
>>> -            mod_timer(&mp->timer, jiffies);
>>>           break;
>>
>>
>>> +void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
>>> +             struct net_bridge_port_group *pg,
>>> +             struct net_bridge_port_group __rcu **pp)
>>> +{
>>> +    struct net_bridge *br = pg->port->br;
>>> +    struct net_bridge_group_src *ent;
>>> +    struct hlist_node *tmp;
>>> +
>>> +    rcu_assign_pointer(*pp, pg->next);
>>> +    hlist_del_init(&pg->mglist);
>>> +    del_timer(&pg->timer);
>>> +    hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
>>> +        br_multicast_del_group_src(ent);
>>> +    br_mdb_notify(br->dev, pg->port, &pg->addr, RTM_DELMDB, pg->flags);
>>> +    kfree_rcu(pg, rcu);
>>> +
>>> +    if (!mp->ports && !mp->host_joined && netif_running(br->dev))
>>> +        mod_timer(&mp->timer, jiffies);
>>> +}
>>
>>> @@ -1641,16 +1647,7 @@ br_multicast_leave_group(struct net_bridge *br,
>>>               if (p->flags & MDB_PG_FLAGS_PERMANENT)
>>>                   break;
>>> -            rcu_assign_pointer(*pp, p->next);
>>> -            hlist_del_init(&p->mglist);
>>> -            del_timer(&p->timer);
>>> -            kfree_rcu(p, rcu);
>>> -            br_mdb_notify(br->dev, port, group, RTM_DELMDB,
>>> -                      p->flags | MDB_PG_FLAGS_FAST_LEAVE);
>>
>> And here we'll loose MDB_PG_FLAGS_FAST_LEAVE potentially?
>>
> 
> Good catch, we will lose the fast leave indeed.
> This is a 1 line change to set the flag before notifying. Would you prefer
> me to send a v4 or a follow up for it?
> 
> Thanks,
>   Nik
> 
>>> -            if (!mp->ports && !mp->host_joined &&
>>> -                netif_running(br->dev))
>>> -                mod_timer(&mp->timer, jiffies);
>>> +            br_multicast_del_pg(mp, p, pp);
> 

