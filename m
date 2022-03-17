Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oXxajodOegFpu3qLtW7meKAMsmhaC7A4cIBe9jeyyy8=;
 b=T1CXfgoLZaxde5dXFF4LTNE2qLUFot42LriRrOoKQgCswwyNCHb6anbnIZ/6Gvsqb4
 vmwMIhiVo7o5dlgWLclkHWo/VuqWp19QoWTUmVOdLyIxFs2qubQmR/wJrqOAKwyizCL+
 GGzDyV6Y04zs11XcJL8FLm0IQ9NUA3LGAErmZxba7krGizP2TtvcI4V+tiiAnL/g+7W0
 d+8z/Secp8G0iFoukRBbcCkDVfxNZCfccCC9S8ASJzhefj5KjNmOHKTUnNxGoP4ngWZF
 r3cuM+OGw1wWW+5g6LlM+EWzfDWy9Hebr25O9RlbPEtwvSJuDR9VyCV6u6zY+YSfZRsA
 Nm7w==
Date: Thu, 17 Mar 2022 20:42:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220317184204.wehqmziioscdz33t@skbuf>
References: <20220310142320.611738-1-schultz.hans+netdev@gmail.com>
 <f9b3ecf5-c2a4-3a7a-5d19-1dbeae5acb69@gmail.com>
 <86o825htih.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o825htih.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 0/3] Extend locked port feature with
 FDB locked flag (MAC-Auth/MAB)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, davem@davemloft.net

On Thu, Mar 17, 2022 at 09:29:10AM +0100, Hans Schultz wrote:
> On ons, mar 16, 2022 at 17:18, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > On 3/10/2022 6:23 AM, Hans Schultz wrote:
> >> This patch set extends the locked port feature for devices
> >> that are behind a locked port, but do not have the ability to
> >> authorize themselves as a supplicant using IEEE 802.1X.
> >> Such devices can be printers, meters or anything related to
> >> fixed installations. Instead of 802.1X authorization, devices
> >> can get access based on their MAC addresses being whitelisted.
> >> 
> >> For an authorization daemon to detect that a device is trying
> >> to get access through a locked port, the bridge will add the
> >> MAC address of the device to the FDB with a locked flag to it.
> >> Thus the authorization daemon can catch the FDB add event and
> >> check if the MAC address is in the whitelist and if so replace
> >> the FDB entry without the locked flag enabled, and thus open
> >> the port for the device.
> >> 
> >> This feature is known as MAC-Auth or MAC Authentication Bypass
> >> (MAB) in Cisco terminology, where the full MAB concept involves
> >> additional Cisco infrastructure for authorization. There is no
> >> real authentication process, as the MAC address of the device
> >> is the only input the authorization daemon, in the general
> >> case, has to base the decision if to unlock the port or not.
> >> 
> >> With this patch set, an implementation of the offloaded case is
> >> supplied for the mv88e6xxx driver. When a packet ingresses on
> >> a locked port, an ATU miss violation event will occur. When
> >> handling such ATU miss violation interrupts, the MAC address of
> >> the device is added to the FDB with a zero destination port
> >> vector (DPV) and the MAC address is communicated through the
> >> switchdev layer to the bridge, so that a FDB entry with the
> >> locked flag enabled can be added.
> >
> > FWIW, we may have about a 30% - 70% split between switches that will 
> > signal ATU violations over a side band interrupt, like mv88e6xxx will, 
> > and the rest will likely signal such events via the proprietary tag
> > format.
> 
> I guess that the proprietary tag scheme a scenario where the packet can
> be forwarded to the bridge module's ingress queue on the respective
> port?

I'm not sure what you mean by forwarding to the bridge module's ingress
queue. I expect that both cases of drivers to interact with the bridge
in the exact same way, expect one of them calls call_switchdev_notifiers()
from an interrupt context, and the other from NET_RX softirq context,
from the tagging protocol driver (ok, maybe not directly, it depends
upon whether we need rtnl_lock which sleeps, things like that).

I might be just projecting based on what I know, but the way I interpret
what Florian has said is by thinking of "learn frames" as described here:
https://patchwork.kernel.org/project/netdevbpf/cover/20220209130538.533699-1-schultz.hans+netdev@gmail.com/#24734685
The advantage of signaling ATU misses or membership violations via learn
frames is that you have a much wider toolbox of mitigations for denial
of service. Instead of one ATU interrupt per packet, you have NAPI on
the DSA master, interrupt coalescing, policers on the DSA master, rate
limiting for learn frames in the switch...
