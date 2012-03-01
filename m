Return-Path: <pneira@us.es>
Date: Thu, 1 Mar 2012 13:30:04 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20120301123004.GA7250@1984>
References: <1330593434-19275-1-git-send-email-santoshprasadnayak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1330593434-19275-1-git-send-email-santoshprasadnayak@gmail.com>
Subject: Re: [Bridge] [PATCH 2/3] netfilter: potential null derefence.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: santosh nayak <santoshprasadnayak@gmail.com>
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, shemminger@vyatta.com

On Thu, Mar 01, 2012 at 02:47:14PM +0530, santosh nayak wrote:
> From: Santosh Nayak <santoshprasadnayak@gmail.com>
> 
> I am getting following error.
> " net/bridge/netfilter/ebtables.c:269 ebt_do_table()
>   error: potential null derefence 'cs'"
> 
>     i = cs[sp].n;  // If cs == Null then this will cause problem.

Very sorry, I didn't see the out label.

I'll apply this to my nf [1] once David takes my previous request for
pulling.

[1] http://1984.lsi.us.es/git/net
