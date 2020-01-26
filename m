Return-Path: <Horatiu.Vultur@microchip.com>
Date: Sun, 26 Jan 2020 14:22:13 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200126132213.fmxl5mgol5qauwym@soft-dev3.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
 <20200125163504.GF18311@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200125163504.GF18311@lunn.ch>
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
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

The 01/25/2020 17:35, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> > SWITCHDEV_OBJ_ID_RING_TEST_MRP: This is used when to start/stop sending
> >   MRP_Test frames on the mrp ring ports. This is called only on nodes that have
> >   the role Media Redundancy Manager.
> 
> How do you handle the 'headless chicken' scenario? User space tells
> the port to start sending MRP_Test frames. It then dies. The hardware
> continues sending these messages, and the neighbours thinks everything
> is O.K, but in reality the state machine is dead, and when the ring
> breaks, the daemon is not there to fix it?
> 
> And it is not just the daemon that could die. The kernel could opps or
> deadlock, etc.
> 
> For a robust design, it seems like SWITCHDEV_OBJ_ID_RING_TEST_MRP
> should mean: start sending MRP_Test frames for the next X seconds, and
> then stop. And the request is repeated every X-1 seconds.

I totally missed this case, I will update this as you suggest.

> 
>      Andrew

-- 
/Horatiu
