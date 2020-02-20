Return-Path: <Allan.Nielsen@microchip.com>
Date: Thu, 20 Feb 2020 13:58:00 +0100
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200220125800.c3qyc4wxtdt6hv4b@lx-anielsen.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200218121811.xo3o6zzrhl5p3j2s@lx-anielsen.microsemi.net>
 <3afba55f-f953-7aaa-8425-14777db1b27d@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <3afba55f-f953-7aaa-8425-14777db1b27d@cumulusnetworks.com>
Subject: Re: [Bridge] [RFC net-next v3 00/10] net: bridge: mrp: Add support
 for Media Redundancy Protocol (MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: ivecera@redhat.com, andrew@lunn.ch, jiri@resnulli.us, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

Hi Nik,

On 20.02.2020 12:48, Nikolay Aleksandrov wrote:
> In light of all the discussions and details that were explained, and as you've
> noted above, I think more code should be put in kernel space at the very least
> the performance/latency critical parts would benefit from being executed in the
> kernel (kind of control/data-plane separation). It seems from the switchdev calls there's
> a minimal state working set which define the behaviour and can be used to make
> decisions (similar to STP) in the kernel, but the complex logic how to set them can be
> executed in user-space meaning that maybe these hw-offload calls can have a simple SW
> fallback logic based on their current values. I think it is worth considering if this can
> be achieved before going to full in-kernel implementation of the state machine.
> Since you intend to hw-offload it then putting in some SW fallback logic would be good
> when the HW can't offload everything, what you suggest above also sounds good to me and
> I think you'll have to extend mdb and the multicast code to do it, but IIRC you already
> have code to do that based on previous discussions.
Sounds good. We will continue working on defining a good control/data-plane separation
and only keep the data-plane in the kernel. Also it seems that we agree that the SW fallback
of the data-plane should stay in the kernel - we will do that.

> As was already suggested you can put the MRP options in the bridge's options and
> process them from the bridge netlink code, that should simplify your code.
I'm okay with this.

The main argument I see for creating a seperate MRP netlink interface
instead of extending the bridge, is that MRP is properly not the last
bridge protocol we will want to work on.

To complete the MRP-2018 implementation, we will also need some CFM
support (defined in 802.1Qag or the latest version of 802.1Q). And
furhter out we will properly want to implement the full CFM protocol.

DLR may also be relevant at some point, and there may be other.

My main point is, that at some point we will properly want to do
seperate NETLINK interfaces for this. Not sure if that is now or later.

> You could also make the port's "mrp_aware" bool into an internal port
> flag (use net_bridge_port's flags field) so it can be quickly tested
> and in a hot cache line.
Good point, we will do that.

/Allan
