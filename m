Return-Path: <Horatiu.Vultur@microchip.com>
Date: Fri, 10 Jan 2020 18:25:36 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200110172536.42rdfwdc6eiwsw7m@soft-dev3.microsemi.net>
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <6f1936e9-97e5-9502-f062-f2925c9652c9@cumulusnetworks.com>
 <20200110160456.enzomhfsce7bptu3@soft-dev3.microsemi.net>
 <CA+h21hrq7U4EdqSgpYQRjK8rkcJdvD5jXCSOH_peA-R4xCocTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CA+h21hrq7U4EdqSgpYQRjK8rkcJdvD5jXCSOH_peA-R4xCocTg@mail.gmail.com>
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <jakub.kicinski@netronome.com>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>, Vivien Didelot <vivien.didelot@gmail.com>, anirudh.venkataramanan@intel.com, Jiri Pirko <jiri@mellanox.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, David Ahern <dsahern@gmail.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>


Hi Valdimir and Andrew

The 01/10/2020 18:21, Vladimir Oltean wrote:
> I think it would help your case if you explained a bit more about the
> hw offload primitives you have implemented internally. I believe you
> are talking about the frame generation engine in the Ocelot switch
> which has 1024 frame slots that are periodically sent based on one of
> 8 timers. For receive, I believe that the functionality is to offload
> the consumption of these periodic frames, and just raise an interrupt
> if frames were expected but not received.
Yes something like this. But it is worth mention that it is not just about
injecting frames, sequence number needs to be incremented (by HW) etc.

> For your use case of MRP, it makes perfect sense to have this. I am
> just not sure (and not knowledgeable enough in Linux) what this engine
> is offloading from the operating system's perspective.
We will try to make that more clear.

> Your justification for implementing MRP in the kernel seems to be that
> it's better to make MRP part of the kernel uapi than a configuration
> interface for your periodic engine, which in principle I agree with.
> I'm just not sure if the offload that you propose will have a trivial
> path into the kernel either, so it would make sense for reviewers to
> see everything put together first.
You are right. The decision of start by publishing a pure SW implementation with
no HW offload was not the best.

I can do a new RFC that does including the HW offload hooks, and
describe what configurations we do when these hooks are called. The
actual HW which implements these hooks is still not released (and the
SwitchDev driver for this device is still not submitted).

> Horatiu, could you also give some references to the frames that need
> to be sent. I've no idea what information they need to contain, if the
> contents is dynamic, or static, etc.
It is dynamic - but trivial... Here is a dump from WireShark with
annotation on what our HW can update:

Ethernet II, Src: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1), Dst: Iec_00:00:01 (01:15:4e:00:00:01)
    Destination: Iec_00:00:01 (01:15:4e:00:00:01)
    Source: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1)
    Type: MRP (0x88e3)
PROFINET MRP MRP_Test, MRP_Common, MRP_End
    MRP_Version: 1
    MRP_TLVHeader.Type: MRP_Test (0x02)
        MRP_TLVHeader.Type: MRP_Test (0x02)
        MRP_TLVHeader.Length: 18
        MRP_Prio: 0x1f40 High priorities
        MRP_SA: 7a:8b:b1:35:96:e1 (7a:8b:b1:35:96:e1)
        MRP_PortRole: Primary ring port (0x0000)
        MRP_RingState: Ring closed (0x0001)
        MRP_Transition: 0x0001
        MRP_TimeStamp [ms]: 0x000cf574             <---------- Updated automatic
    MRP_TLVHeader.Type: MRP_Common (0x01)
        MRP_TLVHeader.Type: MRP_Common (0x01)
        MRP_TLVHeader.Length: 18
        MRP_SequenceID: 0x00e9                     <---------- Updated automatic
        MRP_DomainUUID: ffffffff-ffff-ffff-ffff-ffffffffffff
    MRP_TLVHeader.Type: MRP_End (0x00)
        MRP_TLVHeader.Type: MRP_End (0x00)
        MRP_TLVHeader.Length: 0

But all the fields can change, but to change the other fields we need to
interact with the HW. Other SoC may have other capabilities in their
offload. As an example, if the ring becomes open then the fields
MRP_RingState and MRP_Transition need to change and in our case this
requires SW interference.

Would you like a PCAP file as an example? Or do you want a better
description of the frame format.

/Horatiu
