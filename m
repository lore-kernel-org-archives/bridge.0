Return-Path: <mcgrof@gmail.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20200624131725.GL13911@42.do-not-panic.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624120546.GC4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624120546.GC4332@42.do-not-panic.com>
Subject: Re: [Bridge] linux-next: umh: fix processed error when
 UMH_WAIT_PROC is used seems to break linux bridge on s390x (bisected)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 24 Jun 2020 13:17:29 -0000
To: Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Doucha <mdoucha@suse.cz>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, dhowells@redhat.com, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, bfields@fieldses.org, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

Martin, your eyeballs would be appreciated for a bit on this.

On Wed, Jun 24, 2020 at 12:05:46PM +0000, Luis Chamberlain wrote:
> On Wed, Jun 24, 2020 at 01:11:54PM +0200, Christian Borntraeger wrote:
> > 
> > 
> > On 23.06.20 16:23, Christian Borntraeger wrote:
> > > 
> > > 
> > > On 23.06.20 16:11, Christian Borntraeger wrote:
> > >> Jens Markwardt reported a regression in the linux-next runs.  with "umh: fix
> > >> processed error when UMH_WAIT_PROC is used" (from linux-next) a linux bridge
> > >> with an KVM guests no longer activates :
> > >>
> > >> without patch
> > >> # ip addr show dev virbr1
> > >> 6: virbr1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
> > >>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
> > >>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
> > >>        valid_lft forever preferred_lft forever
> > >>
> > >> with this patch the bridge stays DOWN with NO-CARRIER
> > >>
> > >> # ip addr show dev virbr1
> > >> 6: virbr1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
> > >>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
> > >>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
> > >>        valid_lft forever preferred_lft forever
> > >>
> > >> This was bisected in linux-next. Reverting from linux-next also fixes the issue.
> > >>
> > >> Any idea?
> > > 
> > > FWIW, s390 is big endian. Maybe some of the shifts inn the __KW* macros are wrong.
> > 
> > Does anyone have an idea why "umh: fix processed error when UMH_WAIT_PROC is used" breaks the
> > linux-bridge on s390?
> 
> glibc for instance defines __WEXITSTATUS in only one location: bits/waitstatus.h
> and it does not special case it per architecture, so at this point I'd
> have to say we have to look somewhere else for why this is happening.

I found however an LTP bug indicating the need to test for
s390 wait macros [0] in light of a recent bug in glibc for s390.
I am asking for references to that issue given I cannot find
any mention of this on glibc yet.

I'm in hopes Martin might be aware of that mentioned s390 glic bug.

[0] https://github.com/linux-test-project/ltp/issues/605

  Luis
