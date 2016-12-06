Return-Path: <blp@ovn.org>
Date: Mon, 5 Dec 2016 16:59:49 -0800
From: Ben Pfaff <blp@ovn.org>
Message-ID: <20161206005949.GM3129@ovn.org>
References: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
	<20161203232730.GT3129@ovn.org>
	<20161205172436.cpxohof6rggxid74@rere.qmqm.pl>
	<20161205185545.GB3129@ovn.org>
	<20161205225247.e3dd6dcw3ryjjlp2@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161205225247.e3dd6dcw3ryjjlp2@rere.qmqm.pl>
Subject: Re: [Bridge] [ovs-dev] [PATCH net-next] net: remove abuse of VLAN
	DEI/CFI bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: dev@openvswitch.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Mon, Dec 05, 2016 at 11:52:47PM +0100, Michał Mirosław wrote:
> On Mon, Dec 05, 2016 at 10:55:45AM -0800, Ben Pfaff wrote:
> > On Mon, Dec 05, 2016 at 06:24:36PM +0100, Michał Mirosław wrote:
> > > On Sat, Dec 03, 2016 at 03:27:30PM -0800, Ben Pfaff wrote:
> > > > On Sat, Dec 03, 2016 at 10:22:28AM +0100, Michał Mirosław wrote:
> > > > > This All-in-one patch removes abuse of VLAN CFI bit, so it can be passed
> > > > > intact through linux networking stack.
> > > > This appears to change the established Open vSwitch userspace API.  You
> > > > can see that simply from the way that it changes the documentation for
> > > > the userspace API.  If I'm right about that, then this change will break
> > > > all userspace programs that use the Open vSwitch kernel module,
> > > > including Open vSwitch itself.
> > > 
> > > If I understood the code correctly, it does change expected meaning for
> > > the (unlikely?) case of header truncated just before the VLAN TCI - it will
> > > be impossible to differentiate this case from the VLAN TCI == 0.
> > > 
> > > I guess this is a problem with OVS API, because it doesn't directly show
> > > the "missing" state of elements, but relies on an "invalid" value.
> > 
> > That particular corner case should not be a huge problem in any case.
> > 
> > The real problem is that this appears to break the common case use of
> > VLANs in Open vSwitch.  After this patch, parse_vlan() in
> > net/openvswitch/flow.c copies the tpid and tci from sk_buff (either the
> > accelerated version of them or the version in the skb data) into
> > sw_flow_key members.  OK, that's fine on it's own.  However, I don't see
> > any corresponding change to the code in flow_netlink.c to compensate for
> > the fact that, until now, the VLAN CFI bit (formerly VLAN_TAG_PRESENT)
> > was always required to be set to 1 in flow matches inside Netlink
> > messages sent from userspace, and the kernel always set it to 1 in
> > corresponding messages sent to userspace.
> > 
> > In other words, if I'm reading this change correctly:
> > 
> >     * With a kernel before this change, userspace always had to set
> >       VLAN_TAG_PRESENT to 1 to match on a VLAN, or the kernel would
> >       reject the flow match.
> > 
> >     * With a kernel after this change, userspace must not set
> >       VLAN_TAG_PRESENT to 1, otherwise the kernel will accept the flow
> >       match but nothing will ever match because packets do not actually
> >       have the CFI bit set.
> > 
> > Take a look at this code that the patch deletes from
> > validate_vlan_from_nlattrs(), for example, and see how it insisted that
> > VLAN_TAG_PRESENT was set:
> > 
> > 	if (!(tci & htons(VLAN_TAG_PRESENT))) {
> > 		if (tci) {
> > 			OVS_NLERR(log, "%s TCI does not have VLAN_TAG_PRESENT bit set.",
> > 				  (inner) ? "C-VLAN" : "VLAN");
> > 			return -EINVAL;
> > 		} else if (nla_len(a[OVS_KEY_ATTR_ENCAP])) {
> > 			/* Corner case for truncated VLAN header. */
> > 			OVS_NLERR(log, "Truncated %s header has non-zero encap attribute.",
> > 				  (inner) ? "C-VLAN" : "VLAN");
> > 			return -EINVAL;
> > 		}
> > 	}
> > 
> > Please let me know if I'm overlooking something.
> 
> Hmm. So the easiest change without disrupting current userspace, would be
> to flip the CFI bit on the way to/from OVS userspace. Does this seem
> correct?

That sounds correct.  (The bit should not be flipped in the mask.)

Thanks,

Ben.
