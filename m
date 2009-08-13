Date: Thu, 13 Aug 2009 16:27:16 -0700 (PDT)
Message-Id: <20090813.162716.207478915.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <0199E0D51A61344794750DC57738F58E6D6B0C70D9@GVW1118EXC.americas.hpqcorp.net>
References: <0199E0D51A61344794750DC57738F58E6D6B0C70D9@GVW1118EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net/bridge: Add 'hairpin' port forwarding mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: anna.fischer@hp.com
Cc: mike.dickson@hp.com, arnd@arndb.de, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, ptcongdon@ucdavis.edu, bridge@osdl.org, adobriyan@gmail.com, evb@yahoogroups.com

From: "Fischer, Anna" <anna.fischer@hp.com>
Date: Thu, 13 Aug 2009 16:55:16 +0000

> This patch adds a 'hairpin' (also called 'reflective relay') mode
> port configuration to the Linux Ethernet bridge kernel module.
> A bridge supporting hairpin forwarding mode can send frames back
> out through the port the frame was received on.
> 
> Hairpin mode is required to support basic VEPA (Virtual
> Ethernet Port Aggregator) capabilities.
> 
> You can find additional information on VEPA here:
> http://tech.groups.yahoo.com/group/evb/
> http://www.ieee802.org/1/files/public/docs2009/new-hudson-vepa_seminar-20090514d.pdf
> http://www.internet2.edu/presentations/jt2009jul/20090719-congdon.pdf
> 
> An additional patch 'bridge-utils: Add 'hairpin' port forwarding mode'
> is provided to allow configuring hairpin mode from userspace tools.
> 
> Signed-off-by: Paul Congdon <paul.congdon@hp.com>
> Signed-off-by: Anna Fischer <anna.fischer@hp.com>

Applied to net-next-2.6
