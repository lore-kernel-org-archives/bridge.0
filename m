Return-Path: <pablo@netfilter.org>
Date: Tue, 8 May 2018 14:17:10 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20180508121710.ivzfhxggbajyo4zr@salvia>
References: <20180427181609.3103-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427181609.3103-1-sthemmin@microsoft.com>
Subject: Re: [Bridge] [PATCH net] bridge: netfilter stp fix reference to
 uninitialized data
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, fw@strlen.de, netfilter-devel@vger.kernel.org, kadlec@blackhole.kfki.hu, davem@davemloft.net

On Fri, Apr 27, 2018 at 11:16:09AM -0700, Stephen Hemminger wrote:
> The destination mac (destmac) is only valid if EBT_DESTMAC flag
> is set. Fix by changing the order of the comparison to look for
> the flag first.

Applied, thanks Stephen.
