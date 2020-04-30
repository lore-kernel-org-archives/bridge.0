Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7QEu8lQDX7asS/EZnMosCw8iJ8orrbIm4oxu4zfa7w8=;
 b=HucCPpnpma0D9qFGBTzTef+mq4pL65ONVeTzpZom5AgHG+MJYKVQrLsrWUbXmKSWRA
 RsmDdNSJ8Lcfq2n85ORjZE7iWC3gulDmD1hdMaONaELzssFXRIg1uvtrYgDcI6limxZN
 EZJiO5nW2WdKnP7m5Ndy1ZNZ85oi6eISP3/a8=
References: <85b1e301-8189-540b-b4bf-d0902e74becc@profihost.ag>
 <20200430105551.GA4068275@splinter>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4b3a6079-d8d4-24c5-8fc9-15bcb96bca80@cumulusnetworks.com>
Date: Thu, 30 Apr 2020 14:20:23 +0300
MIME-Version: 1.0
In-Reply-To: <20200430105551.GA4068275@splinter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] BUG: soft lockup while deleting tap interface from
 vlan aware bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net

On 30/04/2020 13:55, Ido Schimmel wrote:
> On Wed, Apr 29, 2020 at 10:52:35PM +0200, Stefan Priebe - Profihost AG wrote:
>> Hello,
>>
>> while running a stable vanilla kernel 4.19.115 i'm reproducably get this
>> one:
>>
>> watchdog: BUG: soft lockup - CPU#38 stuck for 22s! [bridge:3570653]
>>
>> ...
>>
>> Call
>> Trace:nbp_vlan_delete+0x59/0xa0br_vlan_info+0x66/0xd0br_afspec+0x18c/0x1d0br_dellink+0x74/0xd0rtnl_bridge_dellink+0x110/0x220rtnetlink_rcv_msg+0x283/0x360
> 
> Nik, Stefan,
> 
> My theory is that 4K VLANs are deleted in a batch and preemption is
> disabled (please confirm). For each VLAN the kernel needs to go over the

Right, that's what I was expecting. :-)

> entire FDB and delete affected entries. If the FDB is very large or the
> FDB lock is contended this can cause the kernel to loop for more than 20
> seconds without calling schedule().

Indeed, we already have that issue also with expire which goes over all entries.
I have rough patches that improve the situation from way back, will have to go over and
polish them to submit when I got more time. Long ago I've tested it with expiring 10 million
entries but on a rather powerful CPU.

> 
> To reproduce I added mdelay(100) in br_fdb_delete_by_port() and ran
> this:
> 
> ip link add name br10 up type bridge vlan_filtering 1
> ip link add name dummy10 up type dummy
> ip link set dev dummy10 master br10
> bridge vlan add vid 1-4094 dev dummy10 master
> bridge vlan del vid 1-4094 dev dummy10 master
> 
> Got a similar trace to Stefan's. Seems to be fixed by attached:
> 
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index a774e19c41bb..240e260e3461 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -615,6 +615,7 @@ int br_process_vlan_info(struct net_bridge *br,
>                                                v - 1, rtm_cmd);
>                                 v_change_start = 0;
>                         }
> +                       cond_resched();
>                 }
>                 /* v_change_start is set only if the last/whole range changed */
>                 if (v_change_start)
> 
> WDYT?
> 

Maybe we can batch the deletes at say 32 at a time?
Otherwise looks good to me, thanks!
