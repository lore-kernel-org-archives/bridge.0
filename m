Return-Path: <repk@triplefau.lt>
Date: Thu, 23 Dec 2021 14:33:40 +0100
From: Remi Pommarel <repk@triplefau.lt>
Message-ID: <YcR6tAsH9/+sAawW@pilgrim>
References: <20211222191320.17662-1-repk@triplefau.lt>
 <CAK8P3a18b63GoPKiTey8KpEusyffbN97gxP+NM3fyZnOYXv5zg@mail.gmail.com>
 <YcRW1ckSr3ZSCDf9@pilgrim>
 <CAK8P3a0PTu2qCHGr63TBMgnjL9fQwn4=7CrURKMHQufffwOg9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0PTu2qCHGr63TBMgnjL9fQwn4=7CrURKMHQufffwOg9Q@mail.gmail.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: fix ioctl old_deviceless
	bridge argument
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Networking <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Dec 23, 2021 at 12:38:14PM +0100, Arnd Bergmann wrote:
> On Thu, Dec 23, 2021 at 12:00 PM Remi Pommarel <repk@triplefau.lt> wrote:
> >
> > On Wed, Dec 22, 2021 at 10:52:20PM +0100, Arnd Bergmann wrote:
> > > On Wed, Dec 22, 2021 at 8:13 PM Remi Pommarel <repk@triplefau.lt> wrote:
> > [...]
> > >
> > > The intention of my broken patch was to make it work for compat mode as I did
> > > in br_dev_siocdevprivate(), as this is now the only bit that remains broken.
> > >
> > > This could be done along the lines of the patch below, if you see any value in
> > > it. (not tested, probably not quite right).
> >
> > Oh ok, because SIOC{S,G}IFBR compat ioctl was painfully done with
> > old_bridge_ioctl() I didn't think those needed compat. So I adapted and
> > fixed your patch to get that working.
> 
> Ok, thanks!
> 
> > Here is my test results.
> >
> > With my initial patch only :
> >   - 64bit busybox's brctl (working)
> >     # brctl show
> >     bridge name     bridge id               STP enabled     interfaces
> >     br0             8000.000000000000       n
> >
> >   - CONFIG_COMPAT=y + 32bit busybox's brctl (not working)
> >     # brctl show
> >     brctl: SIOCGIFBR: Invalid argument
> >
> > With both my intial patch and the one below :
> >   - 64bit busybox's brctl (working)
> >     # brctl show
> >     bridge name     bridge id               STP enabled     interfaces
> >     br0             8000.000000000000       n
> >
> >   - CONFIG_COMPAT=y + 32bit busybox's brctl (working)
> >     # brctl show
> >     bridge name     bridge id               STP enabled     interfaces
> >     br0             8000.000000000000       n
> >
> > If you think this has enough value to fix those compatility issues I can
> > either send the below patch as a V2 replacing my initial one for net
> > or sending it as a separate patch for net-next. What would you rather
> > like ?
> 
> If 32-bit busybox still uses those ioctls in moderately recent
> versions, then it's probably worth doing this, but that would
> be up to the bridge maintainers.
> 
> Your patch looks good to me, I see you caught a few mistakes
> in my prototype. I would however suggest basing it on top of
> your original fix, so that can be applied first and backported
> to stable kernels, while the new patch would go on top and
> not get backported.
> 
> If that works with everyone, please submit those two, and add
> these tags to the second patch:
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Ok thanks a lot, will send a new patch serie with both patches so
that bridge maintainers could only pick one or both patches.

-- 
Remi
