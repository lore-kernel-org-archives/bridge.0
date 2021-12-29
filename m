Return-Path: <nikolay@nvidia.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4Nym9iSieGcRP9Mc66kiluCyjNY8rcebbwh7mTxWaw=;
 b=XC/M3TZKS/h18UtS9kKeIzXFvrGIZAjXiMXIWJm4sWr976CNfhU0zEUEX/R/LFQMMb5RvoBLcsn6mD3DbHrTbQcg9AH4fb4esQ7utkAUE5LtUFYl6mUmDM7s6Z0q7RWCa0MasfYFORmA2kK3ZiRrtzkTJwuyUzBvQQNfWrvLDTLNK2iKsHRMCYgS8ox4/gAGDxxgUyqlf+nbMqPSzse/dtAMKlkxd8uvNx2RwtHQXyoEVmCAeCmIl6v3W5f7dvgWCd2ASnxoQlPhbcFiO7La9MVLuHILWjk8b4UXXPQqQrXa/lwrHG09PWd2VJbjqybd5pYk1qVSOuZnJlAsp3KKGw==
Message-ID: <081437ff-a69d-faf5-0981-389156a90668@nvidia.com>
Date: Wed, 29 Dec 2021 13:46:14 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20211229004913.513372-1-kuba@kernel.org>
From: Nikolay Aleksandrov <nikolay@nvidia.com>
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
To: Jakub Kicinski <kuba@kernel.org>, ast@kernel.org, daniel@iogearbox.net
Cc: andrew@lunn.ch, mustafa.ismail@intel.com, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, pablo@netfilter.org, andrii@kernel.org, george.mccollister@gmail.com, anthony.l.nguyen@intel.com, ralf@linux-mips.org, linux-hams@vger.kernel.org, hawk@kernel.org, steffen.klassert@secunet.com, linux-s390@vger.kernel.org, pkshih@realtek.com, f.fainelli@gmail.com, herbert@gondor.apana.org.au, leon@kernel.org, linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, john.fastabend@gmail.com, jesse.brandeburg@intel.com, kadlec@netfilter.org, jgg@ziepe.ca, dledford@redhat.com, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, habetsm.xilinx@gmail.com, yzaikin@google.com, vivien.didelot@gmail.com, wg@grandegger.com, sgarzare@redhat.com, woojung.huh@microchip.com, johan.hedberg@gmail.com, arnd@arndb.de, marcel@holtmann.org, jhs@mojatatu.com, linux-can@vger.kernel.org, wenjia@linux.ibm.com, Marc Kleine-Budde <mkl@pengutronix.de>, viro@zeniv.linux.org.uk, luiz.dentz@gmail.com, jiri@nvidia.com, xiyou.wangcong@gmail.com, michael.chan@broadcom.com, virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com, trond.myklebust@hammerspace.com, kvalo@codeaurora.org, linux-nfs@vger.kernel.org, wintera@linux.ibm.com, keescook@chromium.org, netdev@vger.kernel.org, dsahern@kernel.org, linux-decnet-user@lists.sourceforge.net, fw@strlen.de, tariqt@nvidia.com, kgraul@linux.ibm.com, ecree.xilinx@gmail.com, mcgrof@kernel.org, netfilter-devel@vger.kernel.org, jreuter@yaina.de, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com, saeedm@nvidia.com, anna.schumaker@netapp.com, ap420073@gmail.com

On 29/12/2021 02:49, Jakub Kicinski wrote:
> sock.h is pretty heavily used (5k objects rebuilt on x86 after
> it's touched). We can drop the include of filter.h from it and
> add a forward declaration of struct sk_filter instead.
> This decreases the number of rebuilt objects when bpf.h
> is touched from ~5k to ~1k.
> 
> There's a lot of missing includes this was masking. Primarily
> in networking tho, this time.
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: https://lore.kernel.org/all/20211228192519.386913-1-kuba@kernel.org/
>  - fix build in bond on ia64
>  - fix build in ip6_fib with randconfig
> 
> CC: marcel@holtmann.org
> CC: johan.hedberg@gmail.com
> CC: luiz.dentz@gmail.com
> CC: dledford@redhat.com
> CC: jgg@ziepe.ca
> CC: mustafa.ismail@intel.com
> CC: shiraz.saleem@intel.com
> CC: leon@kernel.org
> CC: ap420073@gmail.com
> CC: wg@grandegger.com
> CC: woojung.huh@microchip.com
> CC: andrew@lunn.ch
> CC: vivien.didelot@gmail.com
> CC: f.fainelli@gmail.com
> CC: olteanv@gmail.com
> CC: george.mccollister@gmail.com
> CC: michael.chan@broadcom.com
> CC: jesse.brandeburg@intel.com
> CC: anthony.l.nguyen@intel.com
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: hawk@kernel.org
> CC: john.fastabend@gmail.com
> CC: tariqt@nvidia.com
> CC: saeedm@nvidia.com
> CC: ecree.xilinx@gmail.com
> CC: habetsm.xilinx@gmail.com
> CC: jreuter@yaina.de
> CC: dsahern@kernel.org
> CC: kvalo@codeaurora.org
> CC: pkshih@realtek.com
> CC: trond.myklebust@hammerspace.com
> CC: anna.schumaker@netapp.com
> CC: viro@zeniv.linux.org.uk
> CC: andrii@kernel.org
> CC: mcgrof@kernel.org
> CC: keescook@chromium.org
> CC: yzaikin@google.com
> CC: nikolay@nvidia.com
> CC: jiri@nvidia.com
> CC: wintera@linux.ibm.com
> CC: wenjia@linux.ibm.com
> CC: pablo@netfilter.org
> CC: kadlec@netfilter.org
> CC: fw@strlen.de
> CC: ralf@linux-mips.org
> CC: jhs@mojatatu.com
> CC: xiyou.wangcong@gmail.com
> CC: kgraul@linux.ibm.com
> CC: sgarzare@redhat.com
> CC: steffen.klassert@secunet.com
> CC: herbert@gondor.apana.org.au
> CC: arnd@arndb.de
> CC: linux-bluetooth@vger.kernel.org
> CC: linux-rdma@vger.kernel.org
> CC: linux-can@vger.kernel.org
> CC: intel-wired-lan@lists.osuosl.org
> CC: bpf@vger.kernel.org
> CC: linux-hams@vger.kernel.org
> CC: ath11k@lists.infradead.org
> CC: linux-wireless@vger.kernel.org
> CC: linux-nfs@vger.kernel.org
> CC: linux-fsdevel@vger.kernel.org
> CC: bridge@lists.linux-foundation.org
> CC: linux-decnet-user@lists.sourceforge.net
> CC: linux-s390@vger.kernel.org
> CC: netfilter-devel@vger.kernel.org
> CC: coreteam@netfilter.org
> CC: virtualization@lists.linux-foundation.org
> ---
[snip]
>  net/bridge/br_ioctl.c                             | 1 +
[snip
>  70 files changed, 80 insertions(+), 1 deletion(-)
> 

For the bridge:
Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>


