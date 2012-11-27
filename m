Return-Path: <BATV+88bfec8d2491b7325dc9+3383+infradead.org+tgraf@casper.srs.infradead.org>
Date: Tue, 27 Nov 2012 12:00:15 +0000
From: Thomas Graf <tgraf@suug.ch>
Message-ID: <20121127120015.GB16701@casper.infradead.org>
References: <1354009785-20014-1-git-send-email-amwang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1354009785-20014-1-git-send-email-amwang@redhat.com>
Sender: Thomas Graf <tgr@infradead.org>
Subject: Re: [Bridge] [RFC PATCH 1/2] bridge: export port_no and port_id via
 IFA_INFO_DATA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Cong Wang <amwang@redhat.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Herbert Xu <herbert@gondor.hengli.com.au>, Jesper Dangaard Brouer <brouer@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>

On 11/27/12 at 05:49pm, Cong Wang wrote:
> Based on net-next.
> 
> This patch exports port->port_no port->port_id in the end of IFA_INFO_DATA.
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Stephen Hemminger <shemminger@vyatta.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Cong Wang <amwang@redhat.com>

Acked-by: Thomas Graf <tgraf@suug.ch>
