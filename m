Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=/f/vIuylKKylp8vtsSZdPFZggdY5dfXSPr0mYTXw5VM=;
 b=oQNUOGia68c5tCZGNaNknD2FAFM3InFMHF9rKt1itm1BuPnGrsfRv1cS4KUJJb3syu
 NAxbLi1nhfKVm/qDIbigK8DARbG+q1d974u6TZlBvztfBnB0XqR1o65zV4Gc6xxk6B1L
 oJ8rVztnu1zbeGIlJysDg242GFSUUWtgu272CmCj2KHq5IwjwCA8MWQ8bQ+3yimO7U7N
 apyjOp1NIbVgEFQGZhKQd8magZt3rd2tlGhmakdknncJlqnBhoEnv3NB9I3qP86TZjAk
 V26Uq+OpzKUJSDQPJaSE6Ugxgx3olPBBmGPSL9lh8prjk1LEMPqf92Q2Waghc+lO64SX
 Pwqw==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220308171717.s2hqp6raoe5gcgtl@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301100321.951175-5-tobias@waldekranz.com>
 <20220303205921.sxb52jzw4jcdj6m7@skbuf> <87y21kna9r.fsf@waldekranz.com>
 <20220308171717.s2hqp6raoe5gcgtl@skbuf>
Date: Wed, 09 Mar 2022 16:34:18 +0100
Message-ID: <87sfrrm96t.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 04/10] net: bridge: mst: Notify
 switchdev drivers of VLAN MSTI migrations
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 19:17, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 08, 2022 at 09:01:04AM +0100, Tobias Waldekranz wrote:
>> On Thu, Mar 03, 2022 at 22:59, Vladimir Oltean <olteanv@gmail.com> wrote:
>> > On Tue, Mar 01, 2022 at 11:03:15AM +0100, Tobias Waldekranz wrote:
>> >> Whenever a VLAN moves to a new MSTI, send a switchdev notification so
>> >> that switchdevs can...
>> >> 
>> >> ...either refuse the migration if the hardware does not support
>> >> offloading of MST...
>> >> 
>> >> ..or track a bridge's VID to MSTI mapping when offloading is
>> >> supported.
>> >> 
>> >> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> >> ---
>> >>  include/net/switchdev.h   | 10 +++++++
>> >>  net/bridge/br_mst.c       | 15 +++++++++++
>> >>  net/bridge/br_switchdev.c | 57 +++++++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 82 insertions(+)
>> >> 
>> >> diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>> >> index 3e424d40fae3..39e57aa5005a 100644
>> >> --- a/include/net/switchdev.h
>> >> +++ b/include/net/switchdev.h
>> >> @@ -28,6 +28,7 @@ enum switchdev_attr_id {
>> >>  	SWITCHDEV_ATTR_ID_BRIDGE_MC_DISABLED,
>> >>  	SWITCHDEV_ATTR_ID_BRIDGE_MROUTER,
>> >>  	SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
>> >> +	SWITCHDEV_ATTR_ID_VLAN_MSTI,
>> >>  };
>> >>  
>> >>  struct switchdev_brport_flags {
>> >> @@ -35,6 +36,14 @@ struct switchdev_brport_flags {
>> >>  	unsigned long mask;
>> >>  };
>> >>  
>> >> +struct switchdev_vlan_attr {
>> >> +	u16 vid;
>> >> +
>> >> +	union {
>> >> +		u16 msti;
>> >> +	};
>> >
>> > Do you see other VLAN attributes that would be added in the future, such
>> > as to justify making this a single-element union from the get-go?
>> 
>> I could imagine being able to control things like multicast snooping on
>> a per-VLAN basis. Being able to act as a multicast router in one VLAN
>> but not another.
>> 
>> > Anyway if that is the case, we're lacking an id for the attribute type,
>> > so we'd end up needing to change drivers when a second union element
>> > appears. Otherwise they'd all expect an u16 msti.
>> 
>> My idea was that `enum switchdev_attr_id` would hold all of that
>> information. In this example SWITCHDEV_ATTR_ID_VLAN_MSTI, denotes both
>> that `vlan_attr` is the valid member of `u` and that `msti` is the valid
>> member of `vlan_attr`. If we add SWITCHDEV_ATTR_ID_VLAN_SNOOPING, that
>> would point to both `vlan_attr` and a new `bool snooping` in the union.
>> 
>> Do you think we should just have a SWITCHDEV_ATTR_ID_VLAN_ATTR for all
>> per-VLAN attributes and then have a separate union?
>
> It's the first nested union that I see, and a bit confusing.
>
> I think it would be better if we had a
>
> struct switchdev_vlan_attr_msti {
> 	u16 vid;
> 	u16 msti;
> };
>
> and different structures for other, future VLAN attributes. Basically
> keep a 1:1 mapping between an attribute id and a union.

Yeah, I like the simplicity of that. Changing.

>> >> +};
>> >> +
>> >>  struct switchdev_attr {
>> >>  	struct net_device *orig_dev;
>> >>  	enum switchdev_attr_id id;
>> >> @@ -50,6 +59,7 @@ struct switchdev_attr {
>> >>  		u16 vlan_protocol;			/* BRIDGE_VLAN_PROTOCOL */
>> >>  		bool mc_disabled;			/* MC_DISABLED */
>> >>  		u8 mrp_port_role;			/* MRP_PORT_ROLE */
>> >> +		struct switchdev_vlan_attr vlan_attr;	/* VLAN_* */
>> >>  	} u;
>> >>  };
>> >>  
>> >> diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
>> >> index 8dea8e7257fd..aba603675165 100644
>> >> --- a/net/bridge/br_mst.c
>> >> +++ b/net/bridge/br_mst.c
>> >> @@ -7,6 +7,7 @@
>> >>   */
>> >>  
>> >>  #include <linux/kernel.h>
>> >> +#include <net/switchdev.h>
>> >>  
>> >>  #include "br_private.h"
>> >>  
>> >> @@ -65,9 +66,23 @@ static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
>> >>  
>> >>  int br_mst_vlan_set_msti(struct net_bridge_vlan *mv, u16 msti)
>> >>  {
>> >> +	struct switchdev_attr attr = {
>> >> +		.id = SWITCHDEV_ATTR_ID_VLAN_MSTI,
>> >> +		.flags = SWITCHDEV_F_DEFER,
>> >
>> > Is the bridge spinlock held (atomic context), or otherwise why is
>> > SWITCHDEV_F_DEFER needed here?
>> 
>> Nope, just copypasta. In fact, it shouldn't be needed when setting the
>> state either, as you can only change the state via a netlink message. I
>> will remove it.
>> 
>> >> +		.orig_dev = mv->br->dev,
>> >> +		.u.vlan_attr = {
>> >> +			.vid = mv->vid,
>> >> +			.msti = msti,
>> >> +		},
>> >> +	};
>> >>  	struct net_bridge_vlan_group *vg;
>> >>  	struct net_bridge_vlan *pv;
>> >>  	struct net_bridge_port *p;
>> >> +	int err;
>> >> +
>> >> +	err = switchdev_port_attr_set(mv->br->dev, &attr, NULL);
>> >
>> > Treating a "VLAN attribute" as a "port attribute of the bridge" is
>> > pushing the taxonomy just a little, but I don't have a better suggestion.
>> 
>> Isn't there prior art here? I thought things like VLAN filtering already
>> worked like this?
>
> Hmm, I can think of VLAN filtering as being an attribute of the bridge
> device, but 'which MSTI does VLAN X belong to' is an attribute of the
> VLAN (in itself a switchdev object, i.e. something countable).
>
> If the prior art would apply as straightforward as you say, then we'd be
> replaying the VLAN MSTIs together with the other port attributes - in
> "pull" mode, in dsa_port_switchdev_sync_attrs(), rather than in "push"
> mode with the rest of the objects - in nbp_switchdev_sync_objs().
> But we're not doing that.
>
> To prove that there is a difference between VLAN filtering as a port
> property of the bridge device, and VLAN MSTIs (or other per-VLAN global
> bridge options), consider this.
> You create a bridge, add 10 VLANs on br0, enable VLAN filtering, then
> delete the 10 VLANs and re-create them. The bridge is still VLAN
> filtering.
> So VLAN filtering is a property of the bridge.
>
> Next you create a bridge, add 10 VLANs on br0, run your new command:
> 'bridge vlan global set dev br0 vid <VID> msti <MSTI>'
> then delete the 10 VLANs and create them back.
> Their MSTI is 0, not what was set via the bridge vlan global options...
> Because the MSTI is a property of the VLANs, not of the bridge.
>
> A real port attribute wouldn't behave like that.
>
> At least this is what I understand from your patch set, I haven't run it;
> sorry if I'm mistaken about something, but I can't find a clearer way to
> express what I find strange.
>
> Anyway, I'll stop uselessly commenting here - I can understand the
> practical reasons why you wouldn't want to bother expanding the taxonomy
> to describe this for what it really is - an "object attribute" of sorts -
> because a port attribute for the bridge device has the call path you
> need already laid out, including replication towards all bridge ports.

I yield, I yield! :)
