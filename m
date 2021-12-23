Return-Path: <repk@triplefau.lt>
Date: Thu, 23 Dec 2021 18:50:30 +0100
From: Remi Pommarel <repk@triplefau.lt>
Message-ID: <YcS25oqoo+xnAIIW@pilgrim>
References: <20211223153139.7661-1-repk@triplefau.lt>
 <20211223153139.7661-3-repk@triplefau.lt>
 <20211223085944.55b43857@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223085944.55b43857@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH net 2/2] net: bridge: Get SIOCGIFBR/SIOCSIFBR
 ioctl working in compat mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>

On Thu, Dec 23, 2021 at 08:59:44AM -0800, Jakub Kicinski wrote:
> On Thu, 23 Dec 2021 16:31:39 +0100 Remi Pommarel wrote:
> > In compat mode SIOC{G,S}IFBR ioctls were only supporting
> > BRCTL_GET_VERSION returning an artificially version to spur userland
> > tool to use SIOCDEVPRIVATE instead. But some userland tools ignore that
> > and use SIOC{G,S}IFBR unconditionally as seen with busybox's brctl.
> > 
> > Example of non working 32-bit brctl with CONFIG_COMPAT=y:
> > $ brctl show
> > brctl: SIOCGIFBR: Invalid argument
> > 
> > Example of fixed 32-bit brctl with CONFIG_COMPAT=y:
> > $ brctl show
> > bridge name     bridge id               STP enabled     interfaces
> > br0
> > 
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Since Arnd said this is not supposed to be backported I presume it
> should go to net-next?

Yes, out of curiosity, is it appropriate to mix "[PATCH net]" and
"[PATCH net-next]" in the same serie ?

Thanks

-- 
Remi
