Return-Path: <bdschuym@pandora.be>
Message-ID: <4F049290.3090803@pandora.be>
Date: Wed, 04 Jan 2012 18:55:28 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <4F025A07.2000304@nod.at>
	<1325597164-13459-1-git-send-email-richard@nod.at>
	<1325597164-13459-2-git-send-email-richard@nod.at>
	<20120103081521.2fec3a29@nehalam.linuxnetplumber.net>
	<4F033E11.5060707@nod.at> <4F0361D7.3000602@pandora.be>
	<4F03650D.8050200@nod.at>
In-Reply-To: <4F03650D.8050200@nod.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: Fix br_nf_pre_routing() in
 conjunction with bridge-nf-call-ip(6)tables=0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, Stephen Hemminger <shemminger@vyatta.com>, davem@davemloft.net

Op 3/01/2012 21:29, Richard Weinberger schreef:
> Am 03.01.2012 21:15, schrieb Bart De Schuymer:
>> The documentation is probably not explicit enough, but I would keep the
>> behavior as it is now. Setting bridge-nf-call-iptables to 0 makes
>> iptables behave as if bridge-netfilter was not enabled at compilation.
>> Anyway, your patch is almost certainly flawed since the fact that
>> skb->nf_bridge can be NULL is used as part of the logic in
>> br_netfilter.c: it indicates that bridge-nf-call-iptables was 0 when the
>> packet was first processed by bridge-netfilter and should therefore not
>> be given to iptables in any other netfilter hook.
> Thanks for the explanation!
>
> Wouldn't it make sense to check for bridge-nf-call-iptables in xt_physdev?
> So that the user gets warned that his iptables rule will never match...

We don't want to introduce module dependencies between the bridge module 
and the iptables physdev match.
We could add a message to the syslog whenever these proc settings are 
changed (in br_netfilter.c::brnf_sysctl_call_tables()).

cheers,
Bart


-- 
Bart De Schuymer
www.artinalgorithms.be

