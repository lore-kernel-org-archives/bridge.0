Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxwfMucszAHmFn0SxPBFzomXvRwRf/HVQvasE15qa6M=;
 b=B60ZqjvipXML8Pb7Y088vwFpqTjPBCtSKGhNrR1qM3es02JDmitGMK7FzvJUZQrD/GDjgZe42BlFSn63KvXtFPm4zDWZApMB7H3uXsImqi7ob4CZMXLEgG8aCCV88XQaDRxUSz00LVYWGF2+47Boi91vF8kr9YybGyMxHKUL9Uj2PvG3JkCyoDvC8sixxe5TH3um7tb+S7Ard+YhUC9v7olU3uibcB3CWX91B/4dooTaFsw86XgPjFcTjrykrs3lEdINJQJLpHkEopnDtPXW/nm0pfhdVOraExQs/aOQc61M0F4pxaWRThfo97PMM6kKL9UFszx+ujpgCcq8x4WkaQ==
Message-ID: <357fad9e-581e-7b71-9b32-aac77d5d13c1@nvidia.com>
Date: Fri, 15 Oct 2021 11:57:06 +0300
Content-Language: en-US
References: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
 <20200907095619.11216-11-nikolay@cumulusnetworks.com>
 <YWjsyk/Dzg2/zVbw@Laptop-X1> <YWkhi7iABEKygKaL@Laptop-X1>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <YWkhi7iABEKygKaL@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH net-next v4 10/15] net: bridge: mcast: support
 for IGMPv3/MLDv2 ALLOW_NEW_SOURCES report
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hangbin Liu <liuhangbin@gmail.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On 15/10/2021 09:36, Hangbin Liu wrote:
> On Fri, Oct 15, 2021 at 10:52:00AM +0800, Hangbin Liu wrote:
>>> -	mod_timer(&p->timer, now + br->multicast_membership_interval);
>>> +	if (igmpv2_mldv1)
>>> +		mod_timer(&p->timer, now + br->multicast_membership_interval);
>>
>> Hi Nikolay,
>>
>> Our engineer found that the multicast_membership_interval will not work with
>> IGMPv3. Is it intend as you said "IGMPv3/MLDv2 handling is not yet
>> implemented" ?
> 
> Ah, I saw in br_multicast_group_expired() it wait for mp->ports be freed
> before delete the mdb entry.
> 
> And in br_multicast_port_group_expired() it wait for src entry freed first.
> 
> But when mod group src timer, we use
> __grp_src_mod_timer(ent, now + br_multicast_gmi(brmctx));
> 
> instead of user configured multicast_membership_interval. I think we should
> fix it. WDYT?
> 
> Thanks
> Hangbin
> 

Hi,
I did that intentionally because of how RFC 3376 defines the GMI:
" 8.4. Group Membership Interval

   The Group Membership Interval is the amount of time that must pass
   before a multicast router decides there are no more members of a
   group or a particular source on a network.

   This value MUST be ((the Robustness Variable) times (the Query
   Interval)) plus (one Query Response Interval)."

So it is computed properly and the RFC says "MUST" be. The only thing that is not
configurable is the QRV currently, if that is added then the GMI will be automatically
correctly computed as per the RFC. I get the inconsistency though as we don't compute all
timers as the RFC mandates, I'm inclined to revert the GMI computation as it was before
and possibly fix how all timers are computed in the future as that may require more work.
In addition this could've changed user-expected behaviour when switching to v3 queries which
were supported before IGMPv3 was added, so yeah going forward looks like it'd be better to
switch to the old GMI behaviour. I'll send the patch in a minute.

Thanks,
 Nik




