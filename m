Return-Path: <pneira@us.es>
Date: Mon, 6 Nov 2017 14:50:02 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20171106135002.GA7055@salvia>
References: <20171016102402.10358-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016102402.10358-1-colin.king@canonical.com>
Subject: Re: [Bridge] [PATCH] netfilter: ebtables: clean up initialization
	of buf
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Colin King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, "David S . Miller" <davem@davemloft.net>

On Mon, Oct 16, 2017 at 11:24:02AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> buf is initialized to buf_start and then set on the next statement
> to buf_start + offsets[i].  Clean this up to just initialize buf
> to buf_start + offsets[i] to clean up the clang build warning:
> "Value stored to 'buf' during its initialization is never read"

Applied, thanks.
