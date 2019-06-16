Return-Path: <johannes@sipsolutions.net>
Message-ID: <d16897007cee0561127c3155f90a83deb2853cfa.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 16 Jun 2019 21:44:55 +0200
In-Reply-To: <9e3261a9-0fd2-aa36-d739-9f1adca1408b@cumulusnetworks.com>
	(sfid-20190616_105201_738030_DAEF0153)
References: <68c99662210c8e9e37f198ddf8cb00bccf301c4b.camel@sipsolutions.net>
	<20190615151913.cgrfyflwwnhym4u2@ast-mbp.dhcp.thefacebook.com>
	<e487656b854ca999d14eb8072e5553eb2676a9f4.camel@sipsolutions.net>
	<9e3261a9-0fd2-aa36-d739-9f1adca1408b@cumulusnetworks.com>
	(sfid-20190616_105201_738030_DAEF0153)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] VLAN tags in mac_len
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Zahari Doychev <zahari.doychev@linux.com>, jhs@mojatatu.com, Simon Horman <simon.horman@netronome.com>, David Ahern <dsahern@gmail.com>, Cong Wang <xiyou.wangcong@gmail.com>

On Sun, 2019-06-16 at 11:51 +0300, Nikolay Aleksandrov wrote:

> > Thinking along those lines, I sort of ended up with the following scheme
> > (just for the skb head, not the frags/fraglist):
> > 
> >           +------------------+----------------+---------------+
> >  headroom | eth | vlan | ... | IP  | TCP      | payload       | tailroom
> >           +------------------+----------------+---------------+
> > ^ skb->head_ptr
> >           ^ skb->l2_ptr
> >                              ^ skb->l3_ptr == skb->l2_ptr + skb->l2_len
> >                                     ...
> >                                               ^ skb->payload_ptr
> >                                                               ^ skb->tail
[...]

> > (Now, if you wanted to implement this, you probably wouldn't have l2_ptr
> > but l2_offset etc. but that's an implementation detail.)
> > 
> 
> I do like the scheme outlined above, it makes it easier to reason about
> all of this, but obviously it'd require quite some changes.

Yeah. I'm not really ready to suggest something as radical.

But as you found out below, I even got confused *again* while
*carefully* looking at this, and messed up mac_len vs. mac_header_len.

In fact, even looking at it now, I'm not entirely sure I see the
difference. Why do we need both? They have different implementation
semantics, but shouldn't they sort of be the same?

> > > It breaks connectivity between bridge and
> > > members when vlans are used. The host generated packets going out of the bridge
> > > have mac_len = 0.
> > 
> > Which probably indicates that we're not even consistent with the egress
> > scheme I pointed out above, probably because we *also* have
> > hard_header_len?
> > 
> 
> IIRC, mac_len is only set on Rx, while on Tx it usually isn't. More below.

Yes, looks like.

> > I'm not even sure I understand the bug that Nikolay described, because
> > br_dev_xmit() does:
> > 
> >         skb_reset_mac_header(skb);
> >         eth = eth_hdr(skb);
> >         skb_pull(skb, ETH_HLEN);
> > 
> > so after this we *do* end up with an SKB that has mac_len == ETH_HLEN,
> > if it was transmitted out the bridge netdev itself, and thus how would
> > the bug happen?
> > 
> 
> I said *mac_len*. :) 

Yes, I confused myself here.

> The above sets mac_header, at that point you'll have
> the following values: mac_len = 0, mac_header_len = 14 (skb_mac_header_len
> uses network_header - mac_header which is set there), but that is easy
> to overcome and if you do go down the path of consistently using and updating
> mac_len it should work.

Yeah, so basically all we really need is to actually call
skb_reset_mac_len() in addition to skb_reset_mac_header().

Which, is, "slightly" confusing (to say the least) - why are mac_len and
mac_header two completely separate concepts? It almost seems like they
should be two sides of the same coin (len/ptr) but we also have
mac_header_len...

Oh well.

So maybe we should go back to square 1 and resend the patches Zahari had
originally, but with the added skb_reset_mac_len()?

johannes

