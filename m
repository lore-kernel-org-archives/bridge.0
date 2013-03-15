Return-Path: <pneira@us.es>
Date: Fri, 15 Mar 2013 12:48:25 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20130315114825.GB8344@localhost>
References: <1363111893-25146-1-git-send-email-silviupopescu1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1363111893-25146-1-git-send-email-silviupopescu1990@gmail.com>
Subject: Re: [Bridge] [PATCH] bridge: netfilter: use PTR_RET instead of
 IS_ERR + PTR_ERR
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, stephen@networkplumber.org, netfilter@vger.kernel.org, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, kaber@trash.net

On Tue, Mar 12, 2013 at 08:11:33PM +0200, Silviu-Mihai Popescu wrote:
> This uses PTR_RET instead of IS_ERR and PTR_ERR in order to increase
> readability.

Also applied, thanks.
