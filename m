Return-Path: <amwang@redhat.com>
Message-ID: <1354287041.19865.2.camel@cr0>
From: Cong Wang <amwang@redhat.com>
Date: Fri, 30 Nov 2012 22:50:41 +0800
In-Reply-To: <20121130105449.GE30697@casper.infradead.org>
References: <1354269514-1863-1-git-send-email-amwang@redhat.com>
	<1354269514-1863-3-git-send-email-amwang@redhat.com>
	<20121130105449.GE30697@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Subject: Re: [Bridge] [PATCH iproute2 v1] Add mdb command to bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Graf <tgraf@suug.ch>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Jesper Dangaard Brouer <brouer@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On Fri, 2012-11-30 at 10:54 +0000, Thomas Graf wrote:
> 
> You shouldn't need to duplicate the attribute ids and struct br_port_msg
> in iproute2. Just put these definitions in a uapi kernel header and
> include the header from iproute2.

Right, I was confused by include/linux/rtnetlink.h, thought iproute2 has
its own copy of these headers, but they should be exported from kernel.

Thanks!


