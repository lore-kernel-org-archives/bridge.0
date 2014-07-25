Return-Path: <pneira@us.es>
Date: Fri, 25 Jul 2014 15:01:34 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20140725130134.GC13940@salvia>
References: <1406107694.12441.8.camel@x220> <20140723093949.GA3754@salvia>
	<1406291131.8231.20.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1406291131.8231.20.camel@x220>
Subject: Re: [Bridge] [PATCH] [linux-next] netfilter: kill remnants of ulog
	targets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, James Morris <jmorris@namei.org>, Patrick McHardy <kaber@trash.net>, Stephen Hemminger <stephen@networkplumber.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Fri, Jul 25, 2014 at 02:25:31PM +0200, Paul Bolle wrote:
> The ulog targets were recently killed. A few references to the Kconfig
> macros CONFIG_IP_NF_TARGET_ULOG and CONFIG_BRIDGE_EBT_ULOG were left
> untouched. Kill these too.

Those were my fault, applied, thanks Paul.
