Return-Path: <mcgrof@gmail.com>
From: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20200624160953.GH4332@42.do-not-panic.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
 <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
 <3118dc0d-a3af-9337-c897-2380062a8644@de.ibm.com>
 <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
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
Date: Wed, 24 Jun 2020 16:09:57 -0000
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, bfields@fieldses.org, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, Christoph Hellwig <hch@infradead.org>, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, dhowells@redhat.com, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

On Wed, Jun 24, 2020 at 05:54:46PM +0200, Christian Borntraeger wrote:
> 
> 
> On 24.06.20 16:43, Christoph Hellwig wrote:
> > On Wed, Jun 24, 2020 at 01:11:54PM +0200, Christian Borntraeger wrote:
> >> Does anyone have an idea why "umh: fix processed error when UMH_WAIT_PROC is used" breaks the
> >> linux-bridge on s390?
> > 
> > Are we even sure this is s390 specific and doesn't happen on other
> > architectures with the same bridge setup?
> 
> Fair point. AFAIK nobody has tested this yet on x86.

Regardless, can you enable dynamic debug prints, to see if the kernel
reveals anything on the bridge code which may be relevant:

echo "file net/bridge/* +p" > /sys/kernel/debug/dynamic_debug/control

  Luis
