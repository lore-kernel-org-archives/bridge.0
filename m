Return-Path: <Horatiu.Vultur@microchip.com>
Date: Mon, 13 Jan 2020 23:57:51 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200113225751.jkkio4rztyuff4xj@soft-dev3.microsemi.net>
References: <20200113124620.18657-1-horatiu.vultur@microchip.com>
 <20200113124620.18657-5-horatiu.vultur@microchip.com>
 <20200113140053.GE11788@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200113140053.GE11788@lunn.ch>
Subject: Re: [Bridge] [RFC net-next Patch v2 4/4] net: bridge: mrp:
 switchdev: Add HW offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jakub.kicinski@netronome.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, dsahern@gmail.com, jiri@resnulli.us, olteanv@gmail.com, davem@davemloft.net

The 01/13/2020 15:00, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Mon, Jan 13, 2020 at 01:46:20PM +0100, Horatiu Vultur wrote:
> > +#ifdef CONFIG_BRIDGE_MRP
> > +/* SWITCHDEV_OBJ_ID_PORT_MRP */
> > +struct switchdev_obj_port_mrp {
> > +     struct switchdev_obj obj;
> > +     struct net_device *port;
> > +     u32 ring_nr;
> > +};
> > +
> > +#define SWITCHDEV_OBJ_PORT_MRP(OBJ) \
> > +     container_of((OBJ), struct switchdev_obj_port_mrp, obj)
> > +
> > +/* SWITCHDEV_OBJ_ID_RING_TEST_MRP */
> > +struct switchdev_obj_ring_test_mrp {
> > +     struct switchdev_obj obj;
> > +     /* The value is in us and a value of 0 represents to stop */
> > +     u32 interval;
> > +     u8 max;
> > +     u32 ring_nr;
> > +};
> > +
> > +#define SWITCHDEV_OBJ_RING_TEST_MRP(OBJ) \
> > +     container_of((OBJ), struct switchdev_obj_ring_test_mrp, obj)
> > +
> > +/* SWITCHDEV_OBJ_ID_RING_ROLE_MRP */
> > +struct switchdev_obj_ring_role_mrp {
> > +     struct switchdev_obj obj;
> > +     u8 ring_role;
> > +     u32 ring_nr;
> > +};
> 
> Hi Horatiu
> 
> The structures above should give me enough information to build this,
> correct?

Hi Andrew,

You will need also these attributes to build a minimum MRP_Test frame:
SWITCHDEV_ATTR_ID_MRP_PORT_STATE,
SWITCHDEV_ATTR_ID_MRP_PORT_ROLE,
SWITCHDEV_ATTR_ID_MRP_RING_STATE,
SWITCHDEV_ATTR_ID_MRP_RING_TRANS,

> 
> Ethernet II, Src: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1), Dst: Iec_00:00:01 (01:15:4e:00:00:01)
>     Destination: Iec_00:00:01 (01:15:4e:00:00:01)
>     Source: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1)
>     Type: MRP (0x88e3)
> PROFINET MRP MRP_Test, MRP_Common, MRP_End
>     MRP_Version: 1
>     MRP_TLVHeader.Type: MRP_Test (0x02)
>         MRP_TLVHeader.Type: MRP_Test (0x02)
>         MRP_TLVHeader.Length: 18
>         MRP_Prio: 0x1f40 High priorities
>         MRP_SA: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1)
>         MRP_PortRole: Primary ring port (0x0000)
>         MRP_RingState: Ring closed (0x0001)
>         MRP_Transition: 0x0001
>         MRP_TimeStamp [ms]: 0x000cf574             <---------- Updated automatic
>     MRP_TLVHeader.Type: MRP_Common (0x01)
>         MRP_TLVHeader.Type: MRP_Common (0x01)
>         MRP_TLVHeader.Length: 18
>         MRP_SequenceID: 0x00e9                     <---------- Updated automatic
>         MRP_DomainUUID: ffffffff-ffff-ffff-ffff-ffffffffffff
>     MRP_TLVHeader.Type: MRP_End (0x00)
>         MRP_TLVHeader.Type: MRP_End (0x00)
>         MRP_TLVHeader.Length: 0
> 
> There are a couple of fields i don't see. MRP_SA, MRP_Transition.

Regarding the MRP_SA, which represents the bridge MAC address, we could
get this information from listening to the notifications in the driver.
So I don't think we need a special call for this.

The same could be for MRP_Transition, which counts the number of times
the ring goes in open state. In theory we could get information by
counting in the driver how many times the ring gets in the open state.
And we get this information through the attribute
SWITCHDEV_ATTR_ID_MRP_RING_STATE.

The other fields that are missing are MRP_Prio and MRP_DomainUUID. But
these values could be set to a default values for now because they are
used by MRA(Media Redundancy Auto-manager), which is not part of this
patch series.

> 
> What are max and ring_nr used for?

The max represents the number of MRP_Test frames that can be missed
by receiver before it declares the ring open. For example if the
receiver expects a MRP_Frame every 10ms and it sets the max to 3. Then
it means that if it didn't receive a frame in 30ms, it would set that
the port didn't receive MRP_Test.
The ring_nr represents the ID of the MRP instance. For example, on a
switch which has 8 ports, there can be 4 MRP instances. Because each
instance requires 2 ports. And to be able to differences them, each
instance has it's own ID, which is this ring_nr.

> 
> Do you need to set the first value MRP_SequenceID uses? Often, in
> order to detect a reset, a random value is used to initialise the
> sequence number. Also, does the time stamp need initializing?

I couldn't see in the standard if they required an initial for
MRP_SequenceID. From what I have seen on some switches that have their
own MRP implementation, they set the initial value of MRP_SequenceID to
0 and they increase for it frame.
Regarding the timestamp, again the standard doesn't say anything about
initial value. This timestamp is used by MRM to determine the maximum
travel time of the MRP_Test frames in a ring.
> 
> Thanks
>         Andrew

-- 
/Horatiu
