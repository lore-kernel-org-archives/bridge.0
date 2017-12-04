Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 4 Dec 2017 06:20:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20171204052006.GF3307@otheros>
References: <20171125074418.16537-1-linus.luessing@c0d3.blue>
	<20171127233008.GA1418@salvia> <20171204045335.GE3307@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171204045335.GE3307@otheros>
Subject: Re: [Bridge] [PATCH net-next] bridge: ebtables: Avoid resetting
 limit rule state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

On Mon, Dec 04, 2017 at 05:53:35AM +0100, Linus Lüssing wrote:
> And so, no I do not have this patch. I looked at it now, but it
> does not seem to have any relation with .matchinfo, does it?

Relation between .usersize and .checkentry I ment, not
.usersize and .matchinfo.
