Return-Path: <bdschuym@pandora.be>
Message-ID: <4F0361D7.3000602@pandora.be>
Date: Tue, 03 Jan 2012 21:15:19 +0100
From: Bart De Schuymer <bdschuym@pandora.be>
MIME-Version: 1.0
References: <4F025A07.2000304@nod.at>
	<1325597164-13459-1-git-send-email-richard@nod.at>
	<1325597164-13459-2-git-send-email-richard@nod.at>
	<20120103081521.2fec3a29@nehalam.linuxnetplumber.net>
	<4F033E11.5060707@nod.at>
In-Reply-To: <4F033E11.5060707@nod.at>
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

Op 3/01/2012 18:42, Richard Weinberger schreef:
> Am 03.01.2012 17:15, schrieb Stephen Hemminger:
>> On Tue,  3 Jan 2012 14:26:04 +0100
>> Richard Weinberger<richard@nod.at>  wrote:
>>
>>> If net.bridge.bridge-nf-call-iptables or net.bridge.bridge-nf-call-ip6tables
>>> are set to zero xt_physdev has no effect because skb->nf_bridge has not been set up.
>>>
>>> Signed-off-by: Richard Weinberger<richard@nod.at>
>> I am not sure if this is a valid configuration. The setting of sysctl is saying
>> "don't do iptables on bridge (since I won't be using it)" and then you are later
>> doing iptables and expecting the settings as if the iptables setup was being
>> done.
> I don't think so.
>
> Also rules like this one are broken:
> iptables -A INPUT -i bridge0 -m physdev --physdev-in eth0 -j ...
>
> No firewalling is done on the bridge, xt_physdev is only using some meta
> information.
>
> At least a big fat warning would be nice that xt_physdev does not work
> if bridge-nf-call-iptables=0.
> It took me some time to figure out why my firewall rule set gone nuts on
> RHEL6...

The documentation is probably not explicit enough, but I would keep the 
behavior as it is now. Setting bridge-nf-call-iptables to 0 makes 
iptables behave as if bridge-netfilter was not enabled at compilation.
Anyway, your patch is almost certainly flawed since the fact that 
skb->nf_bridge can be NULL is used as part of the logic in 
br_netfilter.c: it indicates that bridge-nf-call-iptables was 0 when the 
packet was first processed by bridge-netfilter and should therefore not 
be given to iptables in any other netfilter hook.

cheers,
Bart


-- 
Bart De Schuymer
www.artinalgorithms.be

