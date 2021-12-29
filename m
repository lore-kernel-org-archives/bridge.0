Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eyiokD87yXLE7dKoF/rAesIX6IaZjzEtJI7+LN04FEk=;
 b=jbps2qryj0Z0zQWn+lrBBlSxcDefe6KXi88QIlXKVc6Y7PKqWfUapjY8JxFcaIGigd
 ft7+84WoQ0h4UhL3vyJ1DIBHIIiAm5llGYmfk4nVkAe+3GrrBf97zhKbWsvTPX6JejKF
 1dkXJo0UGl+pIxJTyh0L4R8V7cOazLao67YG1WvcCgMJUT7Zmhf0eicJkPKKBztKsk7v
 D05fKDj1dOQc8zLv828bRzJys90kfBlRY+f583hLSA+S27xtYBrr/t46oqhBNzw2uXBi
 meZ8HORQpYNqIJLSkK446oH4j64Ut5bibHP4XsZdHoPvyO6AnHzKO5rs+vK+c+HbGKip
 7LUg==
MIME-Version: 1.0
References: <20211229004913.513372-1-kuba@kernel.org>
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Dec 2021 08:51:23 -0800
Message-ID: <CAADnVQLd2y_Cuqrn+cAQzCjpXM_Lub5_X6xEfZdMMC2a2Jq41A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: wintera@linux.ibm.com, Andrew Lunn <andrew@lunn.ch>, mustafa.ismail@intel.com, Pablo Neira Ayuso <pablo@netfilter.org>, ath11k@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, george.mccollister@gmail.com, anthony.l.nguyen@intel.com, Ralf Baechle <ralf@linux-mips.org>, linux-hams@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, linux-s390 <linux-s390@vger.kernel.org>, pkshih@realtek.com, Florian Fainelli <f.fainelli@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.net>, linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, John Fastabend <john.fastabend@gmail.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Jozsef Kadlecsik <kadlec@netfilter.org>, Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>, coreteam@netfilter.org, intel-wired-lan <intel-wired-lan@lists.osuosl.org>, nikolay@nvidia.com, linux-wireless <linux-wireless@vger.kernel.org>, habetsm.xilinx@gmail.com, Iurii Zaikin <yzaikin@google.com>, vivien.didelot@gmail.com, wg@grandegger.com, sgarzare@redhat.com, woojung.huh@microchip.com, johan.hedberg@gmail.com, Arnd Bergmann <arnd@arndb.de>, marcel@holtmann.org, Jamal Hadi Salim <jhs@mojatatu.com>, linux-can@vger.kernel.org, wenjia@linux.ibm.com, Marc Kleine-Budde <mkl@pengutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, luiz.dentz@gmail.com, jiri@nvidia.com, Cong Wang <xiyou.wangcong@gmail.com>, Michael Chan <michael.chan@broadcom.com>, virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com, trond.myklebust@hammerspace.com, kvalo@codeaurora.org, linux-nfs@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Kees Cook <keescook@chromium.org>, Network Development <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, linux-decnet-user@lists.sourceforge.net, Florian Westphal <fw@strlen.de>, Tariq Toukan <tariqt@nvidia.com>, kgraul@linux.ibm.com, ecree.xilinx@gmail.com, "Luis R. Rodriguez" <mcgrof@kernel.org>, netfilter-devel <netfilter-devel@vger.kernel.org>, jreuter@yaina.de, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, olteanv@gmail.com, saeedm@nvidia.com, anna.schumaker@netapp.com, Taehee Yoo <ap420073@gmail.com>

On Tue, Dec 28, 2021 at 4:49 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
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

Nice! Applied. Thanks
