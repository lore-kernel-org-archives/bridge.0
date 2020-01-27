Return-Path: <Allan.Nielsen@microchip.com>
Date: Mon, 27 Jan 2020 12:04:18 +0100
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200127110418.f7443ecls6ih2fwt@lx-anielsen.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
 <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
 <20200126155911.GJ18311@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20200126155911.GJ18311@lunn.ch>
Subject: Re: [Bridge] [RFC net-next v3 06/10] net: bridge: mrp: switchdev:
 Extend switchdev API to offload MRP
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

On 26.01.2020 16:59, Andrew Lunn wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>On Sun, Jan 26, 2020 at 02:22:13PM +0100, Horatiu Vultur wrote:
>> The 01/25/2020 17:35, Andrew Lunn wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> >
>> > > SWITCHDEV_OBJ_ID_RING_TEST_MRP: This is used when to start/stop sending
>> > >   MRP_Test frames on the mrp ring ports. This is called only on nodes that have
>> > >   the role Media Redundancy Manager.
>> >
>> > How do you handle the 'headless chicken' scenario? User space tells
>> > the port to start sending MRP_Test frames. It then dies. The hardware
>> > continues sending these messages, and the neighbours thinks everything
>> > is O.K, but in reality the state machine is dead, and when the ring
>> > breaks, the daemon is not there to fix it?
I agree, we need to find a solution to this issue.

>> > And it is not just the daemon that could die. The kernel could opps or
>> > deadlock, etc.
>> >
>> > For a robust design, it seems like SWITCHDEV_OBJ_ID_RING_TEST_MRP
>> > should mean: start sending MRP_Test frames for the next X seconds, and
>> > then stop. And the request is repeated every X-1 seconds.
Sounds like a good idea to me.

>> I totally missed this case, I will update this as you suggest.
>
>What does your hardware actually provide?
>
>Given the design of the protocol, if the hardware decides the OS etc
>is dead, it should stop sending MRP_TEST frames and unblock the ports.
>If then becomes a 'dumb switch', and for a short time there will be a
>broadcast storm. Hopefully one of the other nodes will then take over
>the role and block a port.
As far as I know, the only feature HW has to prevent this is a
watch-dog timer. Which will reset the entire system (not a bad idea if
the kernel has dead-locked).

/Allan

