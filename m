Return-Path: <Allan.Nielsen@microchip.com>
Date: Mon, 27 Jan 2020 13:27:52 +0100
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200127122752.g4eanjl2naazyfh3@lx-anielsen.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
 <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
 <20200126155911.GJ18311@lunn.ch>
 <13ac391c-61f5-cb77-69a0-416b0390f50d@televic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13ac391c-61f5-cb77-69a0-416b0390f50d@televic.com>
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
To: =?utf-8?Q?J=C3=BCrgen?= Lambrecht <j.lambrecht@televic.com>
Cc: ivecera@redhat.com, Andrew Lunn <andrew@lunn.ch>, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

Hi Jürgen,

On 27.01.2020 12:29, Jürgen Lambrecht wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>On 1/26/20 4:59 PM, Andrew Lunn wrote:
>> Given the design of the protocol, if the hardware decides the OS etc
>> is dead, it should stop sending MRP_TEST frames and unblock the ports.
>> If then becomes a 'dumb switch', and for a short time there will be a
>> broadcast storm. Hopefully one of the other nodes will then take over
>> the role and block a port.

>In my experience a closed loop should never happen. It can make
>software crash and give other problems.  An other node should first
>take over before unblocking the ring ports. (If this is possible - I
>only follow this discussion halfly)
>
>What is your opinion?
Having loops in the network is never a good thing - but to be honest, I
think it is more important that we ensure the design can survive and
recover from loops.

With the current design, it will be really hard to void loops when the
network boot. MRP will actually start with the ports blocked, but they
will be unblocked in the period from when the bridge is created and
until MRP is enabled. If we want to change this (which I'm not too keen
on), then we need to be able to block the ports while the bridge is
down.

And even if we do this, then we can not guarantee to avoid loops. Lets
assume we have a small ring with just 2 nodes: a MRM and a MRC. Lets
assume the MRM boots first. It will unblock both ports as the ring is
open. Now the MRC boots, and make the ring closed, and create a loop.
This will take some time (milliseconds) before the MRM notice this and
block one of the ports.

But while we are at this topic, we need to add some functionality to
the user-space application such that it can set the priority of the MRP
frames. We will get that fixed.

>(FYI: I made that mistake once doing a proof-of-concept ring design:
>during testing, when a "broken" Ethernet cable was "fixed" I had for a
>short time a loop, and then it happened often that that port of the
>(Marvell 88E6063) switch was blocked.  (To unblock, only solution was
>to bring that port down and up again, and then all "lost" packets came
>out in a burst.) That problem was caused by flow control (with pause
>frames), and disabling flow control fixed it, but flow-control is
>default on as far as I know.)
I see. It could be fun to see if what we have proposed so far will with
with such a switch.

/Allan

