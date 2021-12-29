Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=IBcil9O+VRrBlwSK9WQFnnXvi87jfhzw0Yvv4tQzzQ4=;
 b=noDIEQ8P8sUYyX/OE18Q5FGCEdOtXRbYUWogiKJXUl19FWceFTLSzy33NO7370WsVb
 xNtywJS1aHmXYo/ZkLPfxpKAuLKxK4YE+eVz8VTkizITqKtfycFbgYZ8mkgMJWEJt21+
 SNTUf5JrpwvWrXhCSoo6DxEmJYz1lYAcgrZn5Siak7Xevszf8m10NCTaN+zXiqI+KIS/
 Eu3eNT4oCfEFd0fiD/WXOlhQ5EblQr9RpaZdLMvylKbA5ymBdmZHyFsCK1nxmVisoAn9
 uYVylo+Wo6Qmr7pTJyQxMeOn82Ns+dOHizKeng6bH3WIfBKj/q/NPdRFTbbgDlFIWhAW
 0Xqg==
Message-ID: <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
Date: Tue, 28 Dec 2021 17:33:39 -0800
MIME-Version: 1.0
Content-Language: en-US
References: <20211229004913.513372-1-kuba@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211229004913.513372-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: andrew@lunn.ch, mustafa.ismail@intel.com, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, pablo@netfilter.org, andrii@kernel.org, george.mccollister@gmail.com, anthony.l.nguyen@intel.com, ralf@linux-mips.org, linux-hams@vger.kernel.org, hawk@kernel.org, steffen.klassert@secunet.com, linux-s390@vger.kernel.org, pkshih@realtek.com, herbert@gondor.apana.org.au, leon@kernel.org, linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org, bridge@lists.linux-foundation.org, john.fastabend@gmail.com, jesse.brandeburg@intel.com, kadlec@netfilter.org, jgg@ziepe.ca, dledford@redhat.com, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, nikolay@nvidia.com, habetsm.xilinx@gmail.com, yzaikin@google.com, vivien.didelot@gmail.com, wg@grandegger.com, sgarzare@redhat.com, woojung.huh@microchip.com, johan.hedberg@gmail.com, arnd@arndb.de, marcel@holtmann.org, jhs@mojatatu.com, linux-can@vger.kernel.org, wenjia@linux.ibm.com, Marc Kleine-Budde <mkl@pengutronix.de>, viro@zeniv.linux.org.uk, luiz.dentz@gmail.com, jiri@nvidia.com, xiyou.wangcong@gmail.com, michael.chan@broadcom.com, virtualization@lists.linux-foundation.org, shiraz.saleem@intel.com, trond.myklebust@hammerspace.com, kvalo@codeaurora.org, linux-nfs@vger.kernel.org, wintera@linux.ibm.com, keescook@chromium.org, netdev@vger.kernel.org, dsahern@kernel.org, linux-decnet-user@lists.sourceforge.net, fw@strlen.de, tariqt@nvidia.com, kgraul@linux.ibm.com, ecree.xilinx@gmail.com, mcgrof@kernel.org, netfilter-devel@vger.kernel.org, jreuter@yaina.de, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, olteanv@gmail.com, saeedm@nvidia.com, anna.schumaker@netapp.com, ap420073@gmail.com



On 12/28/2021 4:49 PM, Jakub Kicinski wrote:
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

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

It would be nice if we used the number of files rebuilt because of a 
header file change as another metric that the kernel is evaluated with 
from release to release (or even on a commit by commit basis). Food for 
thought.
-- 
Florian
