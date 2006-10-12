Date: Thu, 12 Oct 2006 13:31:23 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061012133123.0a37c77d@freekitty>
In-Reply-To: <20061012201043.GA29253@gospo.rdu.redhat.com>
References: <20061012112431.0550b252@dxpl.pdx.osdl.net>
	<20061012201043.GA29253@gospo.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: flush forwarding table when device
	carrier off
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: netdev@vger.kernel.org, bridge@osdl.org, "David S. Miller" <davem@davemloft.net>

On Thu, 12 Oct 2006 16:10:44 -0400
Andy Gospodarek <andy@greyhouse.net> wrote:

> On Thu, Oct 12, 2006 at 11:24:31AM -0700, Stephen Hemminger wrote:
> > Flush the forwarding table when carrier is lost. This helps for
> > availability because we don't want to forward to a downed device and
> > new packets may come in on other links.
> > 
> > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
> > 
> 
> Stephen,
> 
> This is an excellent idea and all looks good except this check
> 
> +			if (f->is_static & !do_all)
> +				continue;
> 
> should be this: 
> 
> +			if (f->is_static && !do_all)
> +				continue;
> 

Agreed, but it probably worked during testing because both flags
are strict booleans (ie 0/1)


-- 
Stephen Hemminger <shemminger@osdl.org>
