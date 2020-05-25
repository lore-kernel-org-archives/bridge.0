Return-Path: <mkubecek@suse.cz>
Date: Mon, 25 May 2020 15:18:10 +0200
From: Michal Kubecek <mkubecek@suse.cz>
Message-ID: <20200525131810.tls4p6qfftprzpxg@lion.mk-sys.cz>
References: <20200525112827.t4nf4lamz6g4g2c5@soft-dev3.localdomain>
 <20200525100322.sjlfxhz2ztrfjia7@lion.mk-sys.cz>
 <88bc4a98-c0c8-32df-142e-d4738fe0065a@cumulusnetworks.com>
 <20200525131435.eqfgqh7gu5hmyc3g@soft-dev3.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525131435.eqfgqh7gu5hmyc3g@soft-dev3.localdomain>
Subject: Re: [Bridge] MRP netlink interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org, davem@davemloft.net

On Mon, May 25, 2020 at 01:14:35PM +0000, Horatiu Vultur wrote:
> The 05/25/2020 13:26, Nikolay Aleksandrov wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 25/05/2020 13:03, Michal Kubecek wrote:
> > > On Mon, May 25, 2020 at 11:28:27AM +0000, Horatiu Vultur wrote:
> > > [...]
> > >> My first approach was to extend the 'struct br_mrp_instance' with a field that
> > >> contains the priority of the node. But this breaks the backwards compatibility,
> > >> and then every time when I need to change something, I will break the backwards
> > >> compatibility. Is this a way to go forward?
> > >
> > > No, I would rather say it's an example showing why passing data
> > > structures as binary data via netlink is a bad idea. I definitely
> > > wouldn't advice this approach for any new interface. One of the
> > > strengths of netlink is the ability to use structured and extensible
> > > messages.
> > >
> > >> Another approach is to restructure MRP netlink interface. What I was thinking to
> > >> keep the current attributes (IFLA_BRIDGE_MRP_INSTANCE,
> > >> IFLA_BRIDGE_MRP_PORT_STATE,...) but they will be nested attributes and each of
> > >> this attribute to contain the fields of the structures they represents.
> > >> For example:
> > >> [IFLA_AF_SPEC] = {
> > >>     [IFLA_BRIDGE_FLAGS]
> > >>     [IFLA_BRIDGE_MRP]
> > >>         [IFLA_BRIDGE_MRP_INSTANCE]
> > >>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
> > >>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
> > >>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
> > >>         [IFLA_BRIDGE_MRP_RING_ROLE]
> > >>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
> > >>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
> > >>         ...
> > >> }
> > >> And then I can parse each field separately and then fill up the structure
> > >> (br_mrp_instance, br_mrp_port_role, ...) which will be used forward.
> > >> Then when this needs to be extended with the priority it would have the
> > >> following format:
> > >> [IFLA_AF_SPEC] = {
> > >>     [IFLA_BRIDGE_FLAGS]
> > >>     [IFLA_BRIDGE_MRP]
> > >>         [IFLA_BRIDGE_MRP_INSTANCE]
> > >>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
> > >>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
> > >>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
> > >>             [IFLA_BRIDGE_MRP_INSTANCE_PRIO]
> > >>         [IFLA_BRIDGE_MRP_RING_ROLE]
> > >>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
> > >>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
> > >>         ...
> > >> }
> > >> And also the br_mrp_instance will have a field called prio.
> > >> So now, if the userspace is not updated to have support for setting the prio
> > >> then the kernel will use a default value. Then if the userspace contains a field
> > >> that the kernel doesn't know about, then it would just ignore it.
> > >> So in this way every time when the netlink interface will be extended it would
> > >> be backwards compatible.
> > >
> > > Silently ignoring unrecognized attributes in userspace requests is what
> > > most kernel netlink based interfaces have been doing traditionally but
> > > it's not really a good idea. Essentially it ties your hands so that you
> > > can only add new attributes which can be silently ignored without doing
> > > any harm, otherwise you risk that kernel will do something different
> > > than userspace asked and userspace does not even have a way to find out
> > > if the feature is supported or not. (IIRC there are even some places
> > > where ignoring an attribute changes the nature of the request but it is
> > > still ignored by older kernels.)
> > >
> > > That's why there have been an effort, mostly by Johannes Berg, to
> > > introduce and promote strict checking for new netlink interfaces and new
> > > attributes in existing netlink attributes. If you don't have strict
> > > checking for unknown attributes enabled yet, there isn't much that can
> > > be done for already released kernels but I would suggest to enable it as
> > > soon as possible.
> > >
> > > Michal
> 
> Thanks for the detail explanation. Currently this is in net-next so I
> would try to change it.
> Can you point me to some code that is using this strict checking for
> netlink attributes? Just to have a better understanding of it.

AFAICS you are using nla_parse_nested() in br_mrp_parse() so that the
validation should be strict, including rejection of unknown attributes.
See the comments at nla_parse() and nla_parse_deprecated() and
enum netlink_validation in include/net/netlink.h for details.

Michal

> > +1, we don't have strict checking for the bridge main af spec attributes, but
> > you could add that for new nested interfaces that need to be parsed like the
> > above
