Return-Path: <fw@strlen.de>
Date: Thu, 29 Sep 2016 04:25:20 +0200
From: Florian Westphal <fw@strlen.de>
Message-ID: <20160929022520.GH17426@breakpoint.cc>
References: <20160928220528.17478-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160928220528.17478-1-stefan@agner.ch>
Subject: Re: [Bridge] [PATCH] netfilter: bridge: clarify bridge/netfilter
	message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stefan Agner <stefan@agner.ch>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, pablo@netfilter.org

Stefan Agner <stefan@agner.ch> wrote:
> When using bridge without bridge netfilter enabled the message
> displayed is rather confusing and leads to belive that a deprecated
> feature is in use. Use IS_MODULE to be explicit that the message only
> affects users which use bridge netfilter as module and reword the
> message.

Acked-by: Florian Westphal <fw@strlen.de>

