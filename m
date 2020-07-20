Return-Path: <davem@davemloft.net>
Date: Sun, 19 Jul 2020 18:16:59 -0700 (PDT)
Message-Id: <20200719.181659.1807927650741641565.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200717062331.691152-1-hch@lst.de>
References: <20200717062331.691152-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] sockopt cleanups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: hch@lst.de
Cc: linux-arch@vger.kernel.org, daniel@iogearbox.net, dccp@vger.kernel.org, yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, ast@kernel.org, kadlec@netfilter.org, linux-bluetooth@vger.kernel.org, linux-sctp@vger.kernel.org, netfilter-devel@vger.kernel.org, mptcp@lists.01.org, 3chas3@gmail.com, netdev@vger.kernel.org, kuznet@ms2.inr.ac.ru, bpf@vger.kernel.org, linux-can@vger.kernel.org, linux-wpan@vger.kernel.org, pablo@netfilter.org

From: Christoph Hellwig <hch@lst.de>
Date: Fri, 17 Jul 2020 08:23:09 +0200

> this series cleans up various lose ends in the sockopt code, most
> importantly removing the compat_{get,set}sockopt infrastructure in favor
> of just using in_compat_syscall() in the few places that care.

Series applied to net-next, thanks.
