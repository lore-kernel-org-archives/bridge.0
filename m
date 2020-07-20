Return-Path: <davem@davemloft.net>
Date: Mon, 20 Jul 2020 16:20:13 -0700 (PDT)
Message-Id: <20200720.162013.456211151711627380.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <deaedc6d-edde-68da-50e8-6474ca818191@datenfreihafen.org>
References: <20200720124737.118617-1-hch@lst.de>
 <20200720124737.118617-25-hch@lst.de>
 <deaedc6d-edde-68da-50e8-6474ca818191@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 24/24] net: pass a sockptr_t into ->setsockopt
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stefan@datenfreihafen.org
Cc: ast@kernel.org, linux-sctp@vger.kernel.org, hch@lst.de, linux-s390@vger.kernel.org, rds-devel@oss.oracle.com, daniel@iogearbox.net, dccp@vger.kernel.org, bridge@lists.linux-foundation.org, linux-afs@lists.infradead.org, lvs-devel@vger.kernel.org, coreteam@netfilter.org, mptcp@lists.01.org, kuznet@ms2.inr.ac.ru, linux-can@vger.kernel.org, kuba@kernel.org, linux-hams@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-x25@vger.kernel.org, edumazet@google.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Mon, 20 Jul 2020 16:19:38 +0200

> For the ieee802154 part:
> 
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

Please do not quote an entire patch just to add an ACK, trim it just
to the commit message, or even less.

Thank you.
