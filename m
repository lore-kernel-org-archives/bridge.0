Return-Path: <liuhangbin@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17C5983C7E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2086183C65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682566692; x=1685158692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ELPzBxhv31gJFedKIGPMZx4OFsn/wYXDDLjuH8tqHzk=;
 b=cBQI4hqkpm2Ft2aqMx+KcZLPfkyFFBotV/uCaYCIQwkjMQ+Qh+zidrciBMIcedwfg3
 r/IXJIdvn7kuGE9UdzvM5oyM+EEQ2Mq0eUHnncZgMRc66U2aPAWv7qSyPqjB8aMV0ibp
 /CeHE5Q5Nepx7tPdBsmNQp7JhX3JgTg7B/rqAS8iYAxKmOi1V2R243JPrmnahHQy0e0v
 sQ42oeYjNdI3iGNdr2Irnnu5+A3NwKUpMWzLa5KQHSdsfXiufXVQtj34CdEVLkcK0EAe
 tQuhBVNKKM+lIw3ZeeRnkeffxPFy5olJifc8Ud8B+FmNFfM/tM85NsL6boO3i/O5sLAn
 Horg==
Date: Thu, 27 Apr 2023 11:38:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <ZEnuHppYIE3bCxEs@Laptop-X1>
References: <ZEZK9AkChoOF3Lys@Laptop-X1> <ZEakbR71vNuLnEFp@shredder>
 <5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ddac447-c268-e559-a8dc-08ae3d124352@blackwall.org>
Subject: Re: [Bridge] [Question] Any plan to write/update the bridge doc?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org

On Tue, Apr 25, 2023 at 11:04:47AM +0300, Nikolay Aleksandrov wrote:
> Always +1 for keeping the man pages up-to-date, but I tend to agree with Jakub as well
> that it'd be nice to have an in-kernel doc which explains the uapi and potentially
> at least some more obscure internals (if not all), we can insist on updating it
> for new changes
> 
> I'd be happy to help fill such doc, but at the moment I don't have the
> time to write the basis for it. As Hangbin nicely offered, I think we can start
> there. For a start it'd be nice to make an initial outline of the different sections
> and go on filling them from there.
> 
> E.g. as a starter something like (feel free to edit):
> Introduction
> Bridge internals (fdb, timers, MTU handling, fwding decisions, ports, synchronization)
> STP (mst, rstp, timers, user-space stp etc)
> Multicast (mdb, igmp, eht, vlan-mcast etc)
> VLAN (filtering, options, tunnel...)
> Switchdev
> Netfilter
> MRP/CFM (?)
> FAQ
> 
> Each of these having uapi sections with descriptions. We can include references
> to the iproute2 docs for cmd explanations and examples, but in this doc we'll have
> the uapi descriptions and maybe some helpful information about internal implementation
> that would save future contributors time.
> 
> At the very least we can do the uapi part for each section so options are described
> and uapi nl attribute structures are explained.

OK, I will try start a draft version after the Labor holiday.

Hangbin
