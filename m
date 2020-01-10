Return-Path: <Horatiu.Vultur@microchip.com>
Date: Fri, 10 Jan 2020 21:12:48 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200110201248.tletol7glyr4soqz@soft-dev3.microsemi.net>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
 <20200110160456.enzomhfsce7bptu3@soft-dev3.microsemi.net>
 <CA+h21hrq7U4EdqSgpYQRjK8rkcJdvD5jXCSOH_peA-R4xCocTg@mail.gmail.com>
 <20200110172536.42rdfwdc6eiwsw7m@soft-dev3.microsemi.net>
 <20200110175608.GK19739@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200110175608.GK19739@lunn.ch>
Subject: Re: [Bridge] [RFC net-next Patch 0/3] net: bridge: mrp: Add support
 for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, anirudh.venkataramanan@intel.com, Jiri Pirko <jiri@mellanox.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, David Ahern <dsahern@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>

The 01/10/2020 18:56, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > > Horatiu, could you also give some references to the frames that need
> > > to be sent. I've no idea what information they need to contain, if the
> > > contents is dynamic, or static, etc.
> > It is dynamic - but trivial...
> 
> If it is trivial, i don't see why you are so worried about abstracting
> it?
Maybe we misunderstood each other. When you asked if it is dynamic or
static, I thought you meant if it is the same frame being send repeated
or if it needs to be changed. It needs to be changed but the changes are
trivial, but it means that a non-MRP aware frame generator can't
properly offload this.

> 
> > Here is a dump from WireShark with
> > annotation on what our HW can update:
> >
> > Ethernet II, Src: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1), Dst: Iec_00:00:01 (01:15:4e:00:00:01)
> >     Destination: Iec_00:00:01 (01:15:4e:00:00:01)
> >     Source: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1)
> >     Type: MRP (0x88e3)
> > PROFINET MRP MRP_Test, MRP_Common, MRP_End
> >     MRP_Version: 1
> >     MRP_TLVHeader.Type: MRP_Test (0x02)
> >         MRP_TLVHeader.Type: MRP_Test (0x02)
> >         MRP_TLVHeader.Length: 18
> >         MRP_Prio: 0x1f40 High priorities
> >         MRP_SA: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1)
> >         MRP_PortRole: Primary ring port (0x0000)
> >         MRP_RingState: Ring closed (0x0001)
> >         MRP_Transition: 0x0001
> >         MRP_TimeStamp [ms]: 0x000cf574             <---------- Updated automatic
> >     MRP_TLVHeader.Type: MRP_Common (0x01)
> >         MRP_TLVHeader.Type: MRP_Common (0x01)
> >         MRP_TLVHeader.Length: 18
> >         MRP_SequenceID: 0x00e9                     <---------- Updated automatic
> >         MRP_DomainUUID: ffffffff-ffff-ffff-ffff-ffffffffffff
> >     MRP_TLVHeader.Type: MRP_End (0x00)
> >         MRP_TLVHeader.Type: MRP_End (0x00)
> >         MRP_TLVHeader.Length: 0
> >
> > But all the fields can change, but to change the other fields we need to
> > interact with the HW. Other SoC may have other capabilities in their
> > offload. As an example, if the ring becomes open then the fields
> > MRP_RingState and MRP_Transition need to change and in our case this
> > requires SW interference.
> 
> Isn't SW always required? You need to tell your state machine that the
> state has changed.
In the manager role(MRM), SW is always required. The client can be
implemented simply by limiting the flood-mask of the L2 multicast MAC
used.

The auto and the interconnect roles also required SW to drive the
protocol. These roles are not part of this patch set.

> 
> > Would you like a PCAP file as an example? Or do you want a better
> > description of the frame format.
> 
> I was hoping for a link to an RFC, or some standards document.
Yeah, I would love to have that as well... Unfortunately this is
standardized by IEC, and the standards are not free.
It can be bought here: https://webstore.iec.ch/publication/24434

Due to the copyright/license of the PDF, I'm not allowed to give you a
copy of the one I have.

> 
>   Andrew

-- 
/Horatiu
