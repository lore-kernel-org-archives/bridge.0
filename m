Return-Path: <Horatiu.Vultur@microchip.com>
Date: Sun, 26 Jan 2020 14:39:05 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200126133905.wzsvdsdvkc32dd4k@soft-dev3.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-5-horatiu.vultur@microchip.com>
 <20200125153403.GB18311@lunn.ch>
 <20200125192854.yi544iu2atvbbwey@lx-anielsen.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200125192854.yi544iu2atvbbwey@lx-anielsen.microsemi.net>
Subject: Re: [Bridge] [RFC net-next v3 04/10] net: bridge: mrp: Add generic
 netlink interface to configure MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc: ivecera@redhat.com, Andrew Lunn <andrew@lunn.ch>, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

Hi,
The 01/25/2020 20:28, Allan W. Nielsen wrote:
> On 25.01.2020 16:34, Andrew Lunn wrote:
> > On Fri, Jan 24, 2020 at 05:18:22PM +0100, Horatiu Vultur wrote:
> > > Implement the generic netlink interface to configure MRP. The implementation
> > > will do sanity checks over the attributes and then eventually call the MRP
> > > interface which eventually will call the switchdev API.
> > What was your thinking between adding a new generic netlink interface,
> > and extending the current one?
I thought is more clear to see which commands are used to configure MRP
by adding a new generic netlink than extending the existing one.

> > 
> > I've not looked at your user space code yet, but i assume it has to
> > make use of both? It needs to create the bridge and add the
> > interfaces. And then it needs to control the MRP state.
Actually the userspace application doesn't create the bridge and add the
interfaces. It expects that user does this using iproute2 or other
commands.
And once the bridge and interfaces are added then it would just
configure the bridge.

> > 
> > Allan mentioned you might get around to implementing 802.1CB? Would
> > that be another generic netlink interface, or would you extend the MRP
> > interface?
> Horatiu, if you have given this any thoughts, then please share them.
I have not look yet over this, I will try to have a look ASAP.

> 
> Here are my thoughts on 802.1CB: If we look at this with the traditional
> NIC/host POW, then it would be natural to look at the HSR interface as
> Vinicius suggested, and expose it as a new interface (HSR0). But when
> looking at how 802.1CB say a bridge should act, and also what the
> capabilities of the HW are, then it seem more natural to extend the TC
> system. In HW it is a TCAM classifying the traffic, and it has some
> actions to either replicate the matched frames, or eliminate the
> additional copies.
> 
> The HW also supports CFM (see [1]), which we need (partly) to complete
> the MRP implementation with MIM/MIC roles. This is also useful for none
> MRP users (like ERPS).
> 
> This seems like an argument for moving this to the existing netlink
> interfaces instead of having it as a generic netlink.
> 
> [1] https://en.wikipedia.org/wiki/IEEE_802.1ag
> 
> /Allan

-- 
/Horatiu
