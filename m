Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9pa9egMr6HuhpySJFZ922xtVve+4BTGS+NR78QDKpmA=;
 b=seQRViNZMkrvWnMY2i5wu0KjU3Wfsa+YhEAmbH7bVQjptTdGrXj0iOCqBY5XKau/lF
 Fs6TSVcEXddjrKILQYYbay7a9toHDoY9DBU+TLWLtsuVkuCdg6JViiburY0hin1OAEmU
 1MiOtEiCM2VWB7DT+mIUqRAoLLJXtDyBXAZr3ZXgzYTn3iIX4yDV/W1YfaNuawtMsEbT
 vpTQmnP6PafDQm+rcOeJ9sR870pMYmcrCx/NjxVJcXADl1+xXNjxX753OYJfdC1vXYrd
 C8u4HzVz7JmTKuyDdNNPjy1XV8pOqXmXrfRz/Tq/CIpYvkwIDGo1ASNYEtjLBc32+u5K
 Kw+A==
Date: Mon, 8 Feb 2021 13:45:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210208114511.xtzma5byrdnr5s7r@skbuf>
References: <20210207232141.2142678-1-olteanv@gmail.com>
 <20210207232141.2142678-3-olteanv@gmail.com>
 <95dede91-56aa-1852-8fbf-71d446fa7ede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95dede91-56aa-1852-8fbf-71d446fa7ede@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 2/9] net: bridge: offload initial and
 final port flags through switchdev
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com, "David S. Miller" <davem@davemloft.net>

On Mon, Feb 08, 2021 at 01:37:03PM +0200, Nikolay Aleksandrov wrote:
> Hi Vladimir,
> I think this patch potentially breaks some use cases. There are a few problems, I'll
> start with the more serious one: before the ports would have a set of flags that were
> always set when joining, now due to how nbp_flags_change() handles flag setting some might
> not be set which would immediately change behaviour w.r.t software fwding. I'll use your
> example of BR_BCAST_FLOOD: a lot of drivers will return an error for it and any broadcast
> towards these ports will be dropped, we have mixed environments with software ports that
> sometimes have traffic (e.g. decapped ARP requests) software forwarded which will stop working.

Yes, you're right. The only solution I can think of is to add a "bool ignore_errors"
to nbp_flags_change, set to true from new_nbp and del_nbp, and to false from the
netlink code.

> The other lesser issue is with the style below, I mean these three calls for each flag are
> just ugly and look weird as you've also noted, since these APIs are internal can we do better?

Doing better would mean allowing nbp_flags_change() to have a bit mask with
potentially more brport flags set, and to call br_switchdev_set_port_flag in
a for_each_set_bit() loop?
