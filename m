Return-Path: <vyasevic@redhat.com>
Message-ID: <5138AD72.8080104@redhat.com>
Date: Thu, 07 Mar 2013 10:08:34 -0500
From: Vlad Yasevich <vyasevic@redhat.com>
MIME-Version: 1.0
References: <1362623485-18209-1-git-send-email-vyasevic@redhat.com>
	<1362623485-18209-4-git-send-email-vyasevic@redhat.com>
	<51380542.4020601@gmail.com>
In-Reply-To: <51380542.4020601@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 3/3] bridge: Implement
	IFF_UNICAST_FLT
Reply-To: vyasevic@redhat.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 03/06/2013 10:10 PM, John Fastabend wrote:
> On 03/06/2013 06:31 PM, Vlad Yasevich wrote:
>> Implement IFF_UNICAST_FLT on the bridge.  Unicast addresses added
>> to the bridge device are synched to the uplink devices.  This
>> allows for uplink devices to change while preserving mac assignment.
>>
>> Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
>> ---
>
> [...]
>
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index b0812c9..ef7b51e 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -677,6 +677,9 @@ int br_fdb_add(struct ndmsg *ndm, struct nlattr
>> *tb[],
>>       struct net_port_vlans *pv;
>>       unsigned short vid = VLAN_N_VID;
>>
>> +    if ((ndm->ndm_flags & NTF_SELF) && (dev->priv_flags & IFF_EBRIDGE))
>> +        return ndo_dflt_fdb_add(ndm, tb, dev, addr, nlh_flags);
>> +
>>       if (!(ndm->ndm_state & (NUD_PERMANENT|NUD_NOARP|NUD_REACHABLE))) {
>>           pr_info("bridge: RTM_NEWNEIGH with invalid state %#x\n",
>> ndm->ndm_state);
>>           return -EINVAL;
>> @@ -774,6 +777,9 @@ int br_fdb_delete(struct ndmsg *ndm, struct nlattr
>> *tb[],
>>       struct net_port_vlans *pv;
>>       unsigned short vid = VLAN_N_VID;
>>
>> +    if ((ndm->ndm_flags & NTF_SELF) && (dev->priv_flags & IFF_EBRIDGE))
>> +        return ndo_dflt_fdb_del(ndm, tb, dev, addr);
>> +
>>       if (tb[NDA_VLAN]) {
>>           if (nla_len(tb[NDA_VLAN]) != sizeof(unsigned short)) {
>>               pr_info("bridge: RTM_NEWNEIGH with invalid vlan\n");
>>
>
> How is this different then calling the fdb op from rtnetlink.c when the
> NTF_SELF bit is set after your previous patch
>
>      net: generic fdb support for drivers without ndo_fdb_<op>
>
> the generic routine gets called if a specific op is not supplied via
> ndo ops anyways right?
>
> Also I suspect if the driver supplies a specific ndo_fdb_<op> we should
> use it over the generic one.
>
> What am I missing?

The bridge provides the ndo_fdb_<add|del>, so it will be used.  The 
bridge op assumes that the dev passed to it is a port.  This code adds
support for when dev is the bridge.

In fact this patch is counting that rtnetlink will call into the bridge
and lets bridge do the work.

-vlad
>
> Thanks,
> John
>

