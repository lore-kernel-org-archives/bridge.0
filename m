From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 27 Nov 2009 23:14:42 +0100
References: <20091113195201.11184.25766.stgit@mimic.site>
	<20091113195529.11184.19011.stgit@mimic.site>
In-Reply-To: <20091113195529.11184.19011.stgit@mimic.site>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200911272314.42641.arnd@arndb.de>
Subject: Re: [Bridge] [PATCH 3/3] macvlan: allow in-kernel modules to create
	and manage macvlan devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Patrick Mullaney <pmullaney@novell.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, alacrityvm-devel@lists.sourceforge.net

On Friday 13 November 2009, Patrick Mullaney wrote:
> 
> The macvlan driver didn't allow for creation/deletion of devices
> by other in-kernel modules. This patch provides common routines
> for both in-kernel and netlink based management. This patch
> also enables macvlan device support for gro for lower level
> devices that support gro.

I wonder if doing this way round is a good idea, why don't
you just use netlink to set up the endpoint device like
the current macvlan and macvtap do? I think doing it consistently
for all backends would be a significant advantage.

	Arnd <><
