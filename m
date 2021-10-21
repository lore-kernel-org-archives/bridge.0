Return-Path: <pablo@netfilter.org>
Date: Thu, 21 Oct 2021 20:16:03 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <YXGuY2LjiBb5M+jn@salvia>
References: <20210928200647.GA266402@embeddedor>
 <202110210958.6626A30@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202110210958.6626A30@keescook>
Subject: Re: [Bridge] [PATCH][net-next] netfilter: ebtables: use
 array_size() helper in copy_{from, to}_user()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

On Thu, Oct 21, 2021 at 10:00:34AM -0700, Kees Cook wrote:
> On Tue, Sep 28, 2021 at 03:06:47PM -0500, Gustavo A. R. Silva wrote:
> > Use array_size() helper instead of the open-coded version in
> > copy_{from,to}_user().  These sorts of multiplication factors
> > need to be wrapped in array_size().
> > 
> > Link: https://github.com/KSPP/linux/issues/160
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> I see that this is marked "Awaiting Upstream" (for an ebtables
> maintainer ack?)
> https://patchwork.kernel.org/project/netdevbpf/patch/20210928200647.GA266402@embeddedor/

I'll route this through the netfilter tree, thanks.
