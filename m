Return-Path: <Allan.Nielsen@microchip.com>
Date: Tue, 28 Jan 2020 11:17:04 +0100
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200128101704.kjqok4lvpgo73pzz@lx-anielsen.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-10-horatiu.vultur@microchip.com>
 <20200125161615.GD18311@lunn.ch>
 <20200126130111.o75gskwe2fmfd4g5@soft-dev3.microsemi.net>
 <20200126171251.GK18311@lunn.ch>
 <20200127105746.i2txggfnql4povje@lx-anielsen.microsemi.net>
 <20200127134053.GG12816@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200127134053.GG12816@lunn.ch>
Subject: Re: [Bridge] [RFC net-next v3 09/10] net: bridge: mrp: Integrate
 MRP into the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 27.01.2020 14:40, Andrew Lunn wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>> > 'Thinking allowed' here.
>> >
>> >     +------------------------------------------+
>> >     |                                          |
>> >     +-->|H1|<---------->|H2|<---------->|H3|<--+
>> >     eth0    eth1    eth0    eth1    eth0    eth1
>> >      ^
>> >      |
>> >   Blocked
>> >
>> >
>> > There are three major classes of user case here:
>> >
>> > 1) Pure software solution
>> > You need the software bridge in the client to forward these frames
>> > from the left side to the right side.
>
>> As far as I understand it is not the bridge which forward these frames -
>> it is the user-space tool. This was to put as much functionality in
>> user-space and only use the kernel to configure the HW. We can (and
>> should) discuss if this is the right decision.
>
>So i need to flip the point around. How does the software switch know
>not to forward the frames? Are you adding an MDB?
In the current implementation (patch v3) this is done here:
https://github.com/microchip-ung/mrp/blob/patch-v3/kernel-patches/v3-0009-net-bridge-mrp-Integrate-MRP-into-the-bridge.patch#L112

We simply ask the bridge not to forward any MRP frames, on MRP enabled
ports, and let "someone" else do that.

>> We would properly have better performance if we do this in kernel-space.
>
>Yes, that is what i think. And if you can do it without any additional
>code, using the forwarding tables, so much the better.
I understand the motivation of using the existing forwarding mechanism,
but I do not think we have all the hooks needed. But we can certainly
limit the impact on the existing code as much as possible.

>> BTW: It is not only from left to right, it is also from right to left.
>> The MRM will inject packets on both ring ports, and monitor both.
>
>Using the same MAC address in both directions? I need to think what
>that implies for MDB entries. It probably just works, since you never
>flood back out the ingress port.
Seems to work fine :-D

>> Again, I do not know how other HW is designed, but all the SOC's we are
>> working with, does allow us to add a TCAM rule which can redirect these
>> frames to the CPU even on a blocked port.
>
>It is not in scope for what you are doing, but i wonder how we
>describe this in a generic Linux way? And then how we push it down to
>the hardware?
>
>For the Marvell Switches, it might be possible to do this without the
>TCAM. You can add forwarding DB entries marked as Management. It is
>unclear if this overrides the blocked state, but it would be a bit odd
>if it did not.
Based on this, and also on the input from Jürgen, I think there is a
good chnage we can make this work for existing silicon from several
vendors.

>> > You could avoid this by adding MDB entries to the bridge. However,
>> > this does not scale to more then one ring.
>> I would prefer a solution where the individual drivers can do what is
>> best on the given HW.
>The nice thing about adding MDB is that it is making use of the
>software bridge facilities. In general, the software bridge and
>hardware bridges are pretty similar. If you can solve the problem
>using generic software bridge features, not additional special cases
>in code, you have good chance of being able to offload it to a
>hardware bridge which is not MRP aware. The switchdev API for MRP
>specific features should then allow you to make use of any additional
>features the hardware might have.
Yes, but the issues in using the MDB API for this is that it does not
allow to look at source ports, and it does not allow to update the
priority of the frames.

>> Yes, the solution Horatiu has chosen, is not to forward MRP frames,
>> received in MRP ring ports at all. This is done by the user-space tool.
>>
>> Again, not sure if this is the right way to do it, but it is what patch
>> v3 does.
>>
>> The alternative to this would be to learn the bridge how to forward MRP
>> frames when it is a MRC. The user-space tool then never needs to do
>> this, it know that the kernel will take care of this part (either in SW
>> or in HW).
>I think that should be considered. I'm not saying it is the best way,
>just that some thought should be put into it to figure out what it
>actually implies.
Sounds good - I will try to explain and illustrate this a bit better,
such that we all have the same understanding of the problem we need to
solve.

/Allan

