Return-Path: <mcgrof@gmail.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20200624161319.GM13911@42.do-not-panic.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624120546.GC4332@42.do-not-panic.com>
 <20200624131725.GL13911@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624131725.GL13911@42.do-not-panic.com>
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
Date: Wed, 24 Jun 2020 16:13:23 -0000
To: Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Doucha <mdoucha@suse.cz>, hch@infradead.org
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, dhowells@redhat.com, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, bfields@fieldses.org, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

On Wed, Jun 24, 2020 at 01:17:25PM +0000, Luis Chamberlain wrote:
> I found however an LTP bug indicating the need to test for
> s390 wait macros [0] in light of a recent bug in glibc for s390.
> I am asking for references to that issue given I cannot find
> any mention of this on glibc yet.
> 
> [0] https://github.com/linux-test-project/ltp/issues/605

I looked into this and the bug associated was:

https://sourceware.org/bugzilla/show_bug.cgi?id=19613

The commit in question was upstream glibc commit
b49ab5f4503f36dcbf43f821f817da66b2931fe6 ("Remove union wait [BZ
#19613]"), and while I don't see anything s390 mentioned there,
the issue there was due to the caller of the wait using a long
instead of an int for the return value.

In other words, that'd not the droid we are looking for.

So the issue is something else.

  Luis
