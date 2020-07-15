Return-Path: <pablo@netfilter.org>
Date: Wed, 15 Jul 2020 20:53:11 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20200715185311.GA19462@salvia>
References: <20200708200939.GA32508@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708200939.GA32508@embeddedor>
Subject: Re: [Bridge] [PATCH v2][next] netfilter: Use fallthrough
	pseudo-keyword
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Wed, Jul 08, 2020 at 03:09:39PM -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.

Applied, thanks.
