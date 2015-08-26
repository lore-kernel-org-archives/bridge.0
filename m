Return-Path: <vyasevic@redhat.com>
Message-ID: <55DDB690.8060601@redhat.com>
Date: Wed, 26 Aug 2015 08:52:32 -0400
From: Vlad Yasevich <vyasevic@redhat.com>
Reply-To: vyasevic@redhat.com
MIME-Version: 1.0
References: <1440549295-3979-1-git-send-email-razor@blackwall.org>	<20150825.194222.390859854071446877.davem@davemloft.net>	<E065D3DC-6CBC-4625-8800-5133E21C5483@cumulusnetworks.com>
	<CAN+pFwJKFeQJw_4mPEH5_WmHdBUn75FL+-Cq=YaR+FR-+cRfEw@mail.gmail.com>
In-Reply-To: <CAN+pFwJKFeQJw_4mPEH5_WmHdBUn75FL+-Cq=YaR+FR-+cRfEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2] bridge: vlan: allow to suppress
 local mac install for all vlans
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: B Viswanath <marichika4@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: bridge@lists.linux-foundation.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, wkok@cumulusnetworks.com, David Miller <davem@davemloft.net>

On 08/26/2015 02:10 AM, B Viswanath wrote:
>>>
>>> I'd rather we fix the essence of the scalability problem than add
>>> more spaghetti code to the various bridge paths.
>>>
>>> Can we make the fdb entries smaller?
>>>
>>> Can we enhance how we store such local entries such that they live in
>>> a compact datastructure?  Perhaps the FDB can consist of a very dense
>>> lookup mechanism for local stuff sitting alongside the current table.
>>
>> Certainly, that should be done and I will look into it, but the essence of this patch
>> is a bit different. The problem here is not the size of the fdb entries, it’s more the
>> number of them - having 96000 entries (even if they were 1 byte ones) is just way
>> too much especially when the fdb hash size is small and static. We could work on making
>> it dynamic though, but still these type of local entries per vlan per port can easily be avoided
>> with this option.
>>
> 
> I was wondering if it is possible to assign a vlan bitmap for the FDB
> entry, instead of replicating the entry for each vlan. ( I believe
> Roopa has done something similar, but not so sure). This means that
> the number of FDB entries remain static for any number of vlans.
> 
> I guess its more complicated than it sounds, but just wanted to know
> if its feasible at all.

I've actually had this done in one of the earlier attempts.  The issue was how
to compress it because there was absolutely no gain if you have a sparse vlan bitmap.

I even tried doing something along the lines of vlan_group array, but that can
explode to full size almost as fast.

What actually worked better was a hash table of vlans where each entry in the table
contained a bunch of data one of which was a list of fdbs for a given vlan.   It
didn't replicate fdbs but simply referenced the ones we cared about and bumped the ref.

However, this made vlan look-ups slower since we now had a hash instead of a bitmap lookup
and Stephen rejected it.

-vlad

> 
> Thanks
> Vissu
> 
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe netdev" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

