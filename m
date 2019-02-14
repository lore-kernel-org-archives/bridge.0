Return-Path: <zahari.doychev@googlemail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=a29jmNwF1Wcq3eUiKazAS3/y0Qc/3oMiFgIjDWWRpik=;
	b=BOpYa0xatvNR9lHgbke2vFCkbGs2WwjWjw5NY5WwNyqfxxcmjlA/HyopG6ym01nPCV
	/F0NJhtM3P0PPGqgB/ytHVlk1nVc9wf6IClf60f5Z7TJdxzj3GF9E/RqWfTYXoNcZ5yi
	2y5ASnWNg2OVbIjLr87wI+Q68fSj54TR8YQB68F9BCGJAC2JE3RvWOqKQeU9ETFoHAwJ
	Ec/vXXg4Y/CY26psCS7ptq1iDEEYVvmsRnOY5tSmUcpKqWbSj428plSFVhLo1nip1dgz
	3MKAleH5jifXu2lqCDHqGPmOCvm4u2rD3wJ3d5wa2LiIplE70mrNVkwOpnkllWz/0mU9
	G0yQ==
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
Date: Thu, 14 Feb 2019 12:54:14 +0100
From: Zahari Doychev <zahari.doychev@linux.com>
Message-ID: <20190214115414.GA27909@riot>
References: <20190213195102.1917-1-zahari.doychev@linux.com>
	<19f5bdf9-c83b-c9ec-83c3-1e9a88763b30@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19f5bdf9-c83b-c9ec-83c3-1e9a88763b30@lab.ntt.co.jp>
Subject: Re: [Bridge] [RFC PATCH] net act_vlan: use correct len in skb_pull
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, johannes@sipsolutions.net

On Thu, Feb 14, 2019 at 06:16:12PM +0900, Toshiaki Makita wrote:
> On 2019/02/14 4:51, Zahari Doychev wrote:
> > The bridge and VLAN code expects that skb->data points to the start of the
> > VLAN header instead of the next (network) header. Currently after
> > tcf_vlan_act() on ingress filter skb->data points to the next network
> > header. In this case the Linux bridge does not forward correctly double
> > tagged VLAN packets added using tc vlan action as the outer vlan tag from
> > the skb is inserted at the wrong offset after the vlan tag in the payload.
> > Making skb->data to point to the VLAN header in tcf_vlan_act() by using
> > ETH_HLEN in skb_pull_rcsum() fixes the problem.
> > 
> > The following commands were used for testing:
> > 
> > ip link add name br0 type bridge vlan_filtering 1
> > ip link set dev br0 up
> > 
> > ip link set dev net0 up
> > ip link set dev net0 master br0
> > 
> > ip link set dev net1 up
> > ip link set dev net1 master br0
> > 
> > bridge vlan add dev net0 vid 100 master
> > bridge vlan add dev br0 vid 100 self
> > bridge vlan add dev net1 vid 100 master
> > 
> > tc qdisc add dev net0 handle ffff: clsact
> > tc qdisc add dev net1 handle ffff: clsact
> > 
> > tc filter add dev net0 ingress pref 1 protocol all flower \
> >                   action vlan push id 10 pipe action vlan push id 100
> > 
> > tc filter add dev net0 egress pref 1 protocol 802.1q flower \
> >                   vlan_id 100 vlan_ethtype 802.1q cvlan_id 10 \
> >                   action vlan pop pipe action vlan pop
> > 
> > Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
> > ---
> >  net/sched/act_vlan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
> > index 93fdaf707313..308d7d89f925 100644
> > --- a/net/sched/act_vlan.c
> > +++ b/net/sched/act_vlan.c
> > @@ -86,7 +86,7 @@ static int tcf_vlan_act(struct sk_buff *skb, const struct tc_action *a,
> >  
> >  out:
> >  	if (skb_at_tc_ingress(skb))
> > -		skb_pull_rcsum(skb, skb->mac_len);
> > +		skb_pull_rcsum(skb, ETH_HLEN);
> 
> As I said before, it would be safer to remember mac_len and use it later.
> 
> 	__u16 mac_len = skb->mac_len;
> ...
> 	err = skb_vlan_push(...)
> ...
> 	if (skb_at_tc_ingress(skb))
> 		skb_pull_rcsum(skb, mac_len);
> 

sorry, I misunderstood it. I will send an update.

Zahari

> 
> -- 
> Toshiaki Makita
> 
