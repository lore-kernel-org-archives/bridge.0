Return-Path: <linus.luessing@web.de>
Date: Wed, 12 Mar 2014 05:37:40 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140312043740.GS5090@Linus-Debian>
References: <1566805413.12693479.1393872931017.JavaMail.zimbra@redhat.com>
	<20140304000041.GY5090@Linus-Debian>
	<624414844.12834668.1393920156458.JavaMail.zimbra@redhat.com>
	<20140304105253.GC5090@Linus-Debian>
	<1663332249.12962360.1393931189285.JavaMail.zimbra@redhat.com>
	<20140304213757.GJ5090@Linus-Debian>
	<521731164.13535687.1394021407825.JavaMail.zimbra@redhat.com>
	<20140305142706.GL5090@Linus-Debian>
	<1662523546.13613467.1394031472806.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1662523546.13613467.1394031472806.JavaMail.zimbra@redhat.com>
Subject: Re: [Bridge] bridge is not forwaring ICMP6 neighbor solicitation to
	KVM guest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jan Stancek <jstancek@redhat.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fwestpha@redhat.com>, bridge@lists.linux-foundation.org

Hi Jan,

Hope your bridge-snooping related issues are resolved with the two
new patches present in net. If not just let me/us know. Thanks
again for the detailed and helpful reporting!

Cheers, Linus


On Wed, Mar 05, 2014 at 09:57:52AM -0500, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Linus Lüssing" <linus.luessing@web.de>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: netdev@vger.kernel.org, "Florian Westphal" <fwestpha@redhat.com>, bridge@lists.linux-foundation.org
> > Sent: Wednesday, 5 March, 2014 3:27:07 PM
> > Subject: Re: bridge is not forwaring ICMP6 neighbor solicitation to KVM guest
> 
> <snip>
> 
> > 
> > > I hand-crafted one new packet from malformed one used in previous tests.
> > > I modified source address from :: to host B link-scope address and changed
> > > dst address from ff02::1 to ff02::1:ffaa:aaaa
> > 
> > Okay, again according to your capture the guest is receiving the
> > MLD query on its interface but does not react with an MLD report.
> > 
> > Two things I'd like to know:
> > 
> > Is using the link-scope address as a source and "ff02::1" as the
> > destination address for the MLD query work for you?
> 
> Yes, I could not trigger it with such query:
> http://jan.stancek.eu/tmp/neigh_solicit_and_bridge_traces2/guest_mld_query_ff02_1.cap
>   frame 795 -> query
>   frame 1040 -> MLD report from guest
>   ~20 seconds later
>   frame 1507, 1508 -> neigh solicit/advert
>   frame 1580, 1581 -> neigh solicit/advert
> 
> > 
> > Is using the link-scope address as a source and "ff02::1:ff00:29"
> > as the destination address for the MLD query "work" for you (do
> > we see an MLD report from the guest and keep on seeing neighbor
> > solicitations from host B then?).
> 
> Yes, this also worked (though I received 2 reports):
> http://jan.stancek.eu/tmp/neigh_solicit_and_bridge_traces2/guest_mld_query_ff02_1_ff0029.cap
>   frame 446 -> query
>   frame 448 -> MLD report from guest
>   frame 465 -> MLD report from guest
>   frame 689, 690 -> neigh solicit/advert
>   frame 760, 761 -> neigh solicit/advert
>   ...
> 
> Both host and guest were running 3.14.0-rc5 with your sanity check patch.
> 
> Regards,
> Jan
> 
> > 
> > For the latter, I don't see anything in particular filtering these
> > for a general MLD query wrong destination address in the IPv6
> > code from igmp6_event_query() on. But I suspect that the query
> > doesn't even get that far on the kernel of the guest, as it is not
> > listening on ff02::1:ffaa:aaaa. Therefore the test with
> > "ff02::1:ff00:29", an address the guest is listening on, would be
> > interesting.
> > 
> > If that works, then I'm going to make a patch ignore General MLD
> > Queries without ff02::1 as their destination address, too.
> > 
> > 
> > Hm, looking at more checks in igmp6_event_query(), I'm currently
> > wondering whether we should only enable the snooping behaviour in
> > the bridge when receiving a General MLD Query, so one with "::" in
> > the multicast field of the MLD message, instead of activating it
> > upon a Multicast-Address-Specific Query, too. That'd seem more
> > sane to me, I'm going to make a patch for that tomorrow.
> > 
> > Cheers, Linus
> > 
