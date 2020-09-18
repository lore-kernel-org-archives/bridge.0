Return-Path: <davem@davemloft.net>
Date: Fri, 18 Sep 2020 14:47:21 -0700 (PDT)
Message-Id: <20200918.144721.348413288598834487.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <9ab2973de2c0fb32de7fbc4ae823a820cd48a769.camel@nvidia.com>
References: <20200912.183437.1205152743307947529.davem@davemloft.net>
 <CAMuHMdXGmKYKWtkFCV0WmYnY4Gn--Bbz-iSX76oc-UNNrzCMuw@mail.gmail.com>
 <9ab2973de2c0fb32de7fbc4ae823a820cd48a769.camel@nvidia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] Revert "net: linkwatch: add check for
 netdevice being present to linkwatch_do_dev"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@nvidia.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, roopa@nvidia.com, kuba@kernel.org, gaku.inami.xh@renesas.com, hkallweit1@gmail.com

From: Nikolay Aleksandrov <nikolay@nvidia.com>
Date: Fri, 18 Sep 2020 12:35:02 +0000

> Thanks for the analysis, I don't see any issues with checking if the device
> isn't present. It will have to go through some testing, but no obvious
> objections/issues. Have you tried if it fixes your case?
> I have briefly gone over drivers' use of net_device_detach(), mostly it's used
> for suspends, but there are a few cases which use it on IO error or when a
> device is actually detaching (VF detach). The vlan port event is for vlan
> devices on top of the bridge when BROPT_VLAN_BRIDGE_BINDING is enabled and their
> carrier is changed based on vlan participating ports' state.

There are two things to resolve:

1) Why does the bridge need to get a change event for devices which have
   not fully resumed yet?

2) What kind of link state change is happening on devices which are not
   currently fully resumed yet?

Really this whole situation is still quite mysterious to me.

If the driver (or the PHY library it is using, etc.) is emitting link
state changes before it marks itself as "present", that's the real
bug.
