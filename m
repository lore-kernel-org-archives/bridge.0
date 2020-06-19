Return-Path: <mcgrof@gmail.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20200619210706.GJ13911@42.do-not-panic.com>
References: <20200610154923.27510-1-mcgrof@kernel.org>
 <20200617174348.70710c3ecb14005fb1b9ec39@linux-foundation.org>
 <20200619204626.GK11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619204626.GK11244@42.do-not-panic.com>
Subject: Re: [Bridge] [PATCH 0/5] kmod/umh: a few fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 19 Jun 2020 21:07:12 -0000
To: Andrew Morton <akpm@linux-foundation.org>, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Jessica Yu <jeyu@kernel.org>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, bridge@lists.linux-foundation.org, jmorris@namei.org, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, philipp.reisner@linbit.com, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

Sorry it seems mutt ate my To:, so adding the folks I intended to
address on the To: field now :)

  Luis

On Fri, Jun 19, 2020 at 08:46:26PM +0000, Luis Chamberlain wrote:
> On Wed, Jun 17, 2020 at 05:43:48PM -0700, Andrew Morton wrote:
> > On Wed, 10 Jun 2020 15:49:18 +0000 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> > 
> > > Tiezhu Yang had sent out a patch set with a slew of kmod selftest
> > > fixes, and one patch which modified kmod to return 254 when a module
> > > was not found. This opened up pandora's box about why that was being
> > > used for and low and behold its because when UMH_WAIT_PROC is used
> > > we call a kernel_wait4() call but have never unwrapped the error code.
> > > The commit log for that fix details the rationale for the approach
> > > taken. I'd appreciate some review on that, in particular nfs folks
> > > as it seems a case was never really hit before.
> > > 
> > > This goes boot tested, selftested with kmod, and 0-day gives its
> > > build blessings.
> > 
> > Any thoughts on which kernel version(s) need some/all of these fixes?
> 
> Well, in so far as fixes, this is the real important part:
> 
> * request_module() used to fail with an error code of
>   256 when a module was not found. Now it properly
>   returns 1.
> 
> * fs/nfsd/nfs4recover.c: we never were disabling the
>   upcall as the error code of -ENOENT or -EACCES was
>   *never* properly checked for error code
> 
> Since the request_module() fix is only affecting userspace
> for the kmod tests, through the kmod test driver, ie, we don't expose
> this to userspace in any other place, I don't see that as critical.
> Let me be clear, we have a test_kmod driver which exposes knobs
> and one of the knobs lets userspace query the return value of a
> request_module() call, and we use this test_kmod driver to stress
> test kmod loader. Let us also recall that the fix is *iff* an error
> *did* occur. I *cannot* think of a reason why this would be critical
> to merge to older stable kernels for this reason for request_module()'s
> sake.
> 
> Bruce, Chuck:
> 
> But... for NFS... I'd like the NFS folks to really look at that
> and tell us is some folks really should care about that. I also
> find it perplexing there was a comment in place there to *ensure*
> the error was checked for, and so it seemed someone cared for that
> condition.
> 
> > >  drivers/block/drbd/drbd_nl.c         | 20 +++++------
> > >  fs/nfsd/nfs4recover.c                |  2 +-
> > >  include/linux/sched/task.h           | 13 ++++++++
> > >  kernel/kmod.c                        |  5 ++-
> > >  kernel/umh.c                         |  4 +--
> > >  lib/test_kmod.c                      |  2 +-
> > >  net/bridge/br_stp_if.c               | 10 ++----
> > >  security/keys/request_key.c          |  2 +-
> > >  tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----
> > 
> > I'm not really sure who takes kmod changes - I'll grab these unless
> > someone shouts at me.
> 
> Greg usually takes it, but as usual, thanks for picking up the slack ;)
> 
>   Luis
