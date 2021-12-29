Return-Path: <sgarzare@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640786792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aO/4Yp6T43XLmNMDQP+OwTqaYv7whlIlyBDq4dbPFsg=;
 b=cIKLPwvkNFjDmUgRNlTNSevOZIBBFlut6kEpMOFbQCxhZU69gSHGNYnoRflhGuMChScNM8
 MLLIYy1Jlu4IaaAOR1/o9cyYzvZDtsUr3P0CyuY6juobcOPXCitDDK0ZZO06bxnwR6prVQ
 6vzpTZjOkHWBIWOV7rNOYbKxvNXjFuU=
Date: Wed, 29 Dec 2021 15:05:57 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20211229140557.cuap5jjqz47yevda@steredhat>
References: <20211229004913.513372-1-kuba@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: Re: [Bridge] [PATCH bpf-next v2] net: don't include filter.h from
	net/sock.h
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: wintera@linux.ibm.com, andrew@lunn.ch, mustafa.ismail@intel.com, pablo@netfilter.org, ast@kernel.org, andrii@kernel.org, george.mccollister@gmail.com, anthony.l.nguyen@intel.com, ralf@linux-mips.org, linux-hams@vger.kernel.org, hawk@kernel.org, steffen.klassert@secunet.com, linux-s390@vger.kernel.org, pkshih@realtek.com, f.fainelli@gmail.com, herbert@gondor.apana.org.au, daniel@iogearbox.net, linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, john.fastabend@gmail.com, jesse.brandeburg@intel.com, kadlec@netfilter.org, jgg@ziepe.ca, dledford@redhat.com, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, nikolay@nvidia.com, linux-wireless@vger.kernel.org, habetsm.xilinx@gmail.com, yzaikin@google.com, vivien.didelot@gmail.com, wg@grandegger.com, ath11k@lists.infradead.org, woojung.huh@microchip.com, johan.hedberg@gmail.com, arnd@arndb.de, marcel@holtmann.org, jhs@mojatatu.com, linux-can@vger.kernel.org, wenjia@linux.ibm.com, Marc Kleine-Budde <mkl@pengutronix.de>, viro@zeniv.linux.org.uk, luiz.dentz@gmail.com, jiri@nvidia.com, xiyou.wangcong@gmail.com, michael.chan@broadcom.com, virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com, trond.myklebust@hammerspace.com, kvalo@codeaurora.org, linux-nfs@vger.kernel.org, leon@kernel.org, keescook@chromium.org, netdev@vger.kernel.org, dsahern@kernel.org, linux-decnet-user@lists.sourceforge.net, fw@strlen.de, tariqt@nvidia.com, kgraul@linux.ibm.com, ecree.xilinx@gmail.com, mcgrof@kernel.org, netfilter-devel@vger.kernel.org, jreuter@yaina.de, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com, saeedm@nvidia.com, anna.schumaker@netapp.com, ap420073@gmail.com

On Tue, Dec 28, 2021 at 04:49:13PM -0800, Jakub Kicinski wrote:
>sock.h is pretty heavily used (5k objects rebuilt on x86 after
>it's touched). We can drop the include of filter.h from it and
>add a forward declaration of struct sk_filter instead.
>This decreases the number of rebuilt objects when bpf.h
>is touched from ~5k to ~1k.
>
>There's a lot of missing includes this was masking. Primarily
>in networking tho, this time.
>
>Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>---
>v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba@kernel.org/
> - fix build in bond on ia64
> - fix build in ip6_fib with randconfig

For AF_VSOCK:
Acked-by: Stefano Garzarella <sgarzare@redhat.com>

