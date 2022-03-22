Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9ZYK2bO0oPIhpErMM+q2xzW2Mm6s9oaP61Irqyq44+o=;
 b=Nvd7dfWXP+MA7dn8CeB7ApslVwt7Ch4qLfscmiSOHeFbaOF9/tK1poS1ifcMe3ghNg
 DnCEz0wXmVONAozXAWG/QpUZ4hiqnzDPu35fl+Oht/1JY2MNekzvFurIZPRK9t/7rxZS
 jQDTi9f0zRetFMQRsN1rLdQSRxaaGPNqka4iqCdbRHdX/PjP+gv6AxOPBUGud1P0psXO
 BCooV9cbBp7iFmg4K8E0k9YVVMJWkK8r3oJTpljeWkfSp9Y9W+mb7xk88H/CNd5BtcM3
 SSlFK/VVUIZV5bVyZBvk+zDc7RNpT/k+MCpku+Wej43wkkN4k2xU3ruiYTp8mggUiK4h
 ez/w==
Date: Tue, 22 Mar 2022 13:08:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220322110806.kbdb362jf6pbtqaf@skbuf>
References: <20220317153625.2ld5zgtuhoxbcgvo@skbuf> <86ilscr2a4.fsf@gmail.com>
 <20220317161808.psftauoz5iaecduy@skbuf> <8635jg5xe5.fsf@gmail.com>
 <20220317172013.rhjvknre5w7mfmlo@skbuf> <86tubvk24r.fsf@gmail.com>
 <20220318121400.sdc4guu5m4auwoej@skbuf> <86pmmjieyl.fsf@gmail.com>
 <20220318131943.hc7z52beztqlzwfq@skbuf> <86a6dixnd2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86a6dixnd2.fsf@gmail.com>
Subject: Re: [Bridge] [PATCH net-next 3/3] net: dsa: mv88e6xxx: mac-auth/MAB
 implementation
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

On Tue, Mar 22, 2022 at 12:01:13PM +0100, Hans Schultz wrote:
> On fre, mar 18, 2022 at 15:19, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Fri, Mar 18, 2022 at 02:10:26PM +0100, Hans Schultz wrote:
> >> In the offloaded case there is no difference between static and dynamic
> >> flags, which I see as a general issue. (The resulting ATU entry is static
> >> in either case.)
> >
> > It _is_ a problem. We had the same problem with the is_local bit.
> > Independently of this series, you can add the dynamic bit to struct
> > switchdev_notifier_fdb_info and make drivers reject it.
> >
> >> These FDB entries are removed when link goes down (soft or hard). The
> >> zero DPV entries that the new code introduces age out after 5 minutes,
> >> while the locked flagged FDB entries are removed by link down (thus the
> >> FDB and the ATU are not in sync in this case).
> >
> > Ok, so don't let them disappear from hardware, refresh them from the
> > driver, since user space and the bridge driver expect that they are
> > still there.
> 
> I have now tested with two extra unmanaged switches (each connected to a
> seperate port on our managed switch, and when migrating from one port to
> another, there is member violations, but as the initial entry ages out,
> a new miss violation occurs and the new port adds the locked entry. In
> this case I only see one locked entry, either on the initial port or
> later on the port the host migrated to (via switch).
> 
> If I refresh the ATU entries indefinitly, then this migration will for
> sure not work, and with the member violation suppressed, it will be
> silent about it.

Manual says that migrations should trigger miss violations if configured
adequately, is this not the case?

> So I don't think it is a good idea to refresh the ATU entries
> indefinitely.
> 
> Another issue I see, is that there is a deadlock or similar issue when
> receiving violations and running 'bridge fdb show' (it seemed that
> member violations also caused this, but not sure yet...), as the unit
> freezes, not to return...

Have you enabled lockdep, debug atomic sleep, detect hung tasks, things
like that?
