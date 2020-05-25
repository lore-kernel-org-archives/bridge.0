Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1590405297; x=1621941297;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DkzcK68md6XilH2dppEDef9a0CRnGtzIBxslEKzPNoE=;
 b=0CC/Qz4JIxbTOzDLaxtBa3U1hTJ0qYstcdPLUEyCVVTQxC+V333SkMwO
 W1GHwA+Aau75x9DW7UwBl9so/xaQz3BJbo2qPRVHO22M89gG9pIF6IhJH
 OV5ML+GxrVAv4qkROTEGAz1hSzu8xdy68OZjqoqD+tvMCipNwnP32hDwR
 izWJvC8RnXah85BhMOlcoc7LBg9KSkRIpfnv7+Gr2x491i2bqhQ9hDLTl
 H2d/Gv6QzcG03n5U5aEmcpFyMHxy9P16/1dUHEisdiSXdQvtSUIcQKo1U
 HMfe9773AnEn80yTRPNgC1TZYOoaYVWdmcHftKVf/kzB/lV8Ex+3rAkkZ g==;
Date: Mon, 25 May 2020 13:14:35 +0000
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200525131435.eqfgqh7gu5hmyc3g@soft-dev3.localdomain>
References: <20200525112827.t4nf4lamz6g4g2c5@soft-dev3.localdomain>
 <20200525100322.sjlfxhz2ztrfjia7@lion.mk-sys.cz>
 <88bc4a98-c0c8-32df-142e-d4738fe0065a@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <88bc4a98-c0c8-32df-142e-d4738fe0065a@cumulusnetworks.com>
Subject: Re: [Bridge] MRP netlink interface
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, andrew@lunn.ch, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, kuba@kernel.org, davem@davemloft.net

The 05/25/2020 13:26, Nikolay Aleksandrov wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On 25/05/2020 13:03, Michal Kubecek wrote:
> > On Mon, May 25, 2020 at 11:28:27AM +0000, Horatiu Vultur wrote:
> > [...]
> >> My first approach was to extend the 'struct br_mrp_instance' with a field that
> >> contains the priority of the node. But this breaks the backwards compatibility,
> >> and then every time when I need to change something, I will break the backwards
> >> compatibility. Is this a way to go forward?
> >
> > No, I would rather say it's an example showing why passing data
> > structures as binary data via netlink is a bad idea. I definitely
> > wouldn't advice this approach for any new interface. One of the
> > strengths of netlink is the ability to use structured and extensible
> > messages.
> >
> >> Another approach is to restructure MRP netlink interface. What I was thinking to
> >> keep the current attributes (IFLA_BRIDGE_MRP_INSTANCE,
> >> IFLA_BRIDGE_MRP_PORT_STATE,...) but they will be nested attributes and each of
> >> this attribute to contain the fields of the structures they represents.
> >> For example:
> >> [IFLA_AF_SPEC] = {
> >>     [IFLA_BRIDGE_FLAGS]
> >>     [IFLA_BRIDGE_MRP]
> >>         [IFLA_BRIDGE_MRP_INSTANCE]
> >>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
> >>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
> >>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
> >>         [IFLA_BRIDGE_MRP_RING_ROLE]
> >>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
> >>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
> >>         ...
> >> }
> >> And then I can parse each field separately and then fill up the structure
> >> (br_mrp_instance, br_mrp_port_role, ...) which will be used forward.
> >> Then when this needs to be extended with the priority it would have the
> >> following format:
> >> [IFLA_AF_SPEC] = {
> >>     [IFLA_BRIDGE_FLAGS]
> >>     [IFLA_BRIDGE_MRP]
> >>         [IFLA_BRIDGE_MRP_INSTANCE]
> >>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
> >>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
> >>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
> >>             [IFLA_BRIDGE_MRP_INSTANCE_PRIO]
> >>         [IFLA_BRIDGE_MRP_RING_ROLE]
> >>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
> >>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
> >>         ...
> >> }
> >> And also the br_mrp_instance will have a field called prio.
> >> So now, if the userspace is not updated to have support for setting the prio
> >> then the kernel will use a default value. Then if the userspace contains a field
> >> that the kernel doesn't know about, then it would just ignore it.
> >> So in this way every time when the netlink interface will be extended it would
> >> be backwards compatible.
> >
> > Silently ignoring unrecognized attributes in userspace requests is what
> > most kernel netlink based interfaces have been doing traditionally but
> > it's not really a good idea. Essentially it ties your hands so that you
> > can only add new attributes which can be silently ignored without doing
> > any harm, otherwise you risk that kernel will do something different
> > than userspace asked and userspace does not even have a way to find out
> > if the feature is supported or not. (IIRC there are even some places
> > where ignoring an attribute changes the nature of the request but it is
> > still ignored by older kernels.)
> >
> > That's why there have been an effort, mostly by Johannes Berg, to
> > introduce and promote strict checking for new netlink interfaces and new
> > attributes in existing netlink attributes. If you don't have strict
> > checking for unknown attributes enabled yet, there isn't much that can
> > be done for already released kernels but I would suggest to enable it as
> > soon as possible.
> >
> > Michal

Thanks for the detail explanation. Currently this is in net-next so I
would try to change it.
Can you point me to some code that is using this strict checking for
netlink attributes? Just to have a better understanding of it.

> >
> 
> +1, we don't have strict checking for the bridge main af spec attributes, but
> you could add that for new nested interfaces that need to be parsed like the
> above
> 
> 
> 
> 
> 
> 
> 

-- 
/Horatiu
