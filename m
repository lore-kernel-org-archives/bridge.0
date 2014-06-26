Return-Path: <davem@davemloft.net>
Date: Thu, 26 Jun 2014 13:35:50 -0700 (PDT)
Message-Id: <20140626.133550.975175623908419742.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1403781352.52578.103.camel@sakura.staff.proxad.net>
References: <1403534015-28496-1-git-send-email-mbizon@freebox.fr>
	<20140625161335.11598f09@haswell>
	<1403781352.52578.103.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: mark packets sent to any local mac
 address as PACKET_HOST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: mbizon@freebox.fr
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Maxime Bizon <mbizon@freebox.fr>
Date: Thu, 26 Jun 2014 13:15:52 +0200

> for some reasons, hostapd kept adding and removing the interface from
> the bridge, triggering a mac address of the bridge change each time (I
> did not notice that).

I think this is what you need to investigate rather than making
changes to the bridge layer.
